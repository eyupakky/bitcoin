import 'package:bitcoinsistemi/coin_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'const.dart';
import 'details_page.dart';

class ListItem extends StatelessWidget{
  CoinModel model;
  ListItem(this.model);
  var f = NumberFormat('##,###.###', 'en_US');
  var f1 = NumberFormat('##,###.##', 'en_US');
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailsPage(model, Const.listStream)),
        );
      },
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(

                  child: CachedNetworkImage(
                    imageUrl: "${model.image}",
                    progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
                    errorWidget: (context, url, error) {
                      return Image.asset("asset/default.png");
                    },
                  ),
                  margin: EdgeInsets.only(top: 8, left: 8, right: 8),
                  width: 28,
                  height: 28,
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        child: Text(
                          "${model.name}",
                          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 14),
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Align(
                        child: Text(
                          (Const.isTry ? '₺' : '\$') + "${Const.k_m_b_generator(double.parse(model.totalVolume.toString()))}",
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                        alignment: Alignment.centerLeft,
                      )
                    ],
                  ),
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.all(8),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        child: Text(
                          (Const.isTry ? '\₺' : '\$') + "${f.format(model.currentPrice)}",
                          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16),
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Align(
                        child: Text(
                          (Const.isTry ? '\₺' : '\$') + "${Const.k_m_b_generator(double.parse(model.marketCap.toString()))}",
                          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 13),
                        ),
                        alignment: Alignment.centerLeft,
                      )
                    ],
                  ),
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.all(8),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  child: Text(
                    "${f1.format(model.priceChangePercentage1hInCurrency != null ? model.priceChangePercentage1hInCurrency : 0)}\%",
                    style: TextStyle(
                        color: (model.priceChangePercentage1hInCurrency != null ? model.priceChangePercentage1hInCurrency : 0) > 0
                            ? Colors.green
                            : Colors.red,
                        fontSize: 16),
                  ),
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.all(8),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        child: Text(
                          "${f1.format(model.marketCapChangePercentage24h)}\%",
                          style: TextStyle(color: model.marketCapChangePercentage24h > 0 ? Colors.green : Colors.red, fontSize: 16),
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                    ],
                  ),
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.all(8),
                ),
              ),
            ],
          ),
          Divider(
            height: 5,
            color: Colors.black,
          )
        ],
      ),
    );
  }

}