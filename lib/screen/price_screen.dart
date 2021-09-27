import 'package:bitcoin_ticker/util/constants.dart' as constants;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bitcoin_ticker/data/networking.dart';
import 'package:bitcoin_ticker/data/coin_data.dart' as coin_data;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedValue = "AUD"; //default currency value
  coin_data.CoinDataBrain brain = coin_data.CoinDataBrain();

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          loading == true
              ? constants.kSPIN_KIT_CIRCLE
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: brain.getCurrencyWidgets(
                      currency: selectedValue, rateMap: listData)),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 15.0, top: 5.0),
            color: Colors.lightBlue,
            child: Row(children: [
              Expanded(
                child: SizedBox(),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromARGB(60, 255, 255, 255), width: 3),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(color: Colors.transparent, spreadRadius: 3),
                      ],
                    ),
                    child: loading == true
                        ? constants.kSPIN_KIT_CIRCLE
                        : CupertinoPicker(
                            looping: true,
                            onSelectedItemChanged: (int i) {
                              setState(() {
                                selectedValue = coin_data.currenciesList[i];
                              });
                            },
                            selectionOverlay:
                                CupertinoPickerDefaultSelectionOverlay(
                              background: Colors.transparent,
                            ),
                            itemExtent: 35.0,
                            children: takeItems(),
                          ),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(),
              )
            ]),
          ),
        ],
      ),
    );
  }

  List<Text> takeItems() {
    List<Text> list = [];

    coin_data.currenciesList.forEach((String str) {
      list.add(Text("$str"));
    });

    return list;
  }

  bool loading = false; //it will be updated when getting the data from the net
  List<dynamic> listData = [];

  void getData() async {
    NetworkHelper helper = NetworkHelper();
    List<Future> futures = [];

    coin_data.cryptoList.forEach((String element) {
      futures.add(helper.getData(crypto: element));
    });
    setState(() {
      loading = true;
    });
    try {
      listData = await Future.wait(futures);
    } catch (e) {
      listData = await Future.wait(futures);
    }
    setState(() {
      loading = false;
    });
  }
}
