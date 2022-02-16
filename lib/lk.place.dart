/////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
class LKPlace {
  String id;
  String address;
  LKLocation location;
  LKPlace({required this.id, required this.address, required this.location});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'address': address,
      'location': location.toJson(),
    };
  }

  factory LKPlace.fromJson(Map<String, dynamic> map) {
    return LKPlace(
        id: map['place'] ?? map['id'] ?? '',
        address: map['address'] ?? '',
        location: LKLocation.fromJson(map['location']));
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
class LKLocation {
  double latitude;
  double longitude;
  LKLocation({
    required this.latitude,
    required this.longitude,
  });
  Map<String, dynamic> toJson() {
    return {'latitude': latitude, 'longitude': longitude};
  }

  factory LKLocation.fromJson(Map<String, dynamic> map) {
    return LKLocation(
      latitude: map['latitude']?.toDouble() ?? map['lat']?.toDouble() ?? 0.0,
      longitude: map['longitude']?.toDouble() ?? map['lng']?.toDouble() ?? 0.0,
    );
  }
}
////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
