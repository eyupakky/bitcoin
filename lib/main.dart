import 'dart:async';
import 'package:bitcoinsistemi/const.dart';
import 'package:bitcoinsistemi/home_page.dart';
import 'package:bitcoinsistemi/stream_model.dart';
import 'package:flutter/material.dart';
import 'globals.dart' as globals;

void main() {
  globals.appNavigator = GlobalKey<NavigatorState>();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  late StreamController<StreamModel> _events = new StreamController<StreamModel>();

  bool? isDayTheme = false;
  bool? isTry = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _events.stream,
        builder: (context, AsyncSnapshot<StreamModel> snapshot) {
          Const.darkMode = snapshot.data != null ? (snapshot.data!.darkMode ? snapshot.data!.darkMode : false) : true;
          Const.isTry = snapshot.data != null ? (snapshot.data!.moneyMode ? snapshot.data!.moneyMode : false) : false;
          Const.money = true;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: globals.appNavigator,
            title: 'Bitcoin Sistemi',
            theme: ThemeData(
                brightness: Brightness.light,
                primaryColor: Colors.black,
                primaryColorLight: Colors.grey,
                primaryColorDark: Colors.white,
                iconTheme: IconThemeData(color: Colors.black),
                backgroundColor: Colors.white,
                appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: Colors.black))),
            darkTheme: ThemeData(
                brightness: Brightness.dark,
                primaryColor: Colors.white,
                primaryColorDark: Colors.black,//HexColor("#413F44"),
                primaryColorLight: Colors.grey,//HexColor("#413F44"),
                appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: Colors.black))),
            themeMode: Const.darkMode ? ThemeMode.dark : ThemeMode.light,
            home: HomePage(_events, Const.isTry),
          );
        });
  }
}
