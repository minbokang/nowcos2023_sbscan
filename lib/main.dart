import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


import 'clock.dart';
import 'clock_text.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'w_home_page.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

String url = "https:\\FlutterCentral.com";


void main() {
  runApp(const MaterialApp(
    home: SplashScreen(),
  ));
}


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<Timer> loadData() async {
    return Timer(const Duration(seconds: 3), onDoneLoading);
  }

  onDoneLoading() async {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>   HomeScreen() ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('asset/intro2.png'),
            fit: BoxFit.cover
        ) ,
      ),
      child: const Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
//          mainAxisSize: MainAxisSize.min,
//          mainAxisSize: MainAxisSize.max,
//          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[ CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
          ),
            Text('  version: 0.1', style: TextStyle(fontSize: 10.0,color: Colors.grey, decoration:TextDecoration.none),),
          ]

      ),
    );
  }
}


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String result = "";
  String webViewUrl = "http://61.85.139.4/nowcos/for_mobile/";
  InAppWebViewController? webViewController;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: webViewUrl != "http://61.85.139.4/nowcos/for_mobile/"
            ? IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              webViewUrl = "http://61.85.139.4/nowcos/for_mobile/";
            });
          },
        )
            : null,
        title: Text("Nowcos App"),
        actions: <Widget>[
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.clock),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AppClock()),
              );
            },
          ),
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.beerMugEmpty),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AppWheel()),
            ),
          ),
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.barcode),
            onPressed: () async {
              var res = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SimpleBarcodeScannerPage(),
                ),
              );
              setState(() {
                if (res is String) {
                  result = res;
                  webViewUrl = "http://61.85.139.4/nowcos/for_mobile/get_info.php?barcode=$result";
                }
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          InAppWebView(
            initialUrlRequest: URLRequest(url: Uri.parse(webViewUrl)),
            onWebViewCreated: (controller) {
              webViewController = controller;
            },
            onLoadStart: (controller, url) {
              setState(() {
                isLoading = true;
              });
            },
            onLoadStop: (controller, url) {
              setState(() {
                isLoading = false;
              });
            },
            key: ValueKey(webViewUrl),
          ),
          // if (isLoading)  // Placeholder: Show loader until WebView finishes loading
          //   Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}


class WebViewScreen extends StatelessWidget {
  final String initialUrl;

  WebViewScreen({required this.initialUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context), // Go back to previous screen
        ),
        title: Text('WebView'),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse(initialUrl)),
      ),
    );
  }
}

////// clock

class AppClock extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" "),
      ),
      body: const Padding(

        padding: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text("마지막으로 자신에게 투자한 것은 언제입니까? "),
//            new RaisedButton(
//                onPressed: () {
//                  Navigator.pop(context);
//                } ,child: Text('Go back!'),),

            Clock(
              circleColor: Colors.black,
              showBellsAndLegs: false,
              bellColor: Colors.green,
              clockText: ClockText.arabic,
//                clockText: ClockText.roman,
              showHourHandleHeartShape: false,
            ),
          ],
        ),
      ),
    );
  }
}
////// clock


class AppWheel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(' '),
        backgroundColor: Colors.pinkAccent,
      ),
      body: HomePage(),
    );

  }
}

// https
// https://stackoverflow.com/questions/55592392/how-to-fix-neterr-cleartext-not-permitted-in-flutter