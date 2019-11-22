import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonTap extends StatelessWidget {
  bool show;
  MainAxisAlignment mainAxisAligntment;
  CrossAxisAlignment crossAxisAligntment;
  VoidCallback callback;

  ButtonTap(
    this.show,
    this.mainAxisAligntment,
    this.crossAxisAligntment,
    this.callback,
  );

  @override
  Widget build(BuildContext context) {
    if(!show)
      return Container();

    return Column(
      mainAxisAlignment: mainAxisAligntment,
      crossAxisAlignment: crossAxisAligntment,
      children: <Widget>[
        GestureDetector(
          onTap: callback,
          child: SizedBox(
              height: ScreenUtil.getInstance().setHeight(150),
              width: ScreenUtil.getInstance().setWidth(150),
              child: Container(
                color: Colors.red,
              )),
        ),
      ],
    );
  }
}
