import 'dart:async';
import 'dart:convert';

import 'package:jsonable_object/jsonable_object.dart';
import 'package:shelf/shelf.dart';

class ShelfRequestResponse2JsonUtility<T extends IConvertToJson> {
  final IFactoryObjectFromJson<T> convert;
  static const Map<String, String> _jsonContentType = {
    'content-Type': 'application/json'
  };

  const ShelfRequestResponse2JsonUtility(this.convert);

  /// Extract body from Shelf.Request
  FutureOr<T> body(Request request) async {
    final jsonString = await request.readAsString();
    return convert.fromJson(jsonDecode(jsonString));
  }

  /// Return OK Response (status_code 200) with T instance serialized from json created from class
  FutureOr<Response> ok(
      FutureOr<T> object, {
        Map<String, Object>? optionalHeaders,
      }) async {
    var name = (await object);
    final json = name.toJson();

    final headers = (optionalHeaders ?? <String, Object>{});
    headers.addAll(_jsonContentType);

    final response = Response.ok(
      jsonEncode(json),
      headers: headers,
    );
    return response;
  }

  /// Return INTERNAL_SERVER_ERROR Response (status_code 500) with T instance serialized from json created from class
  FutureOr<Response> internalError(
      FutureOr<T> object, {
        Map<String, Object>? optionalHeaders,
      }) async {
    final json = (await object).toJson();

    final headers = (optionalHeaders ?? <String, Object>{});
    headers.addAll(_jsonContentType);

    final response = Response.internalServerError(
      body: jsonEncode(json),
      headers: headers,
    );
    return response;
  }

  /// Return CREATED Response (status_code 201) with T instance serialized from json created from class
  FutureOr<Response> created(
      FutureOr<T> object, {
        Map<String, Object>? optionalHeaders,
      }) async {
    final json = (await object).toJson();

    final headers = (optionalHeaders ?? <String, Object>{});
    headers.addAll(_jsonContentType);

    return Response(
      500,
      body: jsonEncode(json),
      headers: headers,
    );
  }

  /// Return BAD_REQUEST Response (status_code 400) with T instance serialized from json created from class
  FutureOr<Response> badRequest(
      Future<T> object, {
        Map<String, Object>? optionalHeaders,
      }) async {
    final json = (await object).toJson();

    final headers = (optionalHeaders ?? <String, Object>{});
    headers.addAll(_jsonContentType);

    return Response(
      400,
      body: jsonEncode(json),
      headers: headers,
    );
  }
}
