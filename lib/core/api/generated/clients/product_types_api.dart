// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/barcode_result.dart';
import '../models/product_alias_create.dart';
import '../models/product_alias_out.dart';
import '../models/product_gtin_out.dart';
import '../models/product_type_create.dart';
import '../models/product_type_out.dart';
import '../models/product_type_update.dart';

part 'product_types_api.g.dart';

@RestApi()
abstract class ProductTypesApi {
  factory ProductTypesApi(Dio dio, {String? baseUrl}) = _ProductTypesApi;

  /// List Product Types
  @GET('/v1/product-types')
  Future<List<ProductTypeOut>> listProductTypesV1ProductTypesGet({
    @Query('category') String? category,
  });

  /// Create Product Type
  @POST('/v1/product-types')
  Future<ProductTypeOut> createProductTypeV1ProductTypesPost({
    @Body() required ProductTypeCreate body,
  });

  /// Lookup By Barcode.
  ///
  /// Check local DB first, then fall back to Open Food Facts.
  @GET('/v1/product-types/barcode/{gtin}')
  Future<BarcodeResult> lookupByBarcodeV1ProductTypesBarcodeGtinGet({
    @Path('gtin') required String gtin,
  });

  /// Search Product Types
  @GET('/v1/product-types/search')
  Future<List<ProductTypeOut>> searchProductTypesV1ProductTypesSearchGet({
    @Query('q') required String q,
    @Query('category') String? category,
  });

  /// Get Product Type
  @GET('/v1/product-types/{pt_id}')
  Future<ProductTypeOut> getProductTypeV1ProductTypesPtIdGet({
    @Path('pt_id') required String ptId,
  });

  /// Update Product Type
  @PATCH('/v1/product-types/{pt_id}')
  Future<ProductTypeOut> updateProductTypeV1ProductTypesPtIdPatch({
    @Path('pt_id') required String ptId,
    @Body() required ProductTypeUpdate body,
  });

  /// List Product Aliases.
  ///
  /// Otros nombres por los que la gente pide este producto.
  @GET('/v1/product-types/{pt_id}/aliases')
  Future<List<ProductAliasOut>> listProductAliasesV1ProductTypesPtIdAliasesGet({
    @Path('pt_id') required String ptId,
  });

  /// Add Product Alias.
  ///
  /// Agrega un alias. Solo administración nacional: el catálogo es global.
  @POST('/v1/product-types/{pt_id}/aliases')
  Future<ProductAliasOut> addProductAliasV1ProductTypesPtIdAliasesPost({
    @Path('pt_id') required String ptId,
    @Body() required ProductAliasCreate body,
  });

  /// Remove Product Alias.
  ///
  /// Quita un alias, incluidos los sembrados: uno equivocado arrastra al.
  /// producto equivocado en cada captura.
  @DELETE('/v1/product-types/{pt_id}/aliases/{alias_id}')
  Future<void> removeProductAliasV1ProductTypesPtIdAliasesAliasIdDelete({
    @Path('pt_id') required String ptId,
    @Path('alias_id') required String aliasId,
  });

  /// List Product Gtins.
  ///
  /// Códigos de barras asociados a un tipo de producto (aprendidos en captura).
  @GET('/v1/product-types/{pt_id}/gtins')
  Future<List<ProductGtinOut>> listProductGtinsV1ProductTypesPtIdGtinsGet({
    @Path('pt_id') required String ptId,
  });

  /// Unlink Product Gtin.
  ///
  /// Desliga un código capturado por error. El GTIN queda libre otra vez.
  @DELETE('/v1/product-types/{pt_id}/gtins/{gtin_id}')
  Future<void> unlinkProductGtinV1ProductTypesPtIdGtinsGtinIdDelete({
    @Path('pt_id') required String ptId,
    @Path('gtin_id') required String gtinId,
  });

  /// Promote Product Type.
  ///
  /// Promote a campaign-scoped ProductType to the global catalog (campaign_id → NULL).
  @POST('/v1/product-types/{pt_id}/promote')
  Future<ProductTypeOut> promoteProductTypeV1ProductTypesPtIdPromotePost({
    @Path('pt_id') required String ptId,
  });
}
