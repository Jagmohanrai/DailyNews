import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:newsApp/constants.dart' as cst;

class ArticleView extends StatefulWidget {
  final String url;
  ArticleView({this.url});
  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  final Completer<WebViewController> _completer =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            Opacity(
              opacity: 0,
              child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 16 * cst.responsiveCofficient(context)),
                  child: Icon(Icons.access_alarm)),
            )
          ],
          elevation: 0.0,
          title: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Daily',
                  style: TextStyle(
                    fontSize: 22 * cst.responsiveCofficient(context),
                  ),
                ),
                Text(
                  'News',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 22 * cst.responsiveCofficient(context),
                  ),
                )
              ],
            ),
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: WebView(
            initialUrl: widget.url,
            onWebViewCreated: ((WebViewController webviewcontroller) {
              _completer.complete(webviewcontroller);
            }),
          ),
        ),
      ),
    );
  }
}
