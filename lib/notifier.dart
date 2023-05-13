import 'package:flutter/cupertino.dart';

class CartModel extends ChangeNotifier {
  late String url="";

  void change(String url) {
    this.url = url;
    notifyListeners();
  }
}