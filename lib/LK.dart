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

  static void credentials(
      {required String clientId, required String clientSecret}) {
    LK.clientId = clientId;
    LK.clientSecret = clientSecret;
  }

  static Future<LKAccount?> signIn(BuildContext context) => showDialog(
      context: context,
      builder: (context) => Dialog(
          child: WebView(
              initialUrl: '$authorizationApi?client_id=$clientId',
              navigationDelegate: (req) async {
                if (req.url.contains('l2k://')) {
                  Navigator.pop(context, await _account(req.url));
                  return NavigationDecision.prevent;
                }
                return NavigationDecision.navigate;
              })));

  static Future<LKAccount?> _account(String url) async {
    if (url.contains('code')) {
      final uri = Uri.parse(url);
      final code = uri.queryParameters['code'];
      final state = uri.queryParameters['state'];
      final response = await http.post(Uri.parse(tokenApi), body: {
        'client_id': clientId,
        'client_secret': clientSecret,
        'grant_type': 'authorization_code',
        'code': code,
        'state': state
      }, headers: {
        'content_type': 'application/json'
      });
      final json = jsonDecode(response.body);
      return LKAccount.fromJson(json);
      //final String accessToken = json["access_token"];
      //final String refreshToken = json["refresh_token"];
    }
    return null;
  }
}
