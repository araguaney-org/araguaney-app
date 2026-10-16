// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'product_alias_out.g.dart';

@JsonSerializable()
class ProductAliasOut {
  const ProductAliasOut({
    required this.alias,
    required this.createdAt,
    required this.id,
    required this.source,
  });

  factory ProductAliasOut.fromJson(Map<String, Object?> json) =>
      _$ProductAliasOutFromJson(json);

  final String alias;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  final String id;
  final String source;

  Map<String, Object?> toJson() => _$ProductAliasOutToJson(this);
}
