// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zero_auth_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$ZeroAuthRequestToJson(ZeroAuthRequest instance) =>
    <String, dynamic>{
      'cardToken': instance.cardToken,
      'cardType': _$CardTypeEnumMap[instance.cardType],
      'cardNumber': instance.cardNumber,
      'holder': instance.holder,
      'expirationDate': instance.expirationDate,
      'securityCode': instance.securityCode,
      'saveCard': instance.saveCard,
      'brand': instance.brand,
      'cardOnFile': instance.cardOnFile,
    };

const _$CardTypeEnumMap = {
  CardType.CreditCard: 'CreditCard',
  CardType.DebitCard: 'DebitCard',
};

Map<String, dynamic> _$CardOnFileToJson(CardOnFile instance) =>
    <String, dynamic>{
      'usage': _$UsageEnumMap[instance.usage],
      'reason': _$ReasonEnumMap[instance.reason],
    };

const _$UsageEnumMap = {
  Usage.First: 'First',
  Usage.Used: 'Used',
};

const _$ReasonEnumMap = {
  Reason.Recurring: 'Recurring',
  Reason.Unscheduled: 'Unscheduled',
  Reason.Installments: 'Installments',
};
