import 'package:l2ksdk/lk.building.dart';

/////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
class LKAgencyPlace {
  String id;
  String address;
  String name;
  List<LKBuilding>? buildings;
  LKAgencyPlace({
    required this.id,
    required this.address,
    required this.name,
    this.buildings,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'address': address,
      'location': name,
      'immeuble': buildings?.map((x) => x.toJson()).toList(),
    };
  }

  factory LKAgencyPlace.fromJson(Map<String, dynamic> map) {
    return LKAgencyPlace(
      id: map['id'] ?? '',
      address: map['address'] ?? '',
      name: map['name'] ?? '',
      buildings: map['buildings'] != null
          ? List<LKBuilding>.from(
              map['immeuble']?.map((x) => LKBuilding.fromJson(x)))
          : null,
    );
  }
}


////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
