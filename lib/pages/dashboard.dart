import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/cells/tableview_cell.dart';

class Dashboard extends StatelessWidget {
  // final String data;

  // Dashboard({
  //   Key key,
  //   @required this.data,
  // }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('WG Mobile'),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          // Padding(
          //   padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
          //   child: Table(
          //     children: [
          //       TableRow(
          //         children: [TableViewCell()],
          //       ),
          //       TableRow(
          //         children: [TableViewCell()],
          //       ),
          //       TableRow(
          //         children: [TableViewCell()],
          //       ),
          //       TableRow(
          //         children: [TableViewCell()],
          //       ),
          //       TableRow(
          //         children: [TableViewCell()],
          //       ),
          //       TableRow(
          //         children: [TableViewCell()],
          //       )
          //     ],
          //   ),
          // )
        ],
      )),
    );
  }
}
