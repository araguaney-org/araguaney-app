// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/center_create.dart';
import '../models/center_out.dart';
import '../models/center_update.dart';
import '../models/timezone_options.dart';

part 'centers_api.g.dart';

@RestApi()
abstract class CentersApi {
  factory CentersApi(Dio dio, {String? baseUrl}) = _CentersApi;

  /// List Centers
  @GET('/v1/centers')
  Future<List<CenterOut>> listCentersV1CentersGet({
    @Query('country_code') String? countryCode,
    @Query('active_only') bool? activeOnly = false,
  });

  /// Create Center
  @POST('/v1/centers')
  Future<CenterOut> createCenterV1CentersPost({
    @Body() required CenterCreate body,
  });

  /// List Timezones.
  ///
  /// Zonas IANA de un país (todas, sin país) para el formulario del centro.
  ///
  /// Va antes de `/{center_id}`: si no, la ruta la tomaría como un id.
  @GET('/v1/centers/timezones')
  Future<TimezoneOptions> listTimezonesV1CentersTimezonesGet({
    @Query('country_code') String? countryCode,
  });

  /// Get Center
  @GET('/v1/centers/{center_id}')
  Future<CenterOut> getCenterV1CentersCenterIdGet({
    @Path('center_id') required String centerId,
  });

  /// Update Center
  @PATCH('/v1/centers/{center_id}')
  Future<CenterOut> updateCenterV1CentersCenterIdPatch({
    @Path('center_id') required String centerId,
    @Body() required CenterUpdate body,
  });
}
