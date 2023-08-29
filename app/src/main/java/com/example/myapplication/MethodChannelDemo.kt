package com.example.myapplication

import android.content.Context
import android.content.Intent
import android.util.Log
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import org.json.JSONObject

/**
 *@Author: soso
 *@Date: 2023/5/26
 *@Description:
 */
class MethodChannelDemo(val context: Context, messenger: BinaryMessenger) :
    MethodChannel.MethodCallHandler {

    private var channel: MethodChannel

    init {
        channel = MethodChannel(messenger, "com.flutter.guide.MethodChannel")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "sendData" -> {
                val name = call.argument("name") as String?
                val age = call.argument("age") as Int?

                val map = mapOf(
                    "name" to "hello,$name", "age" to "$age"
                )
                result.success(map)
            }
            "goSecondActivity" -> {
                Log.e("检查", "call.arguments=" + call.arguments)
                val data = call.argument<String>("data")
                if (call.arguments is Map<*, *>) {
                    for (i in (call.arguments as Map<*, *>).keys) {
                        Log.e("检查", "Map key=$i  value=${(call.arguments as Map<*, *>)[i]}")
                    }
                }
                if (call.arguments is JSONObject) {
                    for (i in (call.arguments as JSONObject).keys()) {
                        Log.e("检查", "JSONObject key=$i  value=${(call.arguments as JSONObject)[i]}")
                    }
                }

                context.startActivity(
                    Intent(context, SecondActivity::class.java).putExtra(
                        "data", data
                    )
                )
                result.success("Android ${android.os.Build.VERSION.RELEASE}")
            }

        }
    }
}