import 'dart:convert';
import 'dart:io';
import 'package:bitcoinsistemi/news_model.dart';
import 'package:bitcoinsistemi/progress_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:search_page/search_page.dart';
import 'app_bar.dart';
import 'coin_model.dart';
import 'const.dart';
import 'list_item.dart';
import 'news_details.dart';

class NewsPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey;

  const NewsPage(this._scaffoldKey, {Key? key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  bool progress = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    // Const.haberlerNotification = Const.adsPath;
    return progress
        ? ProgressWidget()
        : Column(
          children: [
            Container(
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
                        widget._scaffoldKey.currentState!.openDrawer();
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
                    child: Visibility(
                      visible: false,
                      child: IconButton(
                        icon: Icon(
                          Icons.search,
                          size: 25,
                          color: Theme.of(context).primaryColor,
                        ), onPressed: () {  },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height* 0.75,
                child: RefreshIndicator(
                onRefresh: () async {
                  await getData();
                },
                child: ListView.separated(
                padding: const EdgeInsets.only(top: 8),
                itemCount: Const.newsModel.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  NewsDetails(item:Const.newsModel[index])),
                      );
                    },
                    leading: SizedBox(
                      width: 80,
                      child: CachedNetworkImage(
                        imageUrl: "${Const.newsModel[index].yoastHeadJson!.ogImage![0].url}",
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,),
                            ),
                          ),
                        progressIndicatorBuilder: (context, url, downloadProgress) =>
                            CircularProgressIndicator(value: downloadProgress.progress),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    title: Text('${Const.newsModel[index].yoastHeadJson!.title}',style: TextStyle(color: Colors.black),),
                    subtitle: Text('${Const.newsModel[index].yoastHeadJson!.description}',style: TextStyle(color: Colors.grey,fontSize: 10),),
                  );
                },separatorBuilder: (BuildContext context, int index) => const Divider(color: Colors.black,),),
              )),
          ],
        );
  }

  Future<void> getData() async {
    var uri = Uri.https(Const.newsBasePath, Const.newsPath);

    try {
      print("Sending get request to $uri");
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        Const.newsModel.clear();
        List model = json.decode(response.body);
        model.forEach((value) {
          Const.newsModel.add(NewsModel.fromJson(value));
        });
        setState(() {
          progress = false;
        });
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }
}
