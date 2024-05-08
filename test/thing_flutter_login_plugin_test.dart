import 'package:flutter_test/flutter_test.dart';
import 'package:thing_flutter_login_plugin/thing_flutter_login_plugin.dart';
import 'package:thing_flutter_login_plugin/thing_flutter_login_plugin_platform_interface.dart';
import 'package:thing_flutter_login_plugin/thing_flutter_login_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockThingFlutterLoginPluginPlatform
    with MockPlatformInterfaceMixin
    implements ThingFlutterLoginPluginPlatform {
  //
  // @override
  // Future<String?> getPlatformVersion() => Future.value('42');

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  final ThingFlutterLoginPluginPlatform initialPlatform = ThingFlutterLoginPluginPlatform.instance;

  test('$MethodChannelThingFlutterLoginPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelThingFlutterLoginPlugin>());
  });

  test('getPlatformVersion', () async {
    // ThingFlutterLoginPlugin thingFlutterLoginPlugin = ThingFlutterLoginPlugin();
    MockThingFlutterLoginPluginPlatform fakePlatform = MockThingFlutterLoginPluginPlatform();
    ThingFlutterLoginPluginPlatform.instance = fakePlatform;

    // expect(await thingFlutterLoginPlugin.getPlatformVersion(), '42');
  });
}
