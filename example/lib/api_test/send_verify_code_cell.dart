import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'package:thing_flutter_login_plugin/thing_flutter_login_plugin.dart';

class SendVerifyCodeCell extends StatefulWidget {
  final ThingFlutterLoginPlugin thingFlutterLoginPlugin;

  const SendVerifyCodeCell(this.thingFlutterLoginPlugin, {super.key});

  @override
  State<SendVerifyCodeCell> createState() => _SendVerifyCodeCell();
}

class _SendVerifyCodeCell extends State<SendVerifyCodeCell> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _countryCodeController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> testApi() async {
    var name = _nameController.text;
    var countryCode = _countryCodeController.text;
    var typeStr = _typeController.text;

    if (name.isEmpty) {
      Fluttertoast.showToast(msg: "账号不能为空", timeInSecForIosWeb: 3);
      return;
    }
    if (countryCode.isEmpty) {
      Fluttertoast.showToast(msg: "地区码不能为空", timeInSecForIosWeb: 3);
      return;
    }
    var type = int.tryParse(typeStr) ?? 0;

    if (type != 1 && type != 2 && type != 3) {
      Fluttertoast.showToast(msg: "验证码类型取值无法识别", timeInSecForIosWeb: 3);
      return;
    }
    print("请求发送验证码接口");
    await widget.thingFlutterLoginPlugin.sendVerifyCode(
        userName: name,
        countryCode: countryCode,
        type: type,
        success: () {
          print("请求发送验证码接口 成功");
          Fluttertoast.showToast(msg: "发送验证码接口 成功", timeInSecForIosWeb: 3);
        },
        failure: (msg) {
          print("请求发送验证码接口 失败，失败原因:$msg");
          Fluttertoast.showToast(msg: "发送验证码接口 失败原因:\n$msg", timeInSecForIosWeb: 3);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Text("发送验证码",
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w600)),
        TextField(
          controller: _nameController,
          decoration: InputDecoration(
            hintText: "用户的邮箱地址",
            suffixIcon: _nameController.text.isEmpty
                ? Container(width: 0)
                : IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _nameController.clear();
                      setState(() {});
                    },
                  ),
          ),
          onChanged: (text) {
            setState(() {});
          },
        ),
        TextField(
          controller: _countryCodeController,
          decoration: InputDecoration(
            hintText: "例如 86 代表中国大陆地区",
            suffixIcon: _countryCodeController.text.isEmpty
                ? Container(width: 0)
                : IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _countryCodeController.clear();
                      setState(() {});
                    },
                  ),
          ),
          onChanged: (text) {
            setState(() {});
          },
        ),
        TextField(
          controller: _typeController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: "1：注册账号 2：登录账号 3：重置密码",
            suffixIcon: _typeController.text.isEmpty
                ? Container(width: 0)
                : IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _typeController.clear();
                      setState(() {});
                    },
                  ),
          ),
          onChanged: (text) {
            setState(() {});
          },
        ),
        TextButton(
          child: const Text("测试接口请求"),
          onPressed: () {
            FocusScope.of(context).unfocus();
            testApi();
          },
        )
      ],
    );
  }
}
