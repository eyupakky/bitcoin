import 'dart:async';

import 'package:bitcoinsistemi/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'notifier.dart';

const String kNavigationExamplePage = '';

class WebViewPage extends StatefulWidget {
  String url;
  double height;
  double margin;
  GlobalKey<ScaffoldState> _scaffoldKey;
  bool visible;
  StreamController<int>? events;

  WebViewPage(
      this.url, this.height, this._scaffoldKey, this.visible, this.margin,
      {required UniqueKey key, this.events})
      : super(key: key);

  @override
  _StateWebViewPage createState() => _StateWebViewPage();
}

class _StateWebViewPage extends State<WebViewPage> {
  final _key = UniqueKey();
  bool progress = true;
  String lastUrl = "";
  int value = 0;
  late WebViewController webViewController;
  late int x = 0;
  late int y = 0;
  late String? title = "";
  final cart = CartModel();

  @override
  void initState() {
    super.initState();
    Provider.of<CartModel>(context, listen: false).addListener(() {
      this.webViewController.loadUrl(Const.haberlerNotification);
    });
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      return  SafeArea(
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      "$title",
                      maxLines: 1,
                      style: TextStyle(
                          color:
                              (Theme.of(context).brightness == Brightness.dark)
                                  ? Colors.white
                                  : Colors.black),
                    ),
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back,
                          color: Theme.of(context).primaryColor),
                      onPressed: () {
                        this.webViewController.canGoBack().then((value) {
                          value ? webViewController.goBack() : null;
                        });
                      },
                    ),
                  ),
                  Stack(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height*0.75,
                        child: WebView(
                            key: _key,
                            initialUrl: Const.haberlerNotification,
                            javascriptMode: JavascriptMode.unrestricted,
                            onWebViewCreated: (controller) {
                              this.webViewController = controller;
                            },
                            javascriptChannels: <JavascriptChannel>{
                              _toasterJavascriptChannel(context),
                            },
                            onPageStarted: (String url) async {
                              widget.events!.sink.add(10);
                              progress = true;
                              if (!url.startsWith("https://www.bitcoinsistemi.com/")
                                  && !url.startsWith("https://en.bitcoinsistemi.com/") && url.isNotEmpty) {
                                launch(url);
                                this.webViewController.loadUrl(lastUrl);
                              }
                            },
                            /*
                          url.contains("api.whatsapp") ||
                                  url.contains("https://telegram.me/") ||
                                  url.contains("https://www.facebook.com/") ||
                                  url.contains("m.facebook.com/") ||
                                  url.contains("https://twitter.com")*/
                            onProgress: (int p) {
                              value = p;
                            },
                            onPageFinished: (String url) async {
                              this
                                  .webViewController
                                  .getTitle()
                                  .then((value) => title = value);
                              progress = false;
                              lastUrl = url;
                              widget.events!.sink.add(-1);
                              print('Page finished loading: $url');
                            }),
                      ),
                      /*Visibility(
                          visible:
                              ((snapshot.data != null && snapshot.data == 0) ||
                                  snapshot.data == 10),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.5,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 8,
                                color: Colors.red,
                              ),
                            ),
                          )),*/
                    ],
                  )
                ],
              ),
            );
    });
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          // ignore: deprecated_member_use
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }
}
