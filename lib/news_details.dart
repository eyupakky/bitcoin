import 'dart:async';
import 'package:bitcoinsistemi/news_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetails extends StatefulWidget {
  final NewsModel item;

  const NewsDetails({Key? key, required this.item}) : super(key: key);

  @override
  _NewsDetailsState createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black45,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                child: CachedNetworkImage(
                  imageUrl: "${widget.item.yoastHeadJson!.ogImage![0].url}",
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(value: downloadProgress.progress),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*2,
                child: Html(
                  data: "${widget.item.content!.rendered!}",
                ),
              )
            ],
          ),
        ));
  }
}
