package com.example.myapplication

import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import io.flutter.plugin.common.MethodChannel

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        findViewById<TextView>(R.id.btnFlutter).setOnClickListener {
            startActivity(FlutterUIActivity.withCachedEngine("my_engine_id").build(this@MainActivity))
           //发送数据给Flutter
            Handler(Looper.getMainLooper()).postDelayed({
                val flutterEngine = MyApplication.instance.flutterEngine
                flutterEngine?.let {
                    val channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "com.flutter.guide.MethodChannel")
                    channel.invokeMethod("sendDataX", mapOf("name" to "soso", "age" to 18), object : MethodChannel.Result {
                        override fun notImplemented() {
                            println("notImplemented")
                        }

                        override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
                            println("error")
                        }

                        override fun success(result: Any?) {
                            println("success")
                        }
                    })
                }
            },3000)
        }
    }
}