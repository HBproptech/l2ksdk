import 'package:l2ksdk/lk.place.dart';

//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
class LKMandate {
  String id;
  LKPlace place;
  LKProject project;
  LKGood good;
  LKMandate(
      {required this.id,
      required this.place,
      required this.project,
      required this.good});
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'place': place.toJson(),
      'project': project.toJson(),
      'good': good.toJson()
    };
  }

  factory LKMandate.fromJson(Map<String, dynamic> map) {
    return LKMandate(
        id: map['id'] ?? '',
        place: LKPlace.fromJson(map['place']),
        project: LKProject.fromJson(map['project']),
        good: LKGood.fromJson(map['good']));
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
class LKProject {
  String id;
  String type;
  LKProject({
    required this.id,
    required this.type,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
    };
  }

  factory LKProject.fromJson(Map<String, dynamic> map) {
    return LKProject(
      id: map['id'] ?? '',
      type: map['type'] ?? '',
    );
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
class LKGood {
  String type;
  Map<String, dynamic> description;
  List<String> pictures;
  LKGood({
    required this.type,
    required this.description,
    required this.pictures,
  });
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'description': description,
      'pictures': pictures,
    };
  }

  factory LKGood.fromJson(Map<String, dynamic> map) {
    return LKGood(
      type: map['type'] ?? '',
      description: Map<String, dynamic>.from(map['description']),
      pictures: List<String>.from(map['pictures']),
    );
  }
}
/////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
