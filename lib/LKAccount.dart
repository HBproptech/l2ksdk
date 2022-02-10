
import 'LKAgency.dart';
import 'LKUser.dart';

class LKAccount {
  String id;
  String token;
  String refreshToken;
  LKUser user;
  LKAgency agency;

  LKAccount(
      {required this.id,
      required this.token,
      required this.refreshToken,
      required this.user,
      required this.agency});

  Map<String, dynamic> toJson() => {
        "id": id,
        "token": token,
        "refreshToken": refreshToken,
        "user": user,
        "agency": agency
      };

  static LKAccount fromJson(Map<String, dynamic> json) {
    return LKAccount(
        id: json["id"],
        token: json["token"],
        refreshToken: json["refreshToken"],
        user: LKUser.fromJson(json["user"]),
        agency: LKAgency.fromJson(json["agency"]));
  }
}
