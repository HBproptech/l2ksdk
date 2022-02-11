import 'lk.place.dart';

//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
class LKAgency {
  String id;
  String name;
  String type;
  LKAgencyContact contact;
  LKPlace place;
  LKAgency({
    required this.id,
    required this.name,
    required this.type,
    required this.contact,
    required this.place,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'contact': contact.toJson(),
      'geoloc': place.toJson(),
    };
  }

  factory LKAgency.fromJson(Map<String, dynamic> map) {
    return LKAgency(
        id: map['id'] ?? '',
        name: map['name'] ?? '',
        type: map['type'] ?? '',
        contact: LKAgencyContact.fromJson(map['contact']),
        place: LKPlace.fromJson(map['geoloc']));
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
class LKAgencyContact {
  String email;
  String phone;
  String fax;
  String web;
  LKAgencyContact({
    required this.email,
    required this.phone,
    required this.fax,
    required this.web,
  });
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'phone': phone,
      'fax': fax,
      'web': web,
    };
  }

  factory LKAgencyContact.fromJson(Map<String, dynamic> map) {
    return LKAgencyContact(
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      fax: map['fax'] ?? '',
      web: map['web'] ?? '',
    );
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
