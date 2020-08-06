class ZeroAuthErrorResponse {
  ZeroAuthErrorResponse({this.code, this.message});

  String code;
  String message;

  factory ZeroAuthErrorResponse.fromJson(Map<String, dynamic> json) =>
      ZeroAuthErrorResponse(
        code: json["Code"].toString(),
        message: json["Message"],
      );
}
