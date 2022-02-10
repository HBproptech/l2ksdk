import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'LKAccount.dart';
import 'package:http/http.dart' as http;

class LK {
  static const server = 'https://api.l2k.io';
  static String get authorizationApi => '$server/auth/authorization';
  static String get tokenApi => '$server/auth/token';
  static String clientId = '';
  static String clientSecret = '';

  void initialize({required String clientId, required String clientSecret}) {
    LK.clientId = clientId;
    LK.clientSecret = clientSecret;
  }

  void oldSignIn(String url, String clientId, String clientSecret) async {
    if (url.contains('code')) {
      final codeAuth = url.substring(url.indexOf('=') + 1, url.indexOf('&'));
      final state = url.substring(url.lastIndexOf('=') + 1);
      final response = await http.post(
          Uri.parse(
              "$tokenApi?client_id=$clientId&code=$codeAuth&state=$state"),
          body: {
            'client_secret': clientSecret,
            'client_id': clientId,
            'grant_type': 'authorization_code',
            'code': codeAuth
          },
          headers: {
            'content_type': 'application/json'
          });
      final json = jsonDecode(response.body);
      final String accessToken = json["access_token"];
      final String refreshToken = json["refresh_token"];
    }
  }

  Future<LKAccount?> signIn(BuildContext context) => showDialog(
      context: context,
      builder: (context) => Dialog(
          child: WebView(initialUrl: '$authorizationApi?client_id=$clientId')));
}
