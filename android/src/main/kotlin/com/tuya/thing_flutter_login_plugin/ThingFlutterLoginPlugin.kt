package com.tuya.thing_flutter_login_plugin

import androidx.annotation.NonNull
import com.thingclips.smart.android.user.api.ILoginCallback
import com.thingclips.smart.android.user.api.IRegisterCallback
import com.thingclips.smart.android.user.bean.User
import com.thingclips.smart.home.sdk.ThingHomeSdk
import com.thingclips.smart.sdk.api.IResultCallback

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** ThingFlutterLoginPlugin */
private const val TAG = "ThingFlutterLoginPlugin"
class ThingFlutterLoginPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "thing_flutter_login_plugin")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "sendVerifyCode" -> sendVerifyCode(call.arguments as Map<String, Any>, result)
            "registerByEmail" -> registerByEmail(call.arguments as Map<String, Any>, result)
            "loginByEmail" -> loginByEmail(call.arguments as Map<String, Any>, result)
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun sendVerifyCode(arguments: Map<String, Any>, result: Result) {
        val userName = arguments["userName"] as String
        val region = arguments["region"] as? String
        val countryCode = arguments["countryCode"] as String
        val type = arguments["type"] as Int
        android.util.Log.d(TAG, "sendVerifyCode: $userName $region $countryCode $type")
        if (userName.isEmpty() || countryCode.isEmpty()) {
            result.error("Illegal parameter", null, null)
            return
        }

        val callback = object : IResultCallback {
            override fun onError(code: String, error: String) {
                result.error("error", error, null)
                android.util.Log.i(TAG, "IResultCallback: code $code error $error")
            }

            override fun onSuccess() {
                result.success(mapOf("success" to true))
                android.util.Log.d(TAG, "IRegisterCallback onSuccess: ")
            }
        }

        ThingHomeSdk.getUserInstance()
            .sendVerifyCodeWithUserName(userName, region, countryCode, type, callback)

    }

    private fun registerByEmail(arguments: Map<String, Any>, result: Result) {
        val email = arguments["email"] as String
        val password = arguments["password"] as String
        val countryCode = arguments["countryCode"] as String
        val code = arguments["code"] as String

        android.util.Log.d(TAG, "registerByEmail: $email $password $countryCode $code")
        if (email.isEmpty() || password.isEmpty() || countryCode.isEmpty()) {
            result.error("Illegal parameter", null, null)
            return
        }

        val callback = object : IRegisterCallback {
            override fun onSuccess(user: User?) {
                result.success(mapOf("success" to true))
                android.util.Log.d(TAG, "IRegisterCallback onSuccess: ")
            }

            override fun onError(code: String, error: String) {
                result.error("Error", error, null)
                android.util.Log.i(TAG, "IRegisterCallback: code $code error $error")
            }
        }
        ThingHomeSdk.getUserInstance()
            .registerAccountWithEmail(countryCode, email, password, code, callback);

    }

    private fun loginByEmail(arguments: Map<String, Any>, result: Result) {

        val email = arguments["email"] as String
        val password = arguments["password"] as String
        val countryCode = arguments["countryCode"] as String

        if (email.isEmpty() || password.isEmpty() || countryCode.isEmpty()) {
            result.error("Illegal parameter", null, null)
            return
        }
        val callback = object : ILoginCallback {
            override fun onSuccess(user: User?) {
                val userInfo = mapOf(
                    "sid" to (ThingHomeSdk.getUserInstance().user?.sid ?:""),
                    "uid" to (ThingHomeSdk.getUserInstance().user?.uid ?:""),
                    "headIconUrl" to (ThingHomeSdk.getUserInstance().user?.headPic ?:""),
                    "nickname" to (ThingHomeSdk.getUserInstance().user?.nickName ?: ""),
                    "userName" to (ThingHomeSdk.getUserInstance().user?.username ?: ""),
                    "phoneNumber" to (ThingHomeSdk.getUserInstance().user?.phoneCode ?: ""),
                    "email" to (ThingHomeSdk.getUserInstance().user?.email ?: ""),
                    "partnerIdentity" to (ThingHomeSdk.getUserInstance().user?.partnerIdentity ?: ""),
                    "tempUnit" to (ThingHomeSdk.getUserInstance().user?.tempUnit ?: 0),
                    "regFrom" to (ThingHomeSdk.getUserInstance().user?.regFrom ?: 0),
                    "snsNickname" to (ThingHomeSdk.getUserInstance().user?.snsNickname ?: ""),
                    "ecode" to (ThingHomeSdk.getUserInstance().user?.ecode ?: ""),
                    "userType" to (ThingHomeSdk.getUserInstance().user?.userType ?: 0),
                    "extras" to (ThingHomeSdk.getUserInstance().user?.extras ?: emptyMap<String, Any>()),
                    "userAlias" to (ThingHomeSdk.getUserInstance().user?.userAlias ?: "")
                )
                result.success(mapOf("success" to true, "result" to userInfo))
                android.util.Log.d(TAG, "ILoginCallback onSuccess: ")
            }

            override fun onError(code: String, error: String) {
                result.error("Error", error, null)
                android.util.Log.i(TAG, "ILoginCallback: code $code error $error")
            }
        }

        ThingHomeSdk.getUserInstance().loginWithEmail(countryCode, email, password, callback);
    }
}