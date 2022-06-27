import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'home_page.dart';

class AppBarWidget extends StatelessWidget {
  IndexFunctions indexFunctions;
  IndexFunctions showSearch;

  AppBarWidget({required this.indexFunctions,required this.showSearch});

  @override
  Widget build(BuildContext context) {
    return appBar(context);
  }

  Widget appBar(context) {
    return Container(
      margin: EdgeInsets.only(left: 12, right: 12, top: 18),
      height: 80,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: IconButton(
              icon: Icon(
                Icons.menu,
                size: 35,
                color: Theme.of(context).primaryColor,
              ),
              tooltip: 'Show Snackbar',
              onPressed: () {
                this.indexFunctions(0);
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
            child: IconButton(
              icon: Icon(
                Icons.search,
                size: 25,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: ()=>showSearch(0),
            ),
          ),
        ],
      ),
    );
  }
}
