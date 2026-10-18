// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:json_annotation/json_annotation.dart';

part 'catalog_mapping_choice_in.g.dart';

/// Lo que el panel manda cuando alguien resuelve una sugerencia de mapeo:.
/// lo que se le mostró y lo que de verdad eligió, aceptara la sugerencia,.
/// la cambiara, o buscara/creara el producto por su cuenta.
@JsonSerializable()
class CatalogMappingChoiceIn {
  const CatalogMappingChoiceIn({
    required this.chosenProductTypeId,
    required this.freeText,
    this.suggestedProductTypeIds,
  });

  factory CatalogMappingChoiceIn.fromJson(Map<String, Object?> json) =>
      _$CatalogMappingChoiceInFromJson(json);

  @JsonKey(name: 'chosen_product_type_id')
  final String chosenProductTypeId;
  @JsonKey(name: 'free_text')
  final String freeText;
  @JsonKey(name: 'suggested_product_type_ids')
  final List<String>? suggestedProductTypeIds;

  Map<String, Object?> toJson() => _$CatalogMappingChoiceInToJson(this);
}
