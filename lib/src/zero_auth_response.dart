class ZeroAuthResponse {
  ZeroAuthResponse({
    this.valid,
    this.returnCode,
    this.returnMessage,
    this.issuerTransactionId,
  });

  String valid;
  String returnCode;
  String returnMessage;
  String issuerTransactionId;

  factory ZeroAuthResponse.fromJson(Map<String, dynamic> json) => ZeroAuthResponse(
    valid: json["Valid"].toString(),
    returnCode: json["ReturnCode"],
    returnMessage: json["ReturnMessage"],
    issuerTransactionId: json["IssuerTransactionId"],
  );
}

