// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'product_alias_create.g.dart';

@JsonSerializable()
class ProductAliasCreate {
  const ProductAliasCreate({required this.alias});

  factory ProductAliasCreate.fromJson(Map<String, Object?> json) =>
      _$ProductAliasCreateFromJson(json);

  final String alias;

  Map<String, Object?> toJson() => _$ProductAliasCreateToJson(this);
}
