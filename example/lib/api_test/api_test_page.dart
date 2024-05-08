import 'package:flutter/material.dart';
import 'package:thing_flutter_login_plugin/thing_flutter_login_plugin.dart';
import 'dart:math';
import 'send_verify_code_cell.dart';
import 'register_by_email_cell.dart';
import 'login_by_email_cell.dart';
import '../login/thing_flutter_login_page.dart';

class ApiTestPage extends StatefulWidget {
  @override
  State<ApiTestPage> createState() => _ApiTestPage();
}

class _ApiTestPage extends State<ApiTestPage> {
  final _thingFlutterLoginPlugin = ThingFlutterLoginPlugin();

  Color getRandomColor() {
    Random random = Random();
    return Color.fromRGBO(
      random.nextInt(256), // 红色分量 0-255
      random.nextInt(256), // 绿色分量 0-255
      random.nextInt(256), // 蓝色分量 0-255
      1, // 不透明度设置为 1
    );
  }

  Widget myCell(Widget child) {
    return Container(
        padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
        decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: getRandomColor(), width: 2),
            )),
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('接口测试'),
          actions: [
            TextButton(onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ThingLoginPage()),
              );
            }, child: const Text('登陆Demo'))
          ],
        ),
        body: ListView(children: <Widget>[
          myCell(SendVerifyCodeCell(_thingFlutterLoginPlugin)),
          myCell(RegisterByEmail(_thingFlutterLoginPlugin)),
          myCell(LoginByEmail(_thingFlutterLoginPlugin)),
        ]),
      ),
    );
  }
}
