import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'package:thing_flutter_login_plugin/thing_flutter_login_plugin.dart';

class LoginByEmail extends StatefulWidget {
  final ThingFlutterLoginPlugin thingFlutterLoginPlugin;

  const LoginByEmail(this.thingFlutterLoginPlugin, {super.key});

  @override
  State<LoginByEmail> createState() => _LoginByEmail();
}

class _LoginByEmail extends State<LoginByEmail> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _countryCodeController = TextEditingController();
  var _obscurePassWord = true;

  @override
  void initState() {
    super.initState();
  }

  Future<void> testApi() async {
    var name = _nameController.text;
    var password = _passwordController.text;
    var countryCode = _countryCodeController.text;

    if (name.isEmpty) {
      Fluttertoast.showToast(msg: "账号不能为空", timeInSecForIosWeb: 3);
      return;
    }
    if (password.isEmpty) {
      Fluttertoast.showToast(msg: "密码不能为空", timeInSecForIosWeb: 3);
      return;
    }
    if (countryCode.isEmpty) {
      Fluttertoast.showToast(msg: "地区码不能为空", timeInSecForIosWeb: 3);
      return;
    }

    print("请求登陆邮箱账号接口");
    await widget.thingFlutterLoginPlugin.loginByEmail(
        countryCode: countryCode,
        email: name,
        password: password,
        success: (Map<String, dynamic> userInfo) {
          print("请求登陆邮箱账号接口成功，账号信息:$userInfo");
          Fluttertoast.showToast(msg: "请求登陆邮箱账号接口成功，账号信息:\n$userInfo", timeInSecForIosWeb: 3);
        },
        failure: (msg) {
          print("请求登陆邮箱账号接口 失败，失败原因:$msg");
          Fluttertoast.showToast(
              msg: "请求登陆邮箱账号接口 失败原因:\n$msg", timeInSecForIosWeb: 3);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Text("登陆邮箱账号",
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
          controller: _passwordController,
          obscureText: _obscurePassWord,
          decoration: InputDecoration(
              hintText: "密码",
              suffixIcon: _passwordController.text.isEmpty
                  ? Container(width: 0)
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: _obscurePassWord
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _obscurePassWord = !_obscurePassWord;
                            });
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _passwordController.clear();
                            setState(() {});
                          },
                        ),
                      ],
                    )
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
