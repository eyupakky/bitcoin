import 'package:bitcoinsistemi/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AdsWidget extends StatefulWidget{
  late String url;
  AdsWidget(this.url);
  @override
  State<AdsWidget> createState() => _AdsWidgetState();
}

class _AdsWidgetState extends State<AdsWidget> {
  late WebViewController webViewController;
  late String launchUrl = "";
  late double height=110;

  @override
  Widget build(BuildContext context) {
   return  SizedBox(
      height: height,
      width: MediaQuery.of(context).size.width,
      child: WebView(
        initialUrl: widget.url,
        zoomEnabled: false,
        javascriptMode: JavascriptMode.unrestricted,
        gestureNavigationEnabled: true,
        onWebViewCreated: (WebViewController webViewController) {
          this.webViewController = webViewController;
        },
        onPageStarted: (url){
          if(!url.contains(widget.url)){
            launch(url);
            this.webViewController.loadUrl(widget.url);
          }
        },
      ),
    );
  }
}