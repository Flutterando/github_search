import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GithubPagePage extends StatefulWidget {
  final String title;
  final String url;

  const GithubPagePage(this.url, {Key key, this.title = "GithubPage"})
      : super(key: key);

  @override
  _GithubPagePageState createState() => _GithubPagePageState();
}

class _GithubPagePageState extends State<GithubPagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
