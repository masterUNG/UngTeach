

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class TokenModel {
  final String token;
  final Timestamp timestampLogin;
  TokenModel({
    this.token,
    this.timestampLogin,
  });

  TokenModel copyWith({
    String token,
    Timestamp timestampLogin,
  }) {
    return TokenModel(
      token: token ?? this.token,
      timestampLogin: timestampLogin ?? this.timestampLogin,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'timestampLogin': timestampLogin,
    };
  }

  factory TokenModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return TokenModel(
      token: map['token'],
      timestampLogin: map['timestampLogin'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TokenModel.fromJson(String source) => TokenModel.fromMap(json.decode(source));

  @override
  String toString() => 'TokenModel(token: $token, timestampLogin: $timestampLogin)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is TokenModel &&
      o.token == token &&
      o.timestampLogin == timestampLogin;
  }

  @override
  int get hashCode => token.hashCode ^ timestampLogin.hashCode;
}
