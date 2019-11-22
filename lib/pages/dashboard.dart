import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/cells/tableview_cell.dart';
import 'package:my_app/utils/device_info.dart';
import 'package:my_app/widgets/collapsible.dart';

class Dashboard extends StatefulWidget {

  static final _deviceInfo = DeviceInfo();

  @override
  _DashboardState createState() => _DashboardState(deviceInfo: _deviceInfo);
}

class _DashboardState extends State<Dashboard> {

  Map<String, dynamic> deviceData;

  DeviceInfo deviceInfo;

  _DashboardState({ this.deviceInfo });

  @override
  void initState() { 
    super.initState();
    
    this.getDeviceInfo();
  }

  void getDeviceInfo() async {
    final data = await deviceInfo.getData();

    setState(() {
      deviceData = data;
    });
  }


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
          Text("Device Information", style: TextStyle(fontSize: 18),),

          // Collapsible(
          //   title: "General",
          //   children: <Widget>[
          //     listItem("Account Number:", "11781"),
          //     listItem("Name:", "Juan Dela Cruz"),
          //     listItem("Birthday:", "December 31, 1990"),
          //     listItem("Last Play Date:", "January 1, 1991"),
          //     listItem("Host:", "None"),
          //     listItem("Last Contact:", "None"),
          //     Text(deviceData.toString()),
          //     SizedBox(
          //       height: 20,
          //     )
          //   ],
          // ),
        ],
      )),
    );
  }

  Widget listItem(key, value) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(key),
          Text(value),
        ],
      ),
    );
  }

  List<Widget> itemFromDeviceInfo(Map<String, dynamic> deviceData) {
    return deviceData
      .map((key, value) => {
        return listItem(key, value)
      })
  } 
}
