import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'thing_flutter_login_plugin_platform_interface.dart';

/// An implementation of [ThingFlutterLoginPluginPlatform] that uses method channels.
class MethodChannelThingFlutterLoginPlugin
    extends ThingFlutterLoginPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('thing_flutter_login_plugin');

  MethodChannelThingFlutterLoginPlugin() {
    methodChannel.setMethodCallHandler((MethodCall call) async {
      if (kDebugMode) {
        print('接收到原生的函数调用:${call.method}');
      }

      // 其他业务代码处理
      return await Future.delayed(const Duration(seconds: 1), () {
        return {'result': 0, 'msg': 'notImplemented'};
      });
    });
  }

  @override
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
    final resultMap = await methodChannel.invokeMethod('sendVerifyCode', {
      'userName': userName,
      'region': region,
      'countryCode': countryCode,
      'type': type
    });

    final succ = resultMap['success'];

    if (succ) {
      if (success != null) {
        success();
      }
    } else {
      if (failure != null) {
        final errorMsg = resultMap['errorMsg'];
        failure(errorMsg);
      }
    }
  }

  @override
  Future<void> registerByEmail({
    required String countryCode, //国家码，例如 86
    required String email, //邮箱地址
    required String password, //密码
    required String code, //经过验证码发送接口，收到的验证码
    void Function()? success, //接口发送成功回调
    void Function(String error)? failure, //接口发送失败回调，error 表示失败原因
  }) async {
    final resultMap = await methodChannel.invokeMethod('registerByEmail', {
      'email': email,
      'password': password,
      'countryCode': countryCode,
      'code': code
    });

    final succ = resultMap['success'];

    if (succ) {
      if (success != null) {
        success();
      }
    } else {
      if (failure != null) {
        final errorMsg = resultMap['errorMsg'];
        failure(errorMsg);
      }
    }
  }

  @override
  Future<void> loginByEmail({
    required String countryCode, //国家码，例如 86
    required String email, //邮箱地址
    required String password, //密码
    void Function(Map<String, dynamic> userInfo)? success, //接口发送成功回调
    void Function(String error)? failure, //接口发送失败回调，error 表示失败原因
  }) async {
    final resultMap = await methodChannel.invokeMethod('loginByEmail',
        {'email': email, 'password': password, 'countryCode': countryCode});

    final succ = resultMap['success'];

    if (succ) {
      Map<String, dynamic> result = {};

      resultMap['result'].forEach((key, value) {
        if (key is String) {
          result[key] = value;
        }
      });

      if (success != null) {
        success(result);
      }
    } else {
      if (failure != null) {
        final errorMsg = resultMap['errorMsg'];
        failure(errorMsg);
      }
    }
  }
}
