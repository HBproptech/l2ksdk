# Leads 2 Keys - Flutter SDK

This package is for partners of the real-estate prospecting app [Leads2Keys](https://leads2keys.com/). 

# Usage

  Add the package as a dependency in your **pubspec.yaml** and run **flutter pub get**. 

## Setup credentials

Leads2KeysApi uses **OAuth02** to successfully connect users. 
You need to setup your credentials using **LK.credentials()**.

You can contact us at apil2k@leads2keys.com to request your credentials.

```dart
  LK.credentials(clientId: 'your client id', clientSecret: 'your client secret');
```

## User signin

You can call the LK.signIn() method that will popup a form for user signin and authorization.


```dart
  final account = await LK.signIn(context);
```


## Silent signin with a previously logged account

When returning to your app you can use the silentSignIn method, which will silently returns the account without any user interaction.

```dart
  final account = await LK.silentSignIn();
```

## Signout from a previously logged account

```dart
  await LK.signOut();
  ```
## Access mandates

Then using the account you can retrieve the mandates by agencies.

```dart
 final mandates = await account.mandates(agency:account.agencies.first);

  ```
The LKMandate class itself contains all the informations you need.

```dart
  String id;
  LKPlace place;
  LKProject project;
  LKGood good;
  ```

# Examples

For more examples, you can look at the [example app](https://github.com/HBproptech/l2ksdk/tree/master/example)

# Rest API 

[Leads2Keys API](https://api.l2k.io/documentation)

