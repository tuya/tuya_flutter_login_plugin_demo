import 'package:flutter/material.dart';
import 'package:thing_flutter_login_plugin/thing_flutter_login_plugin.dart';
import 'cell/thing_flutter_overlay_loading.dart';
import 'cell/thing_flutter_region_cell.dart';
import 'cell/thing_flutter_account_cell.dart';
import 'cell/thing_flutter_password_cell.dart';
import 'cell/thing_flutter_privacy_agreement_cell.dart';
import 'cell/thing_flutter_verify_code_cell.dart';

class ThingRegisterPage extends StatefulWidget {
  const ThingRegisterPage({super.key});

  @override
  State<ThingRegisterPage> createState() => _ThingRegisterPage();
}

class _ThingRegisterPage extends State<ThingRegisterPage> {
  final _thingFlutterLoginPlugin = ThingFlutterLoginPlugin();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final ThingOverlayLoading _loading = ThingOverlayLoading();

  String _regionCode = '86';
  var _checked = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> register() async {
    if (!_checked) {
      ThingOverlayLoading.showToast("需要勾选同意用户协议");
      return;
    }

    var email = _emailController.text;
    var password = _passwordController.text;
    var code = _codeController.text;

    if (email.isEmpty) {
      ThingOverlayLoading.showToast("账号不能为空");
      return;
    }
    if (password.isEmpty) {
      ThingOverlayLoading.showToast("密码不能为空");
      return;
    }
    if (code.isEmpty) {
      ThingOverlayLoading.showToast("验证码不能为空");
      return;
    }

    _loading.show(context);

    await _thingFlutterLoginPlugin.registerByEmail(
        countryCode: _regionCode,
        email: email,
        password: password,
        code: code,
        success: () {
          _loading.hidden();
          Navigator.pop(context);
        },
        failure: (msg) {
          _loading.hidden();
          ThingOverlayLoading.showToast(msg);
        });
  }

  Future<void> sendVerifyCode() async {
    var email = _emailController.text;

    if (email.isEmpty) {
      ThingOverlayLoading.showToast("账号不能为空");
      return;
    }
    _loading.show(context);
    await _thingFlutterLoginPlugin.sendVerifyCode(
        userName: email,
        countryCode: _regionCode,
        type: 1,
        success: () {
          _loading.hidden();
          ThingOverlayLoading.showToast("已发送验证码，请去邮箱查看");
        },
        failure: (msg) {
          _loading.hidden();
          ThingOverlayLoading.showToast(msg);
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(),
          body: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const Text('注 册',
                  textAlign: TextAlign.left,
                  style:
                      TextStyle(fontSize: 28.0, fontWeight: FontWeight.w600)),
              const SizedBox(
                height: 15,
              ),
              ThingFlutterRegionCell(
                  regionCode: _regionCode,
                  didSelect: (String s) {
                    _regionCode = s;
                  }),
              ThingFlutterAccountCell(textController: _emailController),
              ThingFlutterPasswordCell(textController: _passwordController),
              ThingFlutterVerifyCodeCell(
                textController: _codeController,
                clickAction: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  sendVerifyCode();
                },
              ),
              ThingFlutterPrivacyAgreementCell(onValueChange: (e) {
                _checked = e;
              }),
              const SizedBox(
                height: 15,
              ),
              TextButton(
                onPressed: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  register();
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFFFF592A),
                ),
                child: const Text(
                  '注 册',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
        ));
  }
}
