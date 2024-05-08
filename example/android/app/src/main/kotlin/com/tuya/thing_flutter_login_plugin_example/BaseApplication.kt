package com.tuya.thing_flutter_login_plugin_example

import android.app.Application
import com.thingclips.smart.home.sdk.ThingHomeSdk

class BaseApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        ThingHomeSdk.init(this)
    }
}