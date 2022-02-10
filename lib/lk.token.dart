//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
class LKToken {
  String access;
  String refresh;
  LKToken({
    required this.access,
    required this.refresh,
  });

  LKToken copyWith({
    String? access,
    String? refresh,
  }) {
    return LKToken(
      access: access ?? this.access,
      refresh: refresh ?? this.refresh,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': access,
      'refresh_token': refresh,
    };
  }

  factory LKToken.fromJson(Map<String, dynamic> map) {
    return LKToken(
      access: map['access_token'] ?? '',
      refresh: map['refresh_token'] ?? '',
    );
  }

  @override
  String toString() => 'LKToken(access: $access, refresh: $refresh)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LKToken &&
        other.access == access &&
        other.refresh == refresh;
  }

  @override
  int get hashCode => access.hashCode ^ refresh.hashCode;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
