import 'package:flutter/material.dart';
import 'package:thing_flutter_login_plugin/thing_flutter_login_plugin.dart';
import 'package:thing_flutter_login_plugin_example/login/thing_flutter_user_info_page.dart';
import 'cell/thing_flutter_overlay_loading.dart';
import 'thing_flutter_register_page.dart';
import 'cell/thing_flutter_region_cell.dart';
import 'cell/thing_flutter_account_cell.dart';
import 'cell/thing_flutter_password_cell.dart';
import 'cell/thing_flutter_privacy_agreement_cell.dart';

class ThingLoginPage extends StatefulWidget {
  const ThingLoginPage({super.key});

  @override
  State<ThingLoginPage> createState() => _ThingLoginPage();
}

class _ThingLoginPage extends State<ThingLoginPage> {
  final _thingFlutterLoginPlugin = ThingFlutterLoginPlugin();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ThingOverlayLoading _loading = ThingOverlayLoading();

  String _regionCode = '86';
  var _checked = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> login() async {
    if (!_checked) {
      ThingOverlayLoading.showToast("需要勾选同意用户协议");
      return;
    }

    var email = _emailController.text;
    var password = _passwordController.text;

    if (email.isEmpty) {
      ThingOverlayLoading.showToast("账号不能为空");
      return;
    }
    if (password.isEmpty) {
      ThingOverlayLoading.showToast("密码不能为空");
      return;
    }
    _loading.show(context);
    await _thingFlutterLoginPlugin.loginByEmail(
        countryCode: _regionCode,
        email: email,
        password: password,
        success: (Map<String, dynamic> userInfo) {
          _loading.hidden();

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ThingUserInfoPage(userInfo: userInfo)),
          );
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
          appBar: AppBar(
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ThingRegisterPage()),
                    );
                  },
                  child: const Text('注 册'))
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const Text('登 陆',
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
              ThingFlutterPrivacyAgreementCell(onValueChange: (e) {
                _checked = e;
              }),
              const SizedBox(
                height: 15,
              ),
              TextButton(
                onPressed: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  login();
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFFFF592A),
                ),
                child: const Text(
                  '登 陆',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
        ));
  }
}
