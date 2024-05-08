import 'package:flutter/material.dart';

class ThingFlutterPasswordCell extends StatefulWidget {
  final TextEditingController textController;

  const ThingFlutterPasswordCell({required this.textController, super.key});

  @override
  State<ThingFlutterPasswordCell> createState() => _ThingFlutterPasswordCell();
}

class _ThingFlutterPasswordCell extends State<ThingFlutterPasswordCell> {
  late TextEditingController _controller;
  var _obscure = true;

  @override
  void initState() {
    super.initState();
    _controller = widget.textController;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      obscureText: _obscure,
      decoration: InputDecoration(
          labelText: '密码',
          hintText: '请输入密码',
          prefixIcon: const Icon(Icons.lock),
          suffixIcon: _controller.text.isEmpty
              ? Container(width: 0)
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: _obscure
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _obscure = !_obscure;
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _controller.clear();
                        setState(() {});
                      },
                    ),
                  ],
                )),
      onChanged: (text) {
        setState(() {});
      },
    );
  }
}
