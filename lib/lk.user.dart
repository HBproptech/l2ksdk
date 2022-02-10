//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
class LKUser {
  String civility;
  String firstname;
  String lastname;
  String email;
  String? picture;
  LKUser({
    required this.civility,
    required this.firstname,
    required this.lastname,
    required this.email,
    this.picture,
  });

  LKUser copyWith({
    String? civility,
    String? firstname,
    String? lastname,
    String? email,
    String? picture,
  }) {
    return LKUser(
      civility: civility ?? this.civility,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      picture: picture ?? this.picture,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'civility': civility,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'picture': picture,
    };
  }

  factory LKUser.fromJson(Map<String, dynamic> map) {
    return LKUser(
      civility: map['civility'] ?? '',
      firstname: map['firstname'] ?? '',
      lastname: map['lastname'] ?? '',
      email: map['email'] ?? '',
      picture: map['picture'],
    );
  }

  @override
  String toString() {
    return 'LKUser(civility: $civility, firstname: $firstname, lastname: $lastname, email: $email, picture: $picture)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LKUser &&
        other.civility == civility &&
        other.firstname == firstname &&
        other.lastname == lastname &&
        other.email == email &&
        other.picture == picture;
  }

  @override
  int get hashCode {
    return civility.hashCode ^
        firstname.hashCode ^
        lastname.hashCode ^
        email.hashCode ^
        picture.hashCode;
  }
}
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
