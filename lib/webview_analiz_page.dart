import 'dart:async';
import 'package:bitcoinsistemi/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'notifier.dart';

const String kNavigationExamplePage = '';

class WebViewAnalizPage extends StatefulWidget {
  String url;
  double height;
  double margin;
  GlobalKey<ScaffoldState> _scaffoldKey;
  bool visible;
  StreamController<int>? events;

  WebViewAnalizPage(
      this.url, this.height, this._scaffoldKey, this.visible, this.margin,
      {required UniqueKey key, this.events})
      : super(key: key);

  @override
  _StateWebViewPage createState() => _StateWebViewPage();
}

class _StateWebViewPage extends State<WebViewAnalizPage> {
  String lastUrl = "";
  int value = 0;
  late WebViewController webViewController;
  late int x = 0;
  late int y = 0;
  late String? title = "";
  String url = "";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final cart = CartModel();

  @override
  void initState() {
    super.initState();

    Provider.of<CartModel>(context, listen: false).addListener(() {
      this.webViewController.loadUrl(Const.analiz);
      EasyLoading.show(status: 'loading...');
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      return SafeArea(
        child: Column(
          children: [
            ListTile(
              title: Text(
                "$title",
                maxLines: 1,
                style: TextStyle(
                    color: (Theme.of(context).brightness == Brightness.dark)
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
                  height: widget.height,
                  child: WebView(
                      key: _scaffoldKey,
                      initialUrl: Const.analiz,
                      javascriptMode: JavascriptMode.unrestricted,
                      onWebViewCreated: (controller) {
                        this.webViewController = controller;
                      },
                      javascriptChannels: <JavascriptChannel>{
                        _toasterJavascriptChannel(context),
                      },
                      onPageStarted: (String url) async {
                        widget.events!.sink.add(10);
                        if (!url.startsWith(
                                "https://www.bitcoinsistemi.com/") &&
                            !url.startsWith("https://en.bitcoinsistemi.com/") &&
                            url.isNotEmpty) {
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
                        EasyLoading.dismiss(animation: false);
                        lastUrl = url;
                      }),
                ),
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
