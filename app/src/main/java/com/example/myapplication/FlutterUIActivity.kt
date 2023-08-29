package com.example.myapplication

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

/**
 * @Author: soso
 * @Date: 2023/5/26
 * @Description:
 */
class FlutterUIActivity : FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannelDemo(this,flutterEngine.dartExecutor.binaryMessenger)
    }

    companion object {
        fun withCachedEngine(cachedEngineId: String): CachedEngineIntentBuilder {
            return CachedEngineIntentBuilder(
                FlutterUIActivity::class.java, cachedEngineId
            )
        }
    }
}