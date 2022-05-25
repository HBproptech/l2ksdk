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
  List<String> get tags {
    final List<String> tags = [];
    for (final list in description.values)
      if (list is Iterable)
        for (final t in list) {
          if (t is String) {
            tags.add(t);
          } else if (t is Map) {
            final String tag = t['tag'];
            if (t.containsKey('quality')) {
              tags.add('$tag${t['quality']}');
            } else if (t.containsKey('quantity')) {
              final unity = t['unity'];
              final quantity = t['quantity'];
              if (unity != null && unity.isNotEmpty) {
                tags.add('$tag$quantity$unity');
              } else {
                tags.add('$quantity$tag');
              }
            } else {
              tags.add(tag);
            }
          }
        }
    return tags;
  }

  List<LKPerson> persons;
  List<LKEnterprise> enterprises;

  LKGood(
      {required this.type,
      required this.description,
      required this.pictures,
      required this.persons,
      required this.enterprises});
  factory LKGood.fromJson(Map<String, dynamic> map) {
    return LKGood(
        type: map['type'] ?? '',
        description: Map<String, dynamic>.from(map['description']),
        pictures: List<String>.from(map['pictures']),
        persons:
            List.from(map['persons']).map((j) => LKPerson.fromJson(j)).toList(),
        enterprises: List.from(map['enterprises'])
            .map((j) => LKEnterprise.fromJson(j))
            .toList());
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
class LKPerson {
  static final List<String> civilities = ['M', 'Mme', 'Mlle', '?'];
  String id = '';
  String civility = '?';
  String firstname = '';
  String lastname = '';
  String job = '';
  String phone = '';
  String mobile = '';
  String email = '';
  String web = '';
  String comment = '';
  int meteo = 0;
  bool get isEmpty {
    return firstname.trim().isEmpty &&
        lastname.trim().isEmpty &&
        job.trim().isEmpty &&
        phone.trim().isEmpty &&
        email.trim().isEmpty &&
        web.trim().isEmpty &&
        mobile.isEmpty &&
        comment.isEmpty &&
        meteo == 0;
  }

  String capitalized(String s) {
    if (s.isEmpty) return '';
    return '${s[0].toUpperCase()}${s.substring(1).toLowerCase()}';
  }

  String get fullName => (civility != '?') ? '$civility. $name' : name;

  String get name => firstname.isNotEmpty
      ? '${capitalized(firstname)} ${capitalized(lastname)}'
      : capitalized(lastname);

  Set<String> get texts =>
      {firstname, lastname, job, comment, phone, mobile, email};

  static LKPerson fromJson(Map<String, dynamic> json) {
    LKPerson j = LKPerson();
    j.id = json['id'];
    var civ = json['civility'] ?? '';
    j.civility = civilities.contains(civ) ? civ : '?';
    j.firstname = json['firstname'] ?? '';
    j.lastname = json['lastname'] ?? '';
    j.job = json['job'] ?? '';
    j.phone = json['phone'] ?? '';
    j.mobile = json['mobile'] ?? '';
    j.email = json['email'] ?? '';
    j.web = json['web'] ?? '';
    j.comment = json['comment'] ?? '';
    j.meteo = json['meteo'] ?? 0;
    return j;
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////
class LKEnterprise {
  String id = '';
  String name = '';
  String status = '';
  String activity = '';
  String email = '';
  String phone = '';
  String fax = '';
  String web = '';
  String comments = '';
  bool get isEmpty {
    return name.trim().isEmpty;
  }

  Set<String> get texts =>
      {name, status, activity, email, phone, fax, comments};

  static LKEnterprise fromJson(Map<String, dynamic> json) {
    var j = LKEnterprise();
    j.id = json['id'];
    j.name = json['name'] ?? '';
    j.status = json['status'] ?? '';
    j.activity = json['activity'] ?? '';
    j.email = json['email'] ?? '';
    j.phone = json['phone'] ?? '';
    j.fax = json['fax'] ?? '';
    j.web = json['web'] ?? '';
    j.comments = json['comments'] ?? '';
    return j;
  }
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////

