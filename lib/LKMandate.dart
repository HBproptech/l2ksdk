import 'LKAgency.dart';

class LKMandate {
  String id;
  LKAgency agency;
  String type;
  DateTime expiration;
  String numero;
  String name;

  LKMandate(
      {required this.id,
      required this.agency,
      required this.type,
      required this.expiration,
      required this.numero,
      required this.name});

  Map<String, dynamic> toJson() => {
        "id": id,
        "agency": agency,
        "type": type,
        "expiration": expiration.toIso8601String(),
        "numero": numero,
        "name": name
      };

  static LKMandate fromJson(Map<String, dynamic> json) {
    return LKMandate(
        id: json["id"],
        agency: LKAgency.fromJson(json["lastname"]),
        type: json["type"],
        expiration: DateTime.parse(json["expiration"]),
        numero: json["numero"],
        name: json["name"]);
  }
}
