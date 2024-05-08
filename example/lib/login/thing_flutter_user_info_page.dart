import 'package:flutter/material.dart';

class ThingUserInfoPage extends StatelessWidget {
  final Map<String, dynamic> userInfo;
  final List<String> _showInfoKeys = [
    "userName",
    "nickname",
    "email",
    "uid",
    "countryCode"
  ];

  ThingUserInfoPage({required this.userInfo, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('用户信息')),
      body: ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: _showInfoKeys.length,
          itemBuilder: (BuildContext context, int index) {
            String showKey = _showInfoKeys[index];
            String? showValue = userInfo[showKey];
            return SizedBox(
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(showKey),
                    Text(showValue ?? ''),
                  ],
                ));
          }),
    );
  }
}
