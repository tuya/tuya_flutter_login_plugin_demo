import 'package:flutter/material.dart';
import 'thing_flutter_choose_region_page.dart';
import '../model/thing_flutter_country_code_config.dart';

class ThingFlutterRegionCell extends StatefulWidget {
  final String? regionCode;
  final void Function(String region)? didSelect;

  const ThingFlutterRegionCell({this.regionCode, this.didSelect, super.key});

  @override
  State<ThingFlutterRegionCell> createState() => _ThingFlutterRegionCell();
}

class _ThingFlutterRegionCell extends State<ThingFlutterRegionCell> {
  late String _regionCode;
  late String _regionName;

  @override
  void initState() {
    super.initState();
    _setupRegion(widget.regionCode);

    if (!_setupRegion(widget.regionCode)) {
      _setupRegion('86');
    }
  }

  bool _setupRegion(String? region) {
    if (region != null) {
      String? regionName =
          ThingFlutterCountryCodeConfig.countryNameWithCode(region);

      if (regionName != null) {
        _regionCode = region;
        _regionName = regionName;
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {},
        child: TextField(
            readOnly: true,
            canRequestFocus: false,
            onTap: () async {
              String? region = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ThingFlutterChooseRegionPage(region: _regionName)),
              );
              if (region != null) {
                String? code =
                    ThingFlutterCountryCodeConfig.countryCodeWithName(region);

                if (code != null) {
                  setState(() {
                    _regionCode = code;
                    _regionName = region;

                    if (widget.didSelect != null) {
                      widget.didSelect!(_regionCode);
                    }
                  });
                }
              }
            },
            decoration: InputDecoration(
                labelText: _regionName,
                prefixIcon: Container(
                  width: 25,
                  alignment: Alignment.center,
                  child: Image.asset('assets/icon_login_location.png',
                      width: 25, height: 25, fit: BoxFit.contain),
                ),
                suffixIcon: Container(
                    width: 25,
                    alignment: Alignment.center,
                    child: Image.asset('assets/icon_arrow_down.png',
                        width: 25, height: 25, fit: BoxFit.contain)))));
  }
}
