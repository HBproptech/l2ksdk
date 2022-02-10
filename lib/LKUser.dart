class LKUser {
  String? firstname;
  String? lastname;
  String? email;
  String? phone;
  String? username;

  LKUser(
      {this.firstname, this.lastname, this.email, this.phone, this.username});

  Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "phone": phone,
        "username": username,
      };

  static LKUser fromJson(Map<String, dynamic> json) {
    return LKUser(
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
        phone: json["phone"],
        username: json["username"]);
  }
}
