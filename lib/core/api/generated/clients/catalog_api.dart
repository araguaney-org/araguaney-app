// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/barcode_result.dart';
import '../models/catalog_mapping_choice_in.dart';
import '../models/product_type_out.dart';
import '../models/rx_norm_suggestion.dart';

part 'catalog_api.g.dart';

@RestApi()
abstract class CatalogApi {
  factory CatalogApi(Dio dio, {String? baseUrl}) = _CatalogApi;

  /// Barcode Lookup.
  ///
  /// Look up a barcode: local DB first, then Open Food Facts with 24-hour Redis cache.
  @GET('/v1/catalog/barcode/{gtin}')
  Future<BarcodeResult> barcodeLookupV1CatalogBarcodeGtinGet({
    @Path('gtin') required String gtin,
  });

  /// Record Mapping Choice.
  ///
  /// El panel llama esto cuando alguien resuelve una sugerencia de mapeo de.
  /// texto libre — la aceptó, la cambió, o buscó/creó el producto por su.
  /// cuenta. Es la única forma de que exista un conjunto de evaluación con.
  /// datos reales (Fase 23, task 8) en vez de casos escritos a mano.
  @POST('/v1/catalog/mapping-choices')
  Future<void> recordMappingChoiceV1CatalogMappingChoicesPost({
    @Body() required CatalogMappingChoiceIn body,
  });

  /// Rxnorm Search.
  ///
  /// INN autocomplete via NLM RxNorm (no API key). Cached 1 h in Redis.
  @GET('/v1/catalog/rxnorm')
  Future<List<RxNormSuggestion>> rxnormSearchV1CatalogRxnormGet({
    @Query('q') required String q,
  });

  /// Catalog Search.
  ///
  /// Search local catalog (global products + campaign-scoped products).
  ///
  /// When campaign_id is supplied, validates that the current user belongs to.
  /// that campaign before returning scoped results.
  @GET('/v1/catalog/search')
  Future<List<ProductTypeOut>> catalogSearchV1CatalogSearchGet({
    @Query('campaign_id') String? campaignId,
    @Query('category') String? category,
    @Query('q') String? q = '',
  });
}
