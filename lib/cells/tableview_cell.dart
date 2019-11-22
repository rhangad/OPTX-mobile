import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TableViewCell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: EdgeInsets.only(top: 8, bottom: 8),
      child: InkWell(
        child: Container(
          width: double.infinity,
          height: ScreenUtil.getInstance().setHeight(100),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFFF4C954), Color(0xFFF9926F)]),
              borderRadius: BorderRadius.circular(6.0),
              boxShadow: [
                BoxShadow(
                    color: Color(0xFF7ECBED).withOpacity(.3),
                    offset: Offset(0.0, 8.0),
                    blurRadius: 8.0)
              ]),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              child: Center(
                child: Text("Test Cell",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        letterSpacing: 1.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
