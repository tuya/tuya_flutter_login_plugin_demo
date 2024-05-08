import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'thing_flutter_login_plugin_method_channel.dart';

abstract class ThingFlutterLoginPluginPlatform extends PlatformInterface {
  /// Constructs a ThingFlutterLoginPluginPlatform.
  ThingFlutterLoginPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static ThingFlutterLoginPluginPlatform _instance =
      MethodChannelThingFlutterLoginPlugin();

  /// The default instance of [ThingFlutterLoginPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelThingFlutterLoginPlugin].
  static ThingFlutterLoginPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ThingFlutterLoginPluginPlatform] when
  /// they register themselves.
  static set instance(ThingFlutterLoginPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  //发送验证码
  Future<void> sendVerifyCode({
    required String userName, //用户的邮箱地址或手机号码
    String? region,
    //地区，可以通过 [ThingSmartUser regionListWithCountryCode:success:failure:] 或者 [ThingSmartUser getDefaultRegionWithCountryCode:] 查询
    required String countryCode, //国家或地区码，例如 86 代表中国大陆地区
    required int type,
    //验证码类型。取值：1：使用邮箱地址注册账号时，发送验证码 2：使用邮箱地址登录账号时，发送验证码 3：重置邮箱地址注册的账号的密码时，发送验证码
    void Function()? success, //接口发送成功回调
    void Function(String error)? failure, //接口发送失败回调，error 表示失败原因
  }) async {
    throw UnimplementedError('sendVerifyCode() has not been implemented.');
  }

  //使用邮箱地址注册账号
  Future<void> registerByEmail({
    required String countryCode, //国家码，例如 86
    required String email, //邮箱地址
    required String password, //密码
    required String code, //经过验证码发送接口，收到的验证码
    void Function()? success, //接口发送成功回调
    void Function(String error)? failure, //接口发送失败回调，error 表示失败原因
  }) async {
    throw UnimplementedError('registerByEmail() has not been implemented.');
  }

  //使用邮箱地址和密码登录账号
  Future<void> loginByEmail({
    required String countryCode, //国家码，例如 86
    required String email, //邮箱地址
    required String password, //密码
    void Function(Map<String, dynamic> userInfo)? success, //接口发送成功回调
    void Function(String error)? failure, //接口发送失败回调，error 表示失败原因
  }) async {
    throw UnimplementedError('loginByEmail() has not been implemented.');
  }
}
