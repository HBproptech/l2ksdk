import 'dart:convert';

import 'package:http/http.dart' as http;

import 'LKAccount.dart';
import 'LKMandate.dart';

class LKAgency {
  String id;
  String name;
  String email;
  String address;

  LKAgency(
      {required this.id,
      required this.name,
      required this.email,
      required this.address});

  Map<String, dynamic> toJson() =>
      {"id": id, "name": name, "email": email, "address": address};

  static LKAgency fromJson(Map<String, dynamic> json) {
    return LKAgency(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        address: json["address"]);
  }

  Future<List<LKMandate>> getMandates(LKAccount account) async {
    http.Response response = await http.get(Uri.parse('/mandates'),
        headers: {'Authorization': 'Bearer ${account.token}'});
    if (response.statusCode == 200) {
      return List<LKMandate>.from(
          List.from(jsonDecode(response.body)["mandats"])
              .map((e) => LKMandate.fromJson(e)));
    } else {
      return [];
    }
  }
}
