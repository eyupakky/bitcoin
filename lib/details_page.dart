import 'dart:async';
import 'package:bitcoinsistemi/coin_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/platform_interface.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'ads_widget.dart';
import 'const.dart';

class DetailsPage extends StatefulWidget {
  CoinModel coin;
  StreamController<bool> listStream;

  @override
  State<StatefulWidget> createState() => _StateDetailsPage();

  DetailsPage(this.coin, this.listStream);
}

class _StateDetailsPage extends State<DetailsPage> {
  var f1 = NumberFormat('##,###.###', 'en_US');
  bool favorite = false;
  late StreamController<bool> _events = new StreamController<bool>();
  late StreamController<String> webEvent = new StreamController<String>();

  @override
  void initState() {
    super.initState();
    getFavorite(widget.coin.name).then((value) {
      setState(() {
        favorite = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(
        '${Const.grafik}karsilik=USDT&body=FFFFFF&color=${((Theme.of(context).brightness == Brightness.dark) ? "Dark" : "Light")}&coin=${widget.coin.symbol}');
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      body: Column(
        children: [
          appBar(context),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 16),
                width: 55,
                height: 55,
                child: CachedNetworkImage(
                  imageUrl: "${widget.coin.image}",
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) =>
                      Image.asset("asset/default.png"),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 16),
                child: Text(
                  (Const.isTry ? '₺' : '\$') +
                      "${Const.k_m_b_generator(double.parse(widget.coin.currentPrice.toString()))}",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 32),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              itemWidget(
                AppLocalizations.of(context)!.marketHcm,
                (Const.isTry ? '\₺' : '\$') +
                    "${Const.k_m_b_generator(double.parse(widget.coin.marketCap.toString()))}",
              ),
              itemWidget(
                  AppLocalizations.of(context)!.hacim24,
                  (Const.isTry ? '\₺' : '\$') +
                      "${Const.k_m_b_generator(double.parse(widget.coin.totalVolume!.toString()))}"),
              itemWidget(
                  AppLocalizations.of(context)!.toplamArz,
                  (Const.isTry ? '\₺' : '\$') +
                      "${Const.k_m_b_generator(double.parse(widget.coin.totalSupply!.toString()))}")
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              itemWidget(
                AppLocalizations.of(context)!.dgsm1S,
                "${f1.format(widget.coin.priceChangePercentage1hInCurrency != null ? widget.coin.priceChangePercentage1hInCurrency : 0)}\%",
              ),
              itemWidget(AppLocalizations.of(context)!.dgsm24Saat,
                  "${f1.format(widget.coin.marketCapChangePercentage24h != null ? widget.coin.marketCapChangePercentage24h : 0)}\%"),
              itemWidget(AppLocalizations.of(context)!.dgsm7Gun,
                  "${f1.format(widget.coin.priceChangePercentage7dInCurrency != null ? widget.coin.priceChangePercentage7dInCurrency : 0)}\%")
            ],
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.55,
            child: WebView(
                initialUrl:
                    '${Const.grafik}karsilik=USDT&body=FFFFFF&color=${((Theme.of(context).brightness == Brightness.dark) ? "Dark" : "Light")}&coin=${widget.coin.symbol}',
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (controller) {}),
          ),

          /*
                            url.contains("api.whatsapp") ||
                                    url.contains("https://telegram.me/") ||
                                    url.contains("https://www.facebook.com/") ||
                                    url.contains("m.facebook.com/") ||
                                    url.contains("https://twitter.com")*/
        ],
      ),
      // bottomNavigationBar: Container(
      //   color: (Theme.of(context).brightness == Brightness.dark)
      //     ? Colors.black
      //   : Colors.white,
      //child: AdsWidget(Const.adsPath +'color=${((Theme.of(context).brightness == Brightness.dark) ? "000000" : "FFFFFF")}')),
    );
  }

  Widget itemWidget(String title, sayi) {
    return Expanded(
      flex: 1,
      child: Column(
        children: [Text(title), Text(sayi)],
      ),
    );
  }

  Widget appBar(context) {
    return StreamBuilder(
        stream: _events.stream,
        builder: (context, AsyncSnapshot<bool> snapshot) {
          return Container(
            margin: EdgeInsets.only(left: 12, right: 12, top: 18),
            height: 80,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      size: 35,
                      color: Theme.of(context).primaryColor,
                    ),
                    tooltip: 'Show Snackbar',
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                  ),
                ),
                Expanded(
                    flex: 8,
                    child: Container(
                        margin: EdgeInsets.only(left: 12, right: 12, top: 10),
                        padding: EdgeInsets.all(20),
                        child: (Theme.of(context).brightness == Brightness.dark)
                            ? Image.asset("asset/bitcoinsistemi-darkmode.png")
                            : Image.asset("asset/bitcoinsistemi-logo.png"))),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(top: 12),
                    child: IconButton(
                      icon: Icon(
                        favorite ? Icons.star : Icons.star_border,
                        size: 25,
                        color: Theme.of(context).primaryColor,
                      ),
                      tooltip: 'Show Snackbar',
                      onPressed: () {
                        if (favorite) {
                          deleteFavorite(widget.coin.name);
                        } else
                          addFavorite(widget.coin.name);
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  addFavorite(String coin) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> list = [];
    list = (preferences.getStringList("coin_list") != null
        ? preferences.getStringList("coin_list")
        : [])!;
    list.add(coin);

    await preferences.setStringList("coin_list", list);
    Const.favoriteList = list;
    widget.listStream.sink.add(true);
    if (favorite) {
      ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text(AppLocalizations.of(context)!.favoriSil)));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar( SnackBar(content: Text(AppLocalizations.of(context)!.favoriEkle)));
    }
    favorite = !favorite;
    _events.sink.add(favorite);
  }

  deleteFavorite(coin) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String>? list = preferences.getStringList("coin_list");
    List<String> newList = [];

    for (int i = 0; i < list!.length; i++) {
      if (list[i] != coin) {
        newList.add(list[i]);
      }
    }
    await preferences.setStringList("coin_list", newList);
    Const.favoriteList = newList;
    widget.listStream.sink.add(true);
    if (favorite) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Favorilerden çıkarıldı.')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Favorilere eklendi.')));
    }
    favorite = !favorite;
    _events.sink.add(favorite);
  }

  Future<bool> getFavorite(String coin) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String>? list = preferences.getStringList("coin_list");
    if (list == null) {
      return false;
    } else {
      dynamic el = false;
      for (int i = 0; i < list.length; i++) {
        if (list[i] == coin) {
          el = true;
          return el;
        }
      }
      return el;
    }
  }
}
