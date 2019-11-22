import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/pages/dashboard.dart';
import 'package:my_app/bus/events.dart';

class FormCard extends StatefulWidget {
  @override
  FormCardState createState() => FormCardState();
}

class FormCardState extends State<FormCard> {
  bool rememberMe = false;
  String _version = 'Version 1.0';
  
  FocusNode passwordFocusNode = new FocusNode();

  @override
  void initState() {
    super.initState();
    this.initBus();
  }

  void resetVersion() {
    eventBus.fire(ResetVersionEvent());
  }

  initBus(){
    eventBus.on<UpdateVersionEvent>().listen((event){
      setState(() {
        this._version = event.text;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return new Container(
      width: double.infinity,
      height: ScreenUtil.getInstance().setHeight(1000),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 15.0),
                blurRadius: 15.0),
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, -10.0),
                blurRadius: 10.0),
          ]),
      child: Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 50, right: 50, top: 28),
              child: Image.asset('assets/images/optx-logo.png'),
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(20),
            ),
            Center(
              child: Text("Welcome back!",
                  style: TextStyle(
                      fontSize: ScreenUtil.getInstance().setSp(45),
                      fontWeight: FontWeight.normal,
                      letterSpacing: .6),
                  textAlign: TextAlign.center),
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),
            TextField(
              cursorColor: Color(0xFFF7C759),
              decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.grey),
                  labelText: "Username",
                  focusColor: Color(0xFFF7C759),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Color(0xFFF7C759), width: 2.0),
                  )),
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),
            TextField(
              cursorColor: Color(0xFFF7C759),
              obscureText: true,
              decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.grey),
                  labelText: "Password",
                  focusColor: Color(0xFFF7C759),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Color(0xFFF7C759), width: 2.0),
                  )),
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(35),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Checkbox(
                  value: rememberMe,
                  onChanged: (bool value) {
                    setState(() {
                      rememberMe = value;
                    });
                  },
                  activeColor: Color(0xFFF7C759),
                ),
                Text(
                  "Remember me",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: ScreenUtil.getInstance().setSp(28)),
                ),
                SizedBox(
                  width: ScreenUtil.getInstance().setWidth(70),
                ),
                Text(
                  "Forgot Password?",
                  style: TextStyle(
                      color: Color(0xFFF7C759),
                      fontWeight: FontWeight.w500,
                      fontSize: ScreenUtil.getInstance().setSp(28)),
                )
              ],
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(35),
            ),
            SizedBox(
              width: double.infinity,
              height: ScreenUtil.getInstance().setHeight(60),
              child: RaisedButton(
                color: Color(0xFFF7C759),
                textColor: Colors.white,
                child: new Text("Login"),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Dashboard()));
                },
              ),
            ),
            
            GestureDetector(
              onLongPress: (){resetVersion();},
              child: Container(
                padding: EdgeInsets.all(8),
                width: double.infinity,
                child: Text(_version,textAlign: TextAlign.center,),
              ),
            )
          ],
        ),
      ),
    );
  }
}
