import 'package:final_project/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PollutionView extends StatefulWidget {
  const PollutionView({Key? key}) : super(key: key);

  @override
  _PollutionViewState createState() => _PollutionViewState();
}

class _PollutionViewState extends State<PollutionView> {
  late WebViewController controller;
  bool isLoading = true;
  final _key = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawerWidget(),
      appBar: AppBar(
        title: const Text("Pollution Map"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          WebView(
            key: _key,
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl: 'https://waqi.info/',
            onWebViewCreated: (controller) {
              this.controller = controller;
            },
            onPageFinished: (finish) {
              controller.runJavascript(
                  "document.getElementsByClassName('header')[0].style.display='none'");
              controller.runJavascript(
                  "document.getElementsByTagName('center')[0].style.display='none'");
              controller.runJavascript(
                  "document.getElementsByTagName('body')[0].style.backgroundColor='transparent'");
              controller.runJavascript(
                  "document.getElementsByTagName('button')[0].style.display='none'");
              controller.runJavascript("document.getElementById('google_image_div').remove()");
              setState(() {
                isLoading = false;
              });
            },
          ),
          isLoading ? const Center( child: CircularProgressIndicator(),)
              : Stack(),
        ],
      ),
    );
  }
}
