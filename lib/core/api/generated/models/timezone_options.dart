// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'timezone_options.g.dart';

/// Zonas para elegir al dar de alta un centro, acotadas por país.
@JsonSerializable()
class TimezoneOptions {
  const TimezoneOptions({required this.countryCode, required this.timezones});

  factory TimezoneOptions.fromJson(Map<String, Object?> json) =>
      _$TimezoneOptionsFromJson(json);

  @JsonKey(name: 'country_code')
  final String? countryCode;
  final List<String> timezones;

  Map<String, Object?> toJson() => _$TimezoneOptionsToJson(this);
}
