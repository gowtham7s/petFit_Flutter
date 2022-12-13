import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HelpWebView extends StatefulWidget {
  final String title;
  final String url;
  const HelpWebView({super.key, required this.url, required this.title});

  @override
  State<HelpWebView> createState() => _HelpWebViewState();
}

class _HelpWebViewState extends State<HelpWebView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: WebView(
        initialUrl: widget.url,
      ),
    );
  }

  // //this part isn't working
  // @override
  // void dispose() {
  //   _HelpWebViewState();
  //   // close the webview here
  //   super.dispose();
  // }
}