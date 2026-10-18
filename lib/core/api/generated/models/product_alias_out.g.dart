// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_alias_out.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductAliasOut _$ProductAliasOutFromJson(Map<String, dynamic> json) =>
    ProductAliasOut(
      alias: json['alias'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      id: json['id'] as String,
      source: json['source'] as String,
    );

Map<String, dynamic> _$ProductAliasOutToJson(ProductAliasOut instance) =>
    <String, dynamic>{
      'alias': instance.alias,
      'created_at': instance.createdAt.toIso8601String(),
      'id': instance.id,
      'source': instance.source,
    };
