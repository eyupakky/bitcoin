import 'package:bitcoinsistemi/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class DrawerMenu extends StatefulWidget {
  final IndexFunctions indexFunction;
  final IndexFunctions settingsOpen;
  DrawerMenu({required this.indexFunction,required this.settingsOpen});
  @override
  State<StatefulWidget> createState() => _StateDrawerMenu();
}

class _StateDrawerMenu extends State<DrawerMenu> {
  @override
  Widget build(BuildContext context) {
    return drawerMenu();
  }

  drawerMenu() {
    return Drawer(
      child: Container(
        color: Theme.of(context).primaryColorDark,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorDark,
              ),
              child: Column(children: [
                Container(margin: EdgeInsets.all(8), width: 100, height: 100, child: Center(child: Image.asset("asset/bitcoinsistem.png"))),
                Text(
                  "Bitcoin Sistemi",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                )
              ]),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.grey,
              ),
              title: Text(
                'Ana Sayfa',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              onTap: () {
                setState(() {
                  widget.indexFunction(0);
                });
              },
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.grey,
              ),
              title: Text(
                'Ayarlar',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              onTap: () {
                widget.settingsOpen(0);
              },
            ),
          ],
        ),
      ),
    );
  }
}
