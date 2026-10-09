import 'dart:convert';

import 'package:equatable/equatable.dart';

Access accessFromJson(String str) => Access.fromJson(json.decode(str));

String accessToJson(Access data) => json.encode(data.toJson());

final class Access extends Equatable {
  const Access({required this.result, required this.resultCode});

  final String result;
  final String resultCode;

  factory Access.fromJson(Map<String, dynamic> json) => Access(
    result: json['result'] ?? '',
    resultCode: json['resultCode'] ?? '',
  );

  Map<String, dynamic> toJson() => {'result': result, 'resultCode': resultCode};

  @override
  List<Object?> get props => [result, resultCode];
}
