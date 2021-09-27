import 'package:flutter/cupertino.dart';

class CryptoDataModel {
  final String time;
  final String asset_id_quote;
  final double rate;

  CryptoDataModel(
      {@required this.time,
      @required this.asset_id_quote,
      @required this.rate});

  factory CryptoDataModel.fromJson(Map<String, dynamic> json) {
    return CryptoDataModel(
      time: json['time'],
      asset_id_quote: json['asset_id_quote'],
      rate: json['rate'],
    );
  }
}
