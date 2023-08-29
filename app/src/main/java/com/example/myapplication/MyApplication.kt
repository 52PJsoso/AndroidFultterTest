package com.example.myapplication

import android.app.Application
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor


/**
 *@Author: soso
 *@Date: 2023/5/26
 *@Description:
 */
class MyApplication : Application() {
    companion object {
        lateinit var instance: MyApplication
    }

    lateinit var flutterEngine: FlutterEngine

    override fun onCreate() {
        super.onCreate()
        instance = this
        flutterEngine = FlutterEngine(this)
        flutterEngine.dartExecutor.executeDartEntrypoint(
            DartExecutor.DartEntrypoint.createDefault()
        )
        FlutterEngineCache.getInstance().put("my_engine_id", flutterEngine)
    }
}