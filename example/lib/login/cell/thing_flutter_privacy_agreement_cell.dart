import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:thing_flutter_login_plugin_example/login/cell/thing_flutter_overlay_loading.dart';

class ThingFlutterPrivacyAgreementCell extends StatefulWidget {
  final Function(bool checked)? onValueChange;

  const ThingFlutterPrivacyAgreementCell({this.onValueChange, super.key});

  @override
  State<ThingFlutterPrivacyAgreementCell> createState() =>
      _ThingFlutterPrivacyAgreementCell();
}

class _ThingFlutterPrivacyAgreementCell
    extends State<ThingFlutterPrivacyAgreementCell> {
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black, fontSize: 16.0),
          children: <InlineSpan>[
            WidgetSpan(
              child: SizedBox(
                width: 18,
                height: 18,
                child: Checkbox(
                  value: _checked,
                  onChanged: (bool? value) {
                    setState(() {
                      _checked = !_checked;

                      if (widget.onValueChange != null) {
                        widget.onValueChange!(_checked);
                      }

                    });
                  },
                ),
              ),
            ),
            const TextSpan(text: ' 我同意'),
            TextSpan(
              text: '隐私协议',
              style: const TextStyle(color: Colors.blue),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  ThingOverlayLoading.showToast("查看隐私协议");
                },
            ),
            const TextSpan(text: '，以及其他其他其他其他其他其他其他其他其他协议'),
            TextSpan(
              text: '用户协议',
              style: const TextStyle(color: Colors.blue),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  ThingOverlayLoading.showToast( "查看用户协议");
                },
            ),

          ],
        ),
      ),
    );
  }
}
