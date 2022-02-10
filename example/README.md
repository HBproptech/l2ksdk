Leads 2 Keys - API

**But**

Ce package est dédié aux clients de l'application de prospection immobilière Leads2Keys. Cela vous permet d'accéder directement aux données contenues pour votre agence dans l'API : agents, mandats, leads, etc.

**Utilisation**

Une fois le package importé dans votre application, vous pourrez accéder aux différentes classes contenues dans le package Leads2Keys. Mais pour faire appel à l'API, il faut tout d'abord réaliser une authentification en OAuth02.

Il faut tout d'abord faire appel à https://api.l2k.io/auth/authorization?client_id=, en y ajoutant votre clientId (transmis par Leads2Keys au préalable). Cela va vous rediriger vers la page de connexion à l'API, qui va rediriger vers l'API une fois la connexion effectuée avec vos identifiants de compte Leads2Keys. L'application exemple implémente ainsi cela en ouvrant une webview dans un dialog. La webview va détecter la redirection vers l'API et appeler la méthode L2K.signIn, avec l'url, le clientId et le clientSecret (également fournis) en paramètres :

```dart
class WebviewLogin extends StatelessWidget {
  final String? url;
  final String clientId;
  final String clientSecret;

  const WebviewLogin(this.clientId, this.clientSecret, this.url, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WebView(
        initialUrl: url,
        navigationDelegate: (navigation) async {
          if (navigation.url.startsWith('l2k://')) {
            L2K().signIn(navigation.url, clientId, clientSecret);
            NavigationDecision.prevent;
            Navigator.pop(context);
            return NavigationDecision.prevent;
          } else {
            return NavigationDecision.navigate;
          }
        });
  }
}
```

La méthode L2K.signIn se charge ensuite de récupérer un code d'authentification et de l'échanger pour récupérer un access token et un refresh token, qui seront liés au LKAccount également récupéré. Cet account va permettre d'accéder aux différentes classes comme LKMandate et aux méthodes qu'elles contiennent. Par exemple, pour récupérer tous les mandats d'une agence sous la forme d'une liste de LKMandate :

```dart
Future<List<LKMandate>?> getMandates(LKAccount account) async {
    http.Response response = await http
        .get(Uri.parse('/mandates'), headers: {'access_token': account.token});
    if (response.statusCode == 200) {
      return List<LKMandate>.from(
          List.from(jsonDecode(response.body)["mandats"])
              .map((e) => LKMandate.fromJson(e)));
    } else
      return null;
  }
  ```


