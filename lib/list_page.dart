import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:bitcoinsistemi/coin_model.dart';
import 'package:bitcoinsistemi/const.dart';
import 'package:bitcoinsistemi/list_item.dart';
import 'package:bitcoinsistemi/progress_widget.dart';
import 'package:bitcoinsistemi/stream_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:search_page/search_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ads_widget.dart';
import 'app_bar.dart';

class ListPage extends StatefulWidget {
  late bool isFavori;
  bool? isTry;
  final GlobalKey<ScaffoldState> _scaffoldKey;
  ListPage(this.isFavori, this.isTry, this._scaffoldKey, {required UniqueKey key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StateListPage();
}

class _StateListPage extends State<ListPage> {
  bool progress = true;

  @override
  void initState() {
    super.initState();
    if (widget.isFavori) {
      getFavoriData();
    } else {
      if (Const.coinListModel.length < 1 || Const.money) {
        getData();
      } else {
        progress = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return progress
        ? ProgressWidget()
        : Column(
          children: [
            AppBarWidget(
                indexFunctions: (v) {
                  widget._scaffoldKey.currentState!.openDrawer();
                },
                showSearch: (int index) => showSearch(
                      context: context,
                      delegate: SearchPage<CoinModel>(
                          onQueryUpdate: (s) => print(s),
                          items: Const.coinListModel,
                          searchLabel: 'Koin Ara',
                          suggestion: Center(
                            child: Text('Aramak istediğiniz koinin adını yazınız.'),
                          ),
                          failure: Center(
                            child: Text('No person found :('),
                          ),
                          filter: (person) => [
                                person.name,
                              ],
                          builder: (coinModel) => ListItem(coinModel)),
                    )),
            titleBar(),
            Expanded(
                child: RefreshIndicator(
              onRefresh: () async {
                await getData();
              },
              child: ListView.builder(
                  padding: const EdgeInsets.only(top: 8),
                  itemCount: Const.coinListModel.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (widget.isFavori) {
                      if (Const.favoriteList != null && Const.favoriteList!.contains(Const.coinListModel[index].name)) {
                        return ListItem(Const.coinListModel[index]);
                      } else
                        return Container();
                    } else {
                      return ListItem(Const.coinListModel[index]);
                    }
                  }),
            )),
            //AdsWidget(Const.adsAnaPath+'color=${((Theme.of(context).brightness == Brightness.dark) ? "000000" : "FFFFFF")}'),
          ],
        );
  }

  Widget titleBar() {
    return Container(
      height: 20,
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  "İsim",
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
              )),
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Text("Hacim(24s)", style: TextStyle(color: Colors.grey, fontSize: 13)),
              )),
          Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Text("Fiyat Market Hcm", style: TextStyle(color: Colors.grey, fontSize: 13)),
              )),
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Text("1s Dğşm", style: TextStyle(color: Colors.grey, fontSize: 13)),
              )),
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Text("24s Dğşm", style: TextStyle(color: Colors.grey, fontSize: 13)),
              )),
        ],
      ),
    );
  }

  Future<void> getData() async {
    Map<String, String> params = {
      "vs_currency": (Const.isTry && Const.isTry) ? 'try' : "usd",
      "order": "market_cap_desc",
      "per_page": "100",
      "page": "1",
      "sparkline": "false",
      "price_change_percentage": Uri.decodeComponent('1h%2C7d')
    };
    var uri = Uri.https(Const.coinList, Const.path, params);

    try {
      print("Sending get request to $uri");
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        Const.coinListModel.clear();
        Const.money = false;
        List model = json.decode(response.body);
        model.forEach((value) {
          Const.coinListModel.add(CoinModel.fromJson(value));
        });
        progress = false;
        setState(() {});
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }

  Future<void> getFavoriData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Const.favoriteList = preferences.getStringList("coin_list");
    progress = false;
    setState(() {});
    return Future.value();
  }
}
