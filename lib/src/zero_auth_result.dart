import 'package:cielo_zero_auth/src/zero_auth_error_response.dart';
import 'package:cielo_zero_auth/src/zero_auth_response.dart';

class ZeroAuthResult {
  ZeroAuthResult({
    this.zeroAuthResponse,
    this.zeroAuthErrorResponse,
    this.statusCode,
  });

  final ZeroAuthResponse zeroAuthResponse;
  final List<ZeroAuthErrorResponse> zeroAuthErrorResponse;
  final int statusCode;
}
