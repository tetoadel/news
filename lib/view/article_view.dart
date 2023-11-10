import 'package:flutter/material.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class ArticleView extends StatefulWidget {
  const ArticleView({super.key, this.blogUrl});
  final String? blogUrl;

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Image.asset('assets/download.png',width: 300,),
      ),
      body: WebViewPlus(
        initialUrl: widget.blogUrl,
      ),
    );
  }
}

