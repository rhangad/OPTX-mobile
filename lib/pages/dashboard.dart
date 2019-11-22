import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/cells/tableview_cell.dart';
import 'package:my_app/db/user.dart';
import 'package:my_app/utils/device_info.dart';
import 'package:my_app/widgets/collapsible.dart';

class Dashboard extends StatefulWidget {

  static final _deviceInfo = DeviceInfo();

  // static final _userProvider = UserProvider();

  @override
  _DashboardState createState() => _DashboardState(deviceInfo: _deviceInfo);
}

class _DashboardState extends State<Dashboard> {

  Map<String, dynamic> deviceData;

  DeviceInfo deviceInfo;

  // UserProvider userProvider;

  // User user = User();

  _DashboardState({ this.deviceInfo });

  @override
  void initState() { 
    super.initState();
    
    this.getDeviceInfo();

    // this.createUser();

    // this.getUser();
  }

  void getDeviceInfo() async {
    final data = await deviceInfo.getData();

    setState(() {
      deviceData = data;
    });
  }

  // void createUser() async {
  //   await userProvider.open();

  //   var user = User();

  //   user.firstname = "Juan";
  //   user.lastname = "Dela Cruz";

  //   await userProvider.insert(user);
  //   await userProvider.close();
  // }

  // void getUser() async {
  //   await userProvider.open();

  //   var user = await userProvider.getUser(1);

  //   debugPrint(user.firstname);

  //   setState(() {
  //     this.user = user;
  //   });

  //   await userProvider.close();
  // }

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
          deviceInfoList()
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

  Widget deviceInfoList() {
    if(Platform.isAndroid) {
      return Column(
        children: <Widget>[
          listItem("id:", deviceData["id"]),
          listItem("androidId:", deviceData["androidId"]),
          listItem("isPhysicalDevice:", deviceData["isPhysicalDevice"] ? "yes" : "no"),
          listItem("version.securityPatch:", deviceData["version.securityPatch"]),
          listItem("version.sdkInt:", deviceData["version.sdkInt"].toString()),
          listItem("version.release:", deviceData["version.release"]),
          listItem("version.incremental:", deviceData["version.incremental"]),
          listItem("version.codename:", deviceData["version.codename"]),
          listItem("version.baseOS:", deviceData["version.securityPatch"]),
          listItem("board:", deviceData["board"]),
          listItem("bootloader:", deviceData["bootloader"]),
          listItem("brand:", deviceData["brand"]),
          listItem("device:", deviceData["device"]),
          listItem("host:", deviceData["host"]),
          listItem("manufacturer:", deviceData["manufacturer"]),
          listItem("model:", deviceData["model"]),
          listItem("product:", deviceData["product"]),
          listItem("tags:", deviceData["tags"]),
          listItem("type:", deviceData["type"]),
        ],
      );
    } else if(Platform.isIOS) {
      return Column(
        children: <Widget>[
          listItem("name:", deviceData["name"]),
          listItem("systemName:", deviceData["systemName"]),
          listItem("systemVersion:", deviceData["systemVersion"]),
          listItem("model:", deviceData["model"]),
          listItem("localizedModel:", deviceData["localizedModel"]),
          listItem("identifierForVendor:", deviceData["identifierForVendor"]),
          listItem("isPhysicalDevice:", deviceData["isPhysicalDevice"]),
          listItem("utsname.sysname:", deviceData["utsname.sysname"]),
          listItem("utsname.nodename:", deviceData["utsname.nodename"]),
          listItem("utsname.release:", deviceData["utsname.release"]),
          listItem("utsname.version:", deviceData["utsname.version"]),
          listItem("utsname.machine:", deviceData["utsname.machine"]),
        ],
      );
    }
    return Text("Unsupported Device");
  }

}
