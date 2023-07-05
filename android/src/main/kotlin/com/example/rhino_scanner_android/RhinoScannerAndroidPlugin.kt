package com.example.rhino_scanner_android

import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler // import this
import io.flutter.plugin.common.MethodCall // import this
import io.flutter.plugin.common.MethodChannel.Result
import android.content.Context // import this
import android.content.IntentFilter
import android.content.BroadcastReceiver
import android.content.Intent
import android.util.Log


class RhinoScannerAndroidPlugin: FlutterPlugin, MethodCallHandler {
  private lateinit var channel : MethodChannel
  private lateinit var context : Context

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "com.example.rhino_scanner_android")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "scanBarcode") {
      scanBarcode(result)
    } else {
      result.notImplemented()
    }
  }

  private fun scanBarcode(result: Result) {
    val intentFilter = IntentFilter()
    val action = "com.android.serial.BARCODEPORT_RECEIVEDDATA_ACTION"
    val data = "DATA"
    intentFilter.addAction(action)
    context.registerReceiver(object : BroadcastReceiver() {
      override fun onReceive(context: Context, intent: Intent) {
        if (action == intent.action) {
          var data = intent.getStringExtra(data)
          Log.d("scan", "scanQrCode = [$data]")
// TODO: send the data back to Dart using result.success(data)
    result.success(data) // this sends the data back to Dart
        }
      }
    }, intentFilter)
  }
}