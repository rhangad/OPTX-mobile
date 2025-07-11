import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/prefs/preferences.dart';
import 'package:my_app/bus/events.dart';
import 'widgets/form_card.dart';
import 'pages/dashboard.dart';
import 'widgets/button_tap.dart';
import 'dart:async';
import 'package:toast/toast.dart';

void main() => runApp(MaterialApp(
      home: Login(),
      debugShowCheckedModeBanner: false,
    ));

class Login extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<Login> {
  static final _qaCombo = "4123";
  static final _devCombo = "1234";
  String version = "Version 1.0";
  String status = '';
  Timer _timer;
  int _start;
  String combo = '';

  @override
  void initState() {
    super.initState();
    this.getDeviceStatus();
    this.initBus();
  }

  initBus(){
    eventBus.on<ResetVersionEvent>().listen((event){
      setStatus('');
    });
  }

  Widget horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: ScreenUtil.getInstance().setWidth(120),
          height: 1.0,
          color: Colors.black26.withOpacity(.2),
        ),
      );

  void getDeviceStatus() async {
    await Prefs.deviceStatus.then((value) {
      setState(() {
        print('>>>>' + value);
        status = value;
      });
      versionText();
    });
  }

  void resetTimer(v) {
    setState(() {
      _start = 4;
      combo += v;
      if (_timer != null) {
        _timer.cancel();
      }
    });
  }

  void checkStatus() async {
    if (status == '') {
      if (_qaCombo == combo) {
        setStatus('qa');
        Toast.show("QA", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);

        versionText();
      } else if (_devCombo == combo) {
        setStatus('dev');
        Toast.show("Dev", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        versionText();
      }
    }
  }

  void counter() {
    _timer = new Timer.periodic(
      Duration(seconds: 1),
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            combo = '';
            timer.cancel();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  void startTimer(v) {
    resetTimer(v);
    checkStatus();
    counter();
  }

  void versionText() {
    switch (status) {
      case 'qa':
        setVersion(version + "-qa");
        break;
      case 'dev':
        setVersion(version + "-dev");
        break;
      default:
        break;
    }
  }

  void setVersion(v) async {
    setState(() {
      version = v;
    });
    eventBus.fire(UpdateVersionEvent(v));
  }

  void setStatus(v) async {
    setState(() {
      status = v;
    });
    setVersion('Version 1.0');
    await Prefs.setDeviceStatus(v);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);

    return new Scaffold(
      backgroundColor: Color(0xFFF2A03A),
      resizeToAvoidBottomPadding: true,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 0.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(120),
                    ),
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(60),
                    ),
                    FormCard(),
                  ],
                ),
              ),
            ),
            // Container(
            //   width: double.infinity,
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: <Widget>[
            //       Center(
            //         child: new Text(
            //           combo,
            //           textAlign: TextAlign.center,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            ButtonTap(
              (status == ''),
              MainAxisAlignment.start,
              CrossAxisAlignment.start,
              () {
                startTimer('1');
              },
            ),
            ButtonTap(
              (status == ''),
              MainAxisAlignment.start,
              CrossAxisAlignment.end,
              () {
                startTimer('2');
              },
            ),
            ButtonTap(
              (status == ''),
              MainAxisAlignment.end,
              CrossAxisAlignment.end,
              () {
                startTimer('3');
              },
            ),
            ButtonTap(
              (status == ''),
              MainAxisAlignment.end,
              CrossAxisAlignment.start,
              () {
                startTimer('4');
              },
            ),
          ],
        ),
      ),
    );
  }
}

// void main() => runApp(MaterialApp(
//   home: MyApp(),
//   debugShowCheckedModeBanner: false,
//   ));

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => new _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
//     ScreenUtil.instance = ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
//     return new Scaffold(
//       backgroundColor: Colors.white,
//       resizeToAvoidBottomPadding: true,
//       body: Stack(
//         fit: StackFit.expand,
//         children: <Widget>[
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: <Widget>[

//             ],
//           )
//         ],
//       ),
//     );
//   }

// }

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or simply save your changes to "hot reload" in a Flutter IDE).
//         // Notice that the counter didn't reset back to zero; the application
//         // is not restarted.
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

//   void displayDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) => new AlertDialog(
//             title: new Text("Alert"),
//             content: new Text("My alert message"),
//             actions: [
//               CupertinoDialogAction(
//                   isDefaultAction: true,
//                   child: new Text("Close"),
//                   onPressed: () {
//                     Navigator.of(context, rootNavigator: true).pop("Close");
//                   },
//                   )
//             ],
//           ),
//     );
//   }

//   // CupertinoAlertDialog(
//   //   title: Text("Accept?"),
//   //   content: Text("Do you accept?"),
//   //   actions: [
//   //     CupertinoDialogAction("No"),
//   //     CupertinoDialogAction("Yes")
//   //   ]
//   // );

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Invoke "debug painting" (press "p" in the console, choose the
//           // "Toggle Debug Paint" action from the Flutter Inspector in Android
//           // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//           // to see the wireframe for each widget.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.display1,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: displayDialog,
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
