import 'rhino_scanner_android_platform_interface.dart';
import 'dart:async';

import 'package:flutter/services.dart';

class RhinoScannerAndroid {
  Future<String?> getPlatformVersion() {
    return RhinoScannerAndroidPlatform.instance.getPlatformVersion();
  }

  static const MethodChannel _channel =
      const MethodChannel('com.example.rhino_scanner_android');

  static Future<String> scanBarcode() async {
    final String data = await _channel.invokeMethod('scanBarcode');
    return data;
  }
}
