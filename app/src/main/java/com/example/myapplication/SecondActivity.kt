package com.example.myapplication

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.appcompat.widget.AppCompatButton
import androidx.appcompat.widget.AppCompatTextView

/**
 *@Author: soso
 *@Date: 2023/5/29
 *@Description:
 */
class SecondActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_second)
        findViewById<AppCompatTextView>(R.id.tvText).text = intent.getStringExtra("data")
        findViewById<AppCompatButton>(R.id.btnClose).setOnClickListener {
            finish()
        }
    }
}