//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
class LKMandate {
  String id;
  String type;
  DateTime expiration;
  String numero;
  String name;

  LKMandate(
      {required this.id,
      required this.type,
      required this.expiration,
      required this.numero,
      required this.name});

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "expiration": expiration.toIso8601String(),
        "numero": numero,
        "name": name
      };

  static LKMandate fromJson(Map<String, dynamic> json) {
    return LKMandate(
        id: json["id"],
        type: json["type"],
        expiration: DateTime.parse(json["expiration"]),
        numero: json["numero"],
        name: json["name"]);
  }
}
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
