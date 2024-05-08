import 'package:flutter/material.dart';

class ThingFlutterVerifyCodeCell extends StatefulWidget {
  final TextEditingController textController;
  final Function() clickAction;

  const ThingFlutterVerifyCodeCell(
      {required this.textController, required this.clickAction, super.key});

  @override
  State<ThingFlutterVerifyCodeCell> createState() =>
      _ThingFlutterVerifyCodeCell();
}

class _ThingFlutterVerifyCodeCell extends State<ThingFlutterVerifyCodeCell> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.textController;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
          labelText: '验证码',
          hintText: '请输入验证码',
          prefixIcon: const Icon(Icons.safety_check),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_controller.text.isNotEmpty)
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _controller.clear();
                    setState(() {});
                  },
                ),
              IconButton(
                icon: const Text('发送验证码'),
                onPressed: widget.clickAction,
              ),
            ],
          )),
      onChanged: (text) {
        setState(() {});
      },
    );
  }
}
