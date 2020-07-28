import 'package:json_annotation/json_annotation.dart';

part 'zero_auth_request.g.dart';

@JsonSerializable(nullable: false, createToJson: true, createFactory: false)
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

  Map<String, dynamic> toJson() => _$ZeroAuthRequestToJson(this);
}

@JsonSerializable(nullable: false, createToJson: true, createFactory: false)
class CardOnFile {
  CardOnFile({
    this.usage,
    this.reason,
  });

  Usage usage;
  Reason reason;

  Map<String, dynamic> toJson() => _$CardOnFileToJson(this);
}

enum CardType { CreditCard, DebitCard }

enum Usage { First, Used }

enum Reason { Recurring, Unscheduled, Installments }

