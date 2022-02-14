Leads 2 Keys - API

# Usage

This package is for clients of the real-estate prospecting app, Leads2Keys. Through this package, you will be able to access many informations linked to your agency in Leads2Keys : agents, mandates, leads, etc.

First, you'll have to add the package as a dependency in your pubspec.yaml and run flutter pub. Then you will be set to use the different methods included in the package.

## Login and retrieve an access token

Leads2KeysApi uses OAuth02 to successfully connect users. To create a login, you just have to call the LK.signIn method. 
Before calling the signIn, you will have to instanciate in your app your clientId and clientSecret, needed for the auth. These informations have been given to you by the Leads2Keys team. In the example app, they are instanciated by calling LK.credentials and filling the arguments :

```dart
LK.credentials(
      clientId: 'flutter',
      clientSecret: 'b076542a-13dd-4d7d-aed6-b4a741f6de8f');
```

Then you can call the signIn. This method will handle everything : call the silentSignIn if you've been logged before, and if not, using your clientId to open a webwiew where you will enter your connexion ids to Leads2Keys.


```dart
static Future<LKAccount?> signIn(BuildContext context) async {
    final account = await silentSignIn();
    if (account != null) return account;
    return await showDialog(
        context: context,
        builder: (context) => Dialog(
            child: WebView(
                initialUrl: '$authorizationApi?client_id=$clientId',
                navigationDelegate: (req) async {
                  if (req.url.contains('l2k://')) {
                    try {
                      final uri = Uri.parse(req.url);
                      final code = uri.queryParameters['code']!;
                      final state = uri.queryParameters['state']!;
                      final token = await _token(code: code, state: state);
                      await storage.write(
                          key: storageKey, value: jsonEncode(token.toJson()));
                      final account = await _account(token);
                      Navigator.pop(context, account);
                    } catch (error) {
                      dev.log(error.toString());
                    }
                    return NavigationDecision.prevent;
                  }
                  return NavigationDecision.navigate;
                })));
  }
```

Once the token is retrieved from the API, the API will be called using this token, to retrieve your account and create an instance of LKAccount.

```dart
static Future<LKAccount> _account(LKToken token) async {
    final response = await http.get(Uri.parse(accountApi),
        headers: {'Authorization': 'Bearer ${token.access}'});
    final json = jsonDecode(response.body);
    if (response.statusCode != 200) throw json['error'];
    return LKAccount.fromJson(json, token: token);
  }
  ```

## Login with a previously logged account

If the account is still stored, the signIn method will trigger the silentSignIn method, which will return the account and refresh the token without any interaction with the user.

```dart
static Future<LKAccount?> silentSignIn() async {
    final data = await storage.read(key: storageKey);
    if (data == null) return null;
    final token = LKToken.fromJson(jsonDecode(data));
    try {
      final ntoken = await _refresh(token);
      await storage.write(key: storageKey, value: jsonEncode(ntoken.toJson()));
      return _account(ntoken);
    } catch (error) {
      dev.log('silentSignIn()', error: error);
    }
    return null;
  }
```
## Signout

The signOut method will delete everything contained in the storage.

```dart
static Future<void> signOut() async {
    await storage.delete(key: storageKey);
  }
  ```

## Access mandates

Through your created account, you will now be able to retrieve mandates infos, using this method.

```dart
Future<Iterable<LKMandate>> mandates({required LKAgency agency}) async {
    final response = await http.get(Uri.parse(LK.mandatesApi(agency)),
        headers: {'Authorization': 'Bearer ${token.access}'});
    final json = jsonDecode(response.body);
    if (response.statusCode != 200) throw json['error'];
    final List<dynamic> md = json;
    if (md.isEmpty) return [];
    return md.map((j) => LKMandate.fromJson(j));
  ```
The LKMandate class itself contains all the informations you need.

```dart
String id;
  LKPlace place;
  LKProject project;
  LKGood good;
  ```

In the example app, this will show a list with the project type, the good type and place adress for each mandate contained in the list fetched from the API.

```dart
if (mandates.isNotEmpty) ...[
              space,
              ...mandates.map((m) => Column(children: [
                    Text('${m.project.type} ${m.good.type}'),
                    Text(m.place.address),
                    space
                  ]

```

# Examples

For more examples, you can use the [example app](https://github.com/HBproptech/l2ksdk/tree/master/example)

