import 'dart:async';
import 'package:bitcoinsistemi/settings.dart';
import 'package:bitcoinsistemi/stream_model.dart';
import 'package:bitcoinsistemi/webview_analiz_page.dart';
import 'package:bitcoinsistemi/webview_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'const.dart';
import 'drawer_menu.dart';
import 'list_page.dart';

class HomePage extends StatefulWidget {
  StreamController<StreamModel> events;
  bool? isTry;

  HomePage(this.events, this.isTry);

  @override
  _StateHomePage createState() => _StateHomePage();
}

typedef IndexFunctions = Function(int index);

class _StateHomePage extends State<HomePage> {
  bool progress = true;
  int currentBottomBarIndex = 0;
  List<Widget> pageList = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late StreamController<int> _events = new StreamController<int>();
  late StreamController<int> _events2 = new StreamController<int>();


  @override
  void initState() {
    super.initState();
    initPlatformState();
    bool darkMode, money;
    getShared("darkMode").then((value) {
      if (value == null) {
        darkMode = Theme.of(context).brightness == Brightness.dark ? true : false;
      } else {
        darkMode = value;
      }
      getShared("money").then((value) {
        if (value == null) {
          money = false;
        } else {
          money = value;
        }
        StreamModel model = StreamModel(darkMode, money);
        widget.events.sink.add(model);
        pageList.add(new ListPage(false, widget.isTry, this._scaffoldKey, key: UniqueKey()));
        Const.haberler = Const.haberler + ((Theme.of(context).brightness == Brightness.dark) ? "&color=000000" : "&color=ffffff");
        Const.analiz = Const.analiz + ((Theme.of(context).brightness == Brightness.dark) ? "&color=000000" : "&color=ffffff");
        pageList.add(new WebViewPage(
          Const.haberler,
          MediaQuery.of(context).size.height*0.75,
          _scaffoldKey,
          true,60,
          key: UniqueKey(),
          events: _events2,
        ));
        pageList.add(new WebViewAnalizPage(
          Const.analiz,
          MediaQuery.of(context).size.height*0.75,
          _scaffoldKey,
          true,60,
          key: UniqueKey(),
          events: _events,
        ));
        pageList.add(new ListPage(
          true,
          widget.isTry,
          this._scaffoldKey,
          key: UniqueKey(),
        ));
        pageList.add(new Settings(widget.events,_scaffoldKey));
        pageList.add(new Settings(widget.events,_scaffoldKey));
        progress = false;
      });
    });
  }

  Future<dynamic> getShared(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var ret = prefs.getBool(key);
    return ret;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: DrawerMenu(
          indexFunction: (int index) {
            setState(() {
              currentBottomBarIndex = index;
              Navigator.pop(context);
            });
          },
          settingsOpen: (o) {
            setState(() {
              currentBottomBarIndex = 4;
              Navigator.pop(context);
            });
          },
        ),
        body: progress
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              )
            : Container(
                height: MediaQuery.of(context).size.height,
                color: Theme.of(context).primaryColorDark,
                child:
                IndexedStack(
                  sizing:StackFit.expand,
                  children: pageList,
                  index: currentBottomBarIndex,
                )

               // getSelectedPage(currentBottomBarIndex)
        ),
        bottomNavigationBar: currentBottomBarIndex != 4 ? getBottomNavigationBar(context) : null);
  }

  Widget getSelectedPage(int index) {
    return pageList[index];
  }

  Widget getBottomNavigationBar(BuildContext context) {
    return Container(
      color: Colors.green,
      child: BottomNavigationBar(
        currentIndex: currentBottomBarIndex,
        onTap: (i) {
          setState(() {
            currentBottomBarIndex = i;
            if (i == 1) Const.haberlerNotification = Const.haberler;
            else if (i == 2) Const.haberlerNotification = Const.analiz;
          });
        },
        backgroundColor: Theme.of(context).primaryColorDark,
        type: BottomNavigationBarType.fixed,
        iconSize: 35,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Theme.of(context).primaryColorLight,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money, size: 25),
            label: 'Koinler',
          ),
          BottomNavigationBarItem(
            // TODO dil
            icon: Icon(Icons.article, size: 25),
            label: 'Haberler',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard, size: 25),
            // TODO dil
            label: 'Analiz',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.stars, size: 25),
            // TODO dil
            label: 'Porföyüm',
          ),
        ],
      ),
    );
  }

  Future<void> initPlatformState() async {
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    OneSignal.shared.setNotificationOpenedHandler(
      (OSNotificationOpenedResult result){
        openNotitifi(result.notification);
        print(result.notification.launchUrl);
      },
    );
    OneSignal.shared.setNotificationWillShowInForegroundHandler((event) {
      openNotitifi(event.notification.launchUrl);
    });
    OneSignal.shared.setAppId("811239b8-a3cd-4fbf-8fcb-06ab5d3ed081");
    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    });
  }

  openNotitifi(var notification) {
    setState(() {
      if (notification.launchUrl != null) {
        if (!notification.launchUrl.startsWith("https://www.bitcoinsistemi.com/")) {
          launch(notification.launchUrl);
        }else{
            Const.haberlerNotification =
                notification.launchUrl! + '?appios=yes&' + ((Theme.of(context).brightness == Brightness.dark) ? "color=000000" : "color=FFFFFF");
            currentBottomBarIndex = 1;
            Const.haberlerNotification=notification.launchUrl;
            this._events2.sink.add(0);

        }
       }

    });
  }
}
