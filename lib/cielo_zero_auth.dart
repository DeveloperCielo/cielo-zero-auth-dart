library cielo_zero_auth;

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cielo_oauth/cielo_oauth.dart' as oauth;

import 'src/zero_auth_response.dart';
import 'src/zero_auth_error_response.dart';
import 'src/zero_auth_request.dart';
import 'src/zero_auth_result.dart';
import 'src/environment.dart';

export 'src/zero_auth_response.dart';
export 'src/zero_auth_error_response.dart';
export 'src/zero_auth_request.dart';
export 'src/zero_auth_result.dart';
export 'src/environment.dart';

class CieloZeroAuth {
  final String clientId;
  final String clientSecret;
  final String merchantId;
  final Environment environment;
  oauth.Environment _oAuthEnvironment;
  String _url;

  CieloZeroAuth({
    this.clientId,
    this.clientSecret,
    this.merchantId,
    this.environment = Environment.SANDBOX
  }) {
    if (environment == Environment.SANDBOX) {
      this._url = 'apisandbox.cieloecommerce.cielo.com.br';
      this._oAuthEnvironment = oauth.Environment.SANDBOX;
    } else {
      this._url = 'api.cieloecommerce.cielo.com.br';
      this._oAuthEnvironment = oauth.Environment.PRODUCTION;
    }
  }

  Future<ZeroAuthResult> validate(ZeroAuthRequest request) async {
    var oauthClient = oauth.OAuth(
      clientId: this.clientId,
      clientSecret: this.clientSecret,
      environment: _oAuthEnvironment,
    );

    final accessTokenResult = await oauthClient.getToken();

    if (accessTokenResult.errorResponse != null) {
      return ZeroAuthResult(
        zeroAuthErrorResponse: <ZeroAuthErrorResponse>[
          ZeroAuthErrorResponse(
              code: accessTokenResult.errorResponse?.error,
              message: accessTokenResult.errorResponse?.errorDescription),
        ],
        statusCode: accessTokenResult.statusCode,
      );
    }

    if (accessTokenResult.accessTokenResponse?.accessToken == null) {
      return ZeroAuthResult(
        zeroAuthErrorResponse: <ZeroAuthErrorResponse>[
          ZeroAuthErrorResponse(
              code: "unknown_authentication_error",
              message: "Unknown Authentication Error")
        ],
        statusCode: accessTokenResult.statusCode,
      );
    }

    final token = accessTokenResult.accessTokenResponse?.accessToken;
    final Uri url = Uri.https(this._url, "/1/zeroauth");

    var response = await http.post(
      url,
      headers: <String, String>{
        'Authorization': 'Bearer $token',
        'MerchantId': this.merchantId,
        'Content-Type': 'application/json'
      },
      body: jsonEncode(request),
    );

    if (response.statusCode == 200) {
      return ZeroAuthResult(
        zeroAuthResponse: ZeroAuthResponse.fromJson(jsonDecode(response.body)),
        statusCode: response.statusCode,
      );
    } else {
      List<ZeroAuthErrorResponse> errors = <ZeroAuthErrorResponse>[];
      try {
        var jsonDecoded = jsonDecode(response.body);
        if (jsonDecoded is List) {
          errors = jsonDecoded
              .map((error) => ZeroAuthErrorResponse.fromJson(error))
              .toList();
        } else {
          errors.add(ZeroAuthErrorResponse.fromJson(jsonDecoded));
        }
        return ZeroAuthResult(
          zeroAuthErrorResponse: errors,
          statusCode: response.statusCode,
        );
      } catch (e) {
        return ZeroAuthResult(
          zeroAuthErrorResponse: <ZeroAuthErrorResponse>[
            ZeroAuthErrorResponse(
              code: response.reasonPhrase.toLowerCase().replaceAll(" ", "_") ?? "unknown_error",
              message: response.reasonPhrase ?? "Unknown Error",
            )
          ],
          statusCode: response.statusCode,
        );
      }
    }
  }
}