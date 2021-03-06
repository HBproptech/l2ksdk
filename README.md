# Leads2Keys - Flutter SDK

This package is for [Leads2Keys](https://leads2keys.com/) real-estate survey app partners. 

# Usage

  Add the package as dependency in your **pubspec.yaml** and run **flutter pub get**. 

## Setup credentials

Leads2KeysApi uses **OAuth02** to successfully connect users. 
You need to setup your credentials using **LK.credentials()**.

```dart
  LK.credentials(clientId: 'your client id', clientSecret: 'your client secret');
```
*You can contact us at apil2k@leads2keys.com to request your credentials.*


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

Then using the account you can retrieve the mandates by agency.

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

## Retrieving images

```dart
  final Widget image = account.document(imageId);
  ```

# Examples

For more detailled information you can take a look at our [example app](https://github.com/HBproptech/l2ksdk/tree/master/example)

# Rest API 

[Leads2Keys API](https://api.l2k.io/documentation)


# Copyright 
2022 HB PropTech & innovation

[HBproptech.com](https://hbproptech.com/)