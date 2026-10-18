// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog_mapping_choice_in.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CatalogMappingChoiceIn _$CatalogMappingChoiceInFromJson(
  Map<String, dynamic> json,
) => CatalogMappingChoiceIn(
  chosenProductTypeId: json['chosen_product_type_id'] as String,
  freeText: json['free_text'] as String,
  suggestedProductTypeIds:
      (json['suggested_product_type_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
);

Map<String, dynamic> _$CatalogMappingChoiceInToJson(
  CatalogMappingChoiceIn instance,
) => <String, dynamic>{
  'chosen_product_type_id': instance.chosenProductTypeId,
  'free_text': instance.freeText,
  'suggested_product_type_ids': instance.suggestedProductTypeIds,
};
