class ThingFlutterCountryCodeConfig {
  static final Map<String, String> sCountryCodeMap = {
    '中国': '86',
    '美国': '66',
  };

  static String? countryNameWithCode(String code) {
    for (var e in sCountryCodeMap.entries) {
      if (e.value == code) {
        return e.key;
      }
    }
    return null;
  }

  static String? countryCodeWithName(String name) {
    for (var e in sCountryCodeMap.entries) {
      if (e.key == name) {
        return e.value;
      }
    }
    return null;
  }
}
