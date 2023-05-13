import 'dart:async';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bitcoinsistemi/app_bar.dart';
import 'package:bitcoinsistemi/coin_model.dart';
import 'package:bitcoinsistemi/const.dart';
import 'package:bitcoinsistemi/list_item.dart';
import 'package:bitcoinsistemi/stream_model.dart';
import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:search_page/search_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatefulWidget {
  StreamController<StreamModel> events;
  final GlobalKey<ScaffoldState> _scaffoldKey;

  Settings(this.events, this._scaffoldKey);

  @override
  State<StatefulWidget> createState() => _StateSettings();
}

class _StateSettings extends State<Settings> {
  bool darkMode = true;
  bool money = false;
  GroupController controller = GroupController();
  GroupController controllerMoney = GroupController();

  @override
  void initState() {
    super.initState();
    getShared("darkMode").then((value) {
      if (value == null) {
        darkMode = Theme.of(context).brightness == Brightness.dark ? true : false;
      } else {
        darkMode = value;
      }
      controller.select(darkMode ? 2 : 1);
      getShared("money").then((value) {
        if (value == null) {
          money = false;
        } else {
          money = value;
        }
        setState(() {
          controllerMoney.select(money ? 1 : 2);
        });
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
    return SingleChildScrollView(
      child: Container(
        color: Theme.of(context).primaryColorDark,
        height: MediaQuery.of(context).size.height - 100,
        child: Column(
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
                          searchLabel: AppLocalizations.of(context)!.koin_ara,
                          suggestion: Center(
                            child: Text(AppLocalizations.of(context)!.search_coin),
                          ),
                          failure: Center(
                            child: Text('No person found :('),
                          ),
                          filter: (person) => [
                                person.name,
                              ],
                          builder: (coinModel) => ListItem(coinModel)),
                    )),
            SizedBox(
              height: 15,
            ),
            Text(
              AppLocalizations.of(context)!.geceModunuEtkinlestir,
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              height: 2,
              color: Theme.of(context).primaryColor,
            ),
            SimpleGroupedCheckbox<int>(
              checkFirstElement: true,
              groupTitleAlignment: Alignment.centerLeft,
              controller: controller,
              onItemSelected: (check) {
                setState(() {
                  if (check == 1) {
                    darkMode = false;
                    widget.events.sink.add(new StreamModel(darkMode, money));
                  } else {
                    darkMode = true;
                    change();
                  }
                  addShared("darkMode", darkMode);
                });
              },
              itemsTitle: [AppLocalizations.of(context)!.pasif, AppLocalizations.of(context)!.etkin],
              values: [1, 2],
              groupStyle: GroupStyle(activeColor: Colors.blue, itemTitleStyle: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor)),
            ),
            Text(
                AppLocalizations.of(context)!.paraBirimiSec,
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(height: 2, color: Theme.of(context).primaryColor),
            SimpleGroupedCheckbox<int>(
              groupTitleAlignment: Alignment.centerLeft,
              controller: controllerMoney,
              onItemSelected: (check) {
                setState(() {
                  if (check == 1) {
                    money = true;
                    change();
                  } else {
                    money = false;
                    change();
                  }
                  addShared("money", money);
                });
              },
              checkFirstElement: true,
              itemsTitle: [AppLocalizations.of(context)!.turkLirasi, AppLocalizations.of(context)!.amerikanDolari],
              values: [1, 2],
              groupStyle: GroupStyle(activeColor: Colors.blue, itemTitleStyle: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor)),
            ),
            InkWell(
              onTap: () async {
                StringBuffer s = StringBuffer("https://www.bitcoinsistemi.com/gizlilik-ilkeleri/");
                await canLaunch(s.toString()) ? await launch(s.toString()) : throw 'Could not launch ${s.toString()}';
              },
              child: Container(
                margin: EdgeInsets.only(left: 16),
                alignment: Alignment.centerLeft,
                child: Text(
                  AppLocalizations.of(context)!.gizlilik,
                  style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  change(){
    widget.events.sink.add(new StreamModel(darkMode, money));
  }
  addShared(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }
}
