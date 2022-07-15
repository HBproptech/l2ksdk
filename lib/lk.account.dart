import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:l2ksdk/lk.agency.place.dart';
import 'package:l2ksdk/lk.project.dart';
import 'package:l2ksdk/lk.place.dart';
import 'package:l2ksdk/lk.token.dart';
import 'package:http/http.dart' as http;

import 'lk.agency.dart';
import 'lk.dart';
import 'lk.user.dart';

//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
class LKAccount {
  LKToken token;
  String id;
  LKUser user;
  List<LKAgency> agencies;

  Widget avatar(BuildContext context) =>
      user.picture != null && user.picture!.isNotEmpty
          ? Container()
          : Container();

  Future<String> refresh() async {
    final response = await http.get(Uri.parse(LK.refreshApi),
        headers: {'Authorization': 'Bearer ${token.access}'});
    return response.body;
  }

  Future<Iterable<LKProjectDesc>> mandates({required LKAgency agency}) async {
    final response = await http.get(Uri.parse(LK.mandatesApi(agency)),
        headers: {'Authorization': 'Bearer ${token.access}'});
    final json = jsonDecode(response.body);
    if (response.statusCode != 200) throw json['error'];
    final List<dynamic> md = json;
    if (md.isEmpty) return [];
    return md.map((j) => LKProjectDesc.fromJson(j));
  }

  Future<Iterable<LKProjectDesc>> projects(
      {required LKAgency agency, DateTime? begin, DateTime? end}) async {
    final response = await http.get(
        Uri.parse(LK.projectsApi(agency, begin: begin, end: end)),
        headers: {'Authorization': 'Bearer ${token.access}'});
    final json = jsonDecode(response.body);
    if (response.statusCode != 200) throw json['error'];
    final List<dynamic> md = json;
    if (md.isEmpty) return [];
    return md.map((j) => LKProjectDesc.fromJson(j));
  }

  Future<LKPlace> searchPlace(
      {required String postcode,
      required String street,
      required String number}) async {
    final response = await http.get(
        Uri.parse(LK.searchPlaceApi(
            postcode: postcode, street: street, number: number)),
        headers: {'Authorization': 'Bearer ${token.access}'});
    final json = jsonDecode(response.body);
    if (response.statusCode != 200) throw json['error'];
    return LKPlace.fromJson(json);
  }

  Future<Set<String>> placesId(
      {required LKAgency agency, int skip = 0, int limit = 1}) async {
    final response = await http.get(
        Uri.parse(LK.placesApi(agency, skip: skip, limit: limit)),
        headers: {'Authorization': 'Bearer ${token.access}'});
    final json = jsonDecode(response.body);
    if (response.statusCode != 200) throw json['error'];
    final places = json['result'];
    return Set<String>.from(places);
  }

  Future<LKAgencyPlace> agencyPlaceFromId(
      {required LKAgency agency, required String id}) async {
    final response = await http.get(Uri.parse(LK.placeApi(agency, id)),
        headers: {'Authorization': 'Bearer ${token.access}'});
    final json = jsonDecode(response.body);
    if (response.statusCode != 200) throw json['error'];
    return LKAgencyPlace.fromJson(json['value']);
  }

  Widget document(String id, {DocSize size = DocSize.original}) =>
      Image(image: documentProvider(id, size: size));

  ImageProvider documentProvider(String id,
          {DocSize size = DocSize.original}) =>
      NetworkImage(
          size == DocSize.original
              ? LK.documentApi(id)
              : LK.documentApi(id, size: size.value.toString()),
          headers: {'Authorization': 'Bearer ${token.access}'});

  LKAccount({
    required this.token,
    required this.id,
    required this.user,
    required this.agencies,
  });

  Map<String, dynamic> toJson() {
    return {
      'token': token.toJson(),
      'id': id,
      'user': user.toJson(),
      'agencies': agencies.map((x) => x.toJson()).toList(),
    };
  }

  factory LKAccount.fromJson(Map<String, dynamic> map, {LKToken? token}) {
    return LKAccount(
        token: token ?? LKToken.fromJson(map['token']),
        id: map['id'] ?? '',
        user: LKUser.fromJson(map['user']),
        agencies: List<LKAgency>.from(
            map['agencies']?.map((x) => LKAgency.fromJson(x))));
  }

  @override
  String toString() => 'LKAccount(id: $id, user: $user, agencies: $agencies)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LKAccount &&
        other.id == id &&
        other.user == user &&
        listEquals(other.agencies, agencies);
  }

  @override
  int get hashCode => id.hashCode ^ user.hashCode ^ agencies.hashCode;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
enum DocSize { s128, s256, s512, original }

extension DocSizeExt on DocSize {
  static const Map<DocSize, int> _sizes = {
    DocSize.original: 0,
    DocSize.s128: 128,
    DocSize.s256: 256,
    DocSize.s512: 512
  };
  int get value => _sizes[this]!;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
