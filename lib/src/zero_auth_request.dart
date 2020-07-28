class ZeroAuthRequest {
  ZeroAuthRequest({
    this.cardToken,
    this.cardType,
    this.cardNumber,
    this.holder,
    this.expirationDate,
    this.securityCode,
    this.saveCard,
    this.brand,
    this.cardOnFile,
  });

  String cardToken;
  CardType cardType;
  String cardNumber;
  String holder;
  String expirationDate;
  String securityCode;
  bool saveCard;
  String brand;
  CardOnFile cardOnFile;

  Map<String, dynamic> toJson() => {
    "CardType": cardType.toString().split('.').last,
    "CardNumber": cardNumber,
    "Holder": holder,
    "ExpirationDate": expirationDate,
    "SecurityCode": securityCode,
    "SaveCard": saveCard.toString(),
    "Brand": brand,
    "CardOnFile": cardOnFile.toJson(),
  };
}

class CardOnFile {
  CardOnFile({
    this.usage,
    this.reason,
  });

  Usage usage;
  Reason reason;

  factory CardOnFile.fromJson(Map<String, dynamic> json) => CardOnFile(
    usage: json["Usage"],
    reason: json["Reason"],
  );

  Map<String, dynamic> toJson() => {
    "Usage": usage.toString().split('.').last,
    "Reason": reason.toString().split('.').last,
  };
}

enum CardType { CreditCard, DebitCard }

enum Usage { First, Used }

enum Reason { Recurring, Unscheduled, Installments }

