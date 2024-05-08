import 'package:flutter/material.dart';
import '../model/thing_flutter_country_code_config.dart';

class ThingFlutterChooseRegionPage extends StatefulWidget {
  final String region;

  const ThingFlutterChooseRegionPage({required this.region, super.key});

  @override
  State<ThingFlutterChooseRegionPage> createState() =>
      _ThingFlutterChooseRegionPage();
}

class _ThingFlutterChooseRegionPage
    extends State<ThingFlutterChooseRegionPage> {
  late List<String> _list;

  @override
  void initState() {
    super.initState();
    _list = ThingFlutterCountryCodeConfig.sCountryCodeMap.keys.toList();
    _list.sort();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('选择地区')),
      body: ListView.builder(
          itemCount: _list.length,
          itemBuilder: (BuildContext context, int index) {
            String region = _list[index];
            final bool isSelected = region == widget.region;
            return ListTile(
              title: Text(region),
              tileColor: isSelected ? Colors.blue[100] : null,
              onTap: () {
                setState(() {
                  Navigator.pop(context, region);
                });
              },
            );
          }
      ),
    );
  }
}