import 'package:flutter/material.dart';

class ThingFlutterAccountCell extends StatefulWidget {
  final TextEditingController textController;

  const ThingFlutterAccountCell({required this.textController, super.key});

  @override
  State<ThingFlutterAccountCell> createState() => _ThingFlutterAccountCell();
}

class _ThingFlutterAccountCell extends State<ThingFlutterAccountCell> {
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
          labelText: '账号',
          hintText: '请输入账号',
          prefixIcon: const Icon(Icons.person),
          suffixIcon: _controller.text.isEmpty
              ? Container(width: 0)
              : IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _controller.clear();
                    setState(() {});
                  },
                )),
      onChanged: (text) {
        setState(() {});
      },
    );
  }
}
