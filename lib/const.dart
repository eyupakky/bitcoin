import 'dart:async';

import 'package:bitcoinsistemi/coin_model.dart';
import 'package:bitcoinsistemi/news_model.dart';

class Const {
  static String analiz = "bitcoinsistemi.com/analiz?appios=yes";
  static String analizEn = "bitcoinsistemi.com/analysis?appios=yes";
  static String haberler = "bitcoinsistemi.com?appios=yes";
  static String haberlerNotification = "";
  static String grafik = "https://www.bitcoinsistemi.com/uygulama_grafik_ios.php?";
  static String coinList = "api.coingecko.com";
  static String path = "/api/v3/coins/markets";
  static String newsPath="/wp-json/wp/v2/posts";
  static String newsBasePath = "bitcoinsistemi.com";
  static String adsPath = "https://bitcoinsistemi.com/mobil_ads_ios.php?";
  static String adsAnaPath = "https://bitcoinsistemi.com/mobil_ads_ana_ios.php?";
  static bool isTry = false;
  static bool money = false;
  static List<CoinModel> coinListModel = [];
  static List<NewsModel> newsModel = [];
  static List<String>? favoriteList = [];
  static bool darkMode = false;
  static StreamController<bool> listStream = new StreamController<bool>();

  static String k_m_b_generator(double num) {
    if (num > 999 && num < 99999) {
      return "${(num / 1000).toStringAsFixed(1)} K";
    } else if (num > 99999 && num < 999999) {
      return "${(num / 1000).toStringAsFixed(0)} B";
    } else if (num > 999999 && num < 999999999) {
      return "${(num / 1000000).toStringAsFixed(1)} M";
    } else if (num > 999999999 && num < 999999999999) {
      return "${(num / 1000000000).toStringAsFixed(1)} Mr";
    } else if (num > 999999999999) {
      return "${(num / 1000000000000).toStringAsFixed(1)} Tn";
    } else {
      return num.toString();
    }
  }
}
