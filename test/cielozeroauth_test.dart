import 'package:cielo_zero_auth/cielo_zero_auth.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final String clientId = "YOUR-CLIENT-ID";
  final String clientSecret = "YOUR-CLIENT-SECRET";
  final String merchantId = "YOUR-MERCHANT-ID";

  group("correct credentials", () {
    ZeroAuthResult result;
    setUp(() async {
      var zeroAuth = CieloZeroAuth(
        clientId: clientId,
        clientSecret: clientSecret,
        merchantId: merchantId,
        environment: Environment.SANDBOX,
      );

      result = await zeroAuth.validate(ZeroAuthRequest(
        cardNumber: "1234123412341234",
        cardType: CardType.CreditCard,
        holder: "Maurici Ferreira Junior",
        expirationDate: "01/2030",
        securityCode: "123",
        saveCard: false,
        brand: "Visa",
        cardOnFile: CardOnFile(
          usage: Usage.Used,
          reason: Reason.Recurring,
        ),
      ));
    });

    test("should return status code 200", () {
      expect(result.statusCode, 200);
    });

    test("should return zero auth response", () {
      expect(result.zeroAuthResponse, isNotNull);
    });

    test("should return valid", () {
      expect(result.zeroAuthResponse?.valid, isNotNull);
    });

    test("should return return code", () {
      expect(result.zeroAuthResponse?.returnCode, isNotNull);
    });

    test("should return return message", () {
      expect(result.zeroAuthResponse?.returnMessage, isNotNull);
    });

    test("should return issuer transaction id", () {
      expect(result.zeroAuthResponse?.issuerTransactionId, isNotNull);
    });
  });

  group("incorrect credentials", () {
    ZeroAuthResult result;
    setUp(() async {
      var zeroAuth = CieloZeroAuth(
        clientId: "AAAAAAAA-BBBB-CCCC-DDDD-EEEEEEEEEEEE",
        clientSecret: "9999999999999999999999999999999999999999999=",
        merchantId: "AAAAAAAA-BBBB-CCCC-DDDD-EEEEEEEEEEEE",
        environment: Environment.SANDBOX,
      );

      result = await zeroAuth.validate(ZeroAuthRequest(
        cardNumber: "1234123412341234",
        cardType: CardType.CreditCard,
        holder: "Maurici Ferreira Junior",
        expirationDate: "01/2030",
        securityCode: "123",
        saveCard: false,
        brand: "Visa",
        cardOnFile: CardOnFile(
          usage: Usage.Used,
          reason: Reason.Recurring,
        ),
      ));
    });

    test("should return status code 400", () {
      expect(result.statusCode, 400);
    });

    test("should return error response", () {
      expect(result.zeroAuthErrorResponse, isNotEmpty);
    });

    test("should return invalid_client as error code", () {
      expect(result.zeroAuthErrorResponse[0]?.code, "invalid_client");
    });

    test("should return error message", () {
      expect(result.zeroAuthErrorResponse[0]?.message, isNotNull);
    });
  });
}
