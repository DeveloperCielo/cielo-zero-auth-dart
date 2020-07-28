import 'package:cielo_zero_auth/cielo_zero_auth.dart';

void main(List<String> arguments) async {
  var zeroAuth = CieloZeroAuth(
    clientId: "YOUR-CLIENT-ID",
    clientSecret: "YOUR-CLIENT-SECRET",
    merchantId: "YOUR-MERCHANT-ID",
    environment: Environment.SANDBOX,
  );

  var result = await zeroAuth.validate(ZeroAuthRequest(
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

  print(result.statusCode);

  if (result.zeroAuthErrorResponse != null) {
    result.zeroAuthErrorResponse.forEach((e) {
      print("ErrorCode: ${e.code}");
      print("ErrorMessage: ${e.message}");
    });
  }

  if (result.zeroAuthResponse != null) {
    print(result.zeroAuthResponse.valid);
    print(result.zeroAuthResponse.returnCode);
    print(result.zeroAuthResponse.returnCode);
    print(result.zeroAuthResponse.issuerTransactionId);
  }
}
