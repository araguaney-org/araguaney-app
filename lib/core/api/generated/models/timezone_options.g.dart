// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timezone_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimezoneOptions _$TimezoneOptionsFromJson(Map<String, dynamic> json) =>
    TimezoneOptions(
      countryCode: json['country_code'] as String?,
      timezones: (json['timezones'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$TimezoneOptionsToJson(TimezoneOptions instance) =>
    <String, dynamic>{
      'country_code': instance.countryCode,
      'timezones': instance.timezones,
    };
