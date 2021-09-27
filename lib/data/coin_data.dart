import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bitcoin_ticker/data/coin_data.dart' as coin_data;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinDataBrain {
  List<Padding> getCurrencyWidgets(
      {@required String currency, List<dynamic> rateMap}) {
    List<Padding> list = [];
    for (int i = 0; i < coin_data.cryptoList.length; i++) {
      list.add(_getCurrencyWidget(
          crypto: coin_data.cryptoList[i],
          currency: currency,
          rate: rateMap[i]));
    }
    return list;
  }

  Padding _getCurrencyWidget(
      {@required String crypto,
      @required String currency,
      @required Map<String, double> rate}) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $crypto = ${rate["$currency"]} $currency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
