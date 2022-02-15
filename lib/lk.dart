import 'dart:convert';
import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:l2ksdk/l2ksdk.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

import 'lk.token.dart';

//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
class LK {
  static const storage = FlutterSecureStorage();
  static const storageKey = 'l2k.account.token';
  static const server = 'http://account1.l2k.io:4002'; // 'https://api.l2k.io';
  static String get authorizationApi => '$server/auth/authorization';
  static String get tokenApi => '$server/auth/token';
  static String get accountApi => '$server/account';
  static String mandatesApi(LKAgency agency) =>
      '$server/agency/${agency.id}/mandates';
  static String documentApi(String id) => '$server/document/$id';

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

  static Future<LKAccount?> signIn(BuildContext context) async {
    final account = await silentSignIn();
    if (account != null) return account;
    return await showDialog(
        context: context,
        builder: (context) => Dialog(
            backgroundColor: Colors.transparent,
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: Container(
                    height: 500,
                    child: WebView(
                        initialUrl: '$authorizationApi?client_id=$clientId',
                        navigationDelegate: (req) async {
                          if (req.url.contains('l2k://')) {
                            try {
                              final uri = Uri.parse(req.url);
                              final code = uri.queryParameters['code']!;
                              final state = uri.queryParameters['state']!;
                              final token =
                                  await _token(code: code, state: state);
                              await storage.write(
                                  key: storageKey,
                                  value: jsonEncode(token.toJson()));
                              final account = await _account(token);
                              Navigator.pop(context, account);
                            } catch (error) {
                              dev.log(error.toString());
                            }
                            return NavigationDecision.prevent;
                          }
                          return NavigationDecision.navigate;
                        })))));
  }

  static Future<void> signOut() async {
    await storage.delete(key: storageKey);
  }

  static Future<LKAccount> _account(LKToken token) async {
    final response = await http.get(Uri.parse(accountApi),
        headers: {'Authorization': 'Bearer ${token.access}'});
    final json = jsonDecode(response.body);
    if (response.statusCode != 200) throw json['error'];
    return LKAccount.fromJson(json, token: token);
  }

  static Future<LKToken> _refresh(LKToken token) async {
    final response = await http.post(Uri.parse(tokenApi), body: {
      'client_id': clientId,
      'client_secret': clientSecret,
      'grant_type': 'refresh_token',
      'refresh_token': token.refresh
    }, headers: {
      'Content-Type': 'application/x-www-form-urlencoded'
    });
    final json = jsonDecode(response.body);
    if (response.statusCode != 200) throw json['error'];
    return LKToken.fromJson(json);
  }

  static Future<LKToken> _token(
      {required String code, required String state}) async {
    final response = await http.post(Uri.parse(tokenApi), body: {
      'client_id': clientId,
      'client_secret': clientSecret,
      'grant_type': 'authorization_code',
      'code': code,
      'state': state
    }, headers: {
      'Content-Type': 'application/x-www-form-urlencoded'
    });
    final json = jsonDecode(response.body);
    if (response.statusCode != 200) throw json['error'];
    return LKToken.fromJson(json);
  }
}
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
