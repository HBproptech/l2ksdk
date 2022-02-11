/////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
class LKPlace {
  String place;
  String address;
  LKLocation location;
  LKPlace({required this.place, required this.address, required this.location});

  Map<String, dynamic> toJson() {
    return {
      'place': place,
      'address': address,
      'location': location.toJson(),
    };
  }

  factory LKPlace.fromJson(Map<String, dynamic> map) {
    return LKPlace(
        place: map['place'] ?? '',
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
