// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'pallet_add_box_in.g.dart';

@JsonSerializable()
class PalletAddBoxIn {
  const PalletAddBoxIn({required this.code});

  factory PalletAddBoxIn.fromJson(Map<String, Object?> json) =>
      _$PalletAddBoxInFromJson(json);

  final String code;

  Map<String, Object?> toJson() => _$PalletAddBoxInToJson(this);
}
