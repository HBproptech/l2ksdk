import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'LKAccount.dart';
import 'package:http/http.dart' as http;

class LK {
  static const storage = FlutterSecureStorage();
  static const storageKey = 'l2k.account';
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

  static Future<LKAccount?> silentSignIn() async {
    final data = await storage.read(key: storageKey);
    if (data == null) return null;
    return LKAccount.fromJson(jsonDecode(data));
  }

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
                    final account = await _account(req.url);
                    if (account != null) {
                      await storage.write(
                          key: storageKey, value: jsonEncode(account.toJson()));
                    }
                    Navigator.pop(context, account);
                    return NavigationDecision.prevent;
                  }
                  return NavigationDecision.navigate;
                })));
  }

  static Future<void> signOut() async {
    await storage.delete(key: storageKey);
  }

  static Future<LKAccount?> _account(String url) async {
    if (url.contains('code')) {
      final uri = Uri.parse(url);
      final code = uri.queryParameters['code'];
      final state = uri.queryParameters['state'];
      final response = await http.post(Uri.parse(tokenApi),
          body: jsonEncode({
            'client_id': clientId,
            'client_secret': clientSecret,
            'grant_type': 'authorization_code',
            'code': code,
            'state': state
          }),
          headers: {'content_type': 'application/json'});
      final json = jsonDecode(response.body);
      return LKAccount.fromJson(json);
      //final String accessToken = json["access_token"];
      //final String refreshToken = json["refresh_token"];
    }
    return null;
  }
}
