import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:bitcoin_ticker/util/constants.dart' as constants;
import 'package:bitcoin_ticker/data/coin_data.dart' as coin_data;

import 'model/crypto_model.dart';

class NetworkHelper {
  Future<Map<String, double>> getData({@required String crypto}) async {
    Uri url = Uri.parse(
        "https://rest.coinapi.io/v1/exchangerate/$crypto${constants.kAPI_KEY}");

    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> list = jsonDecode(response.body)["rates"];

      List<CryptoDataModel> origin = [];

      for (Map<String, dynamic> item in list) {
        if (coin_data.currenciesList.contains(item["asset_id_quote"])) {
          origin.add(CryptoDataModel.fromJson(item));
        }
      }

      Map<String, double> map = {};

      for (CryptoDataModel item in origin) {
        map["${item.asset_id_quote}"] =
            double.tryParse(item.rate.toStringAsFixed(2));
      }
      return map;
    } else {
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
  }
}
