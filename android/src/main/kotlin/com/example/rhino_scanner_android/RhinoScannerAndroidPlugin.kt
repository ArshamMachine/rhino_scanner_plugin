package com.example.rhino_scanner_android


import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import android.content.Context
import android.content.IntentFilter
import android.content.BroadcastReceiver
import android.content.Intent
import android.util.Log

class RhinoScannerAndroidPlugin: FlutterPlugin {
private lateinit var stream : EventChannel.EventSink
private lateinit var context : Context
private val receiver = object : BroadcastReceiver() {
override fun onReceive(context: Context, intent: Intent) {
val action = "com.android.serial.BARCODEPORT_RECEIVEDDATA_ACTION"
val data = "DATA"
if (action == intent.action) {
var data = intent.getStringExtra(data) // this is the scanned barcode
Log.d("scan", "scanQrCode = [$data]")
stream.success(data) // this sends the data to Dart
} else {
Log.d("scan", "intent action does not match")
}
}
}

override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
val channel = EventChannel(flutterPluginBinding.binaryMessenger, "com.example.rhino_scanner_android")
channel.setStreamHandler(object : EventChannel.StreamHandler {
override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
stream = events!!
// register the receiver when listening to the stream
val intentFilter = IntentFilter()
val action = "com.android.serial.BARCODEPORT_RECEIVEDDATA_ACTION"
intentFilter.addAction(action)
context.registerReceiver(receiver, intentFilter)
}

override fun onCancel(arguments: Any?) {
// unregister the receiver when canceling the stream
context.unregisterReceiver(receiver)
}
})
context = flutterPluginBinding.applicationContext
}

override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
// do nothing
}
}