import 'package:browser_app/provider/browser_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

Browserprovider? bt;
Browserprovider? bf;

class Browserscreen extends StatefulWidget {
  const Browserscreen({Key? key}) : super(key: key);

  @override
  State<Browserscreen> createState() => _BrowserscreenState();
}

class _BrowserscreenState extends State<Browserscreen> {
  TextEditingController txtsearch = TextEditingController();
  InAppWebViewController? inAppWebViewController;

  @override
  Widget build(BuildContext context) {
    bt = Provider.of<Browserprovider>(context, listen: true);
    bf = Provider.of<Browserprovider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 6.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                      color: Colors.blue.shade50),
                  child: TextField(
                    textInputAction: TextInputAction.search,
                    controller: txtsearch,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              inAppWebViewController!.loadUrl(
                                  urlRequest: URLRequest(
                                      url: Uri.parse(
                                          "https://www.google.com/search?q=${txtsearch.text}")));
                            },
                            icon: Icon(Icons.search,
                                color: Colors.blue, size: 30)),
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                        border: InputBorder.none,
                        hintText: "Searching"),
                  ),
                ),
                LinearProgressIndicator(
                    value: bt!.linearprogress,
                    color: Colors.blue,
                    backgroundColor: Colors.grey),
                Expanded(
                  child: InAppWebView(
                    initialUrlRequest:
                        URLRequest(url: Uri.parse("https://www.google.com/")),
                    onLoadStart: (controller, url) {
                      inAppWebViewController = controller;
                    },
                    onLoadStop: (controller, url) {
                      inAppWebViewController = controller;
                    },
                    onLoadError: (controller, url, code, message) {
                      inAppWebViewController = controller;
                    },
                    onProgressChanged: (controller, progress) {
                      inAppWebViewController = controller;
                      bf!.changeprogress(progress.toDouble());
                    },
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment(0,0.9),
              child: Container(
                height: 5.h,
                width: 60.w,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(onPressed: () {
                      inAppWebViewController!.goBack();
                    }, icon: Icon(Icons.arrow_back,color: Colors.white,size: 25)),
                    IconButton(onPressed: () {
                      inAppWebViewController!.reload();
                    }, icon: Icon(Icons.refresh,color: Colors.white,size: 25)),
                    IconButton(onPressed: () {
                      inAppWebViewController!.goForward();
                    }, icon: Icon(Icons.arrow_forward,color: Colors.white,size: 25))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
