import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'rhino_scanner_android_platform_interface.dart';

/// An implementation of [RhinoScannerAndroidPlatform] that uses method channels.
class MethodChannelRhinoScannerAndroid extends RhinoScannerAndroidPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('rhino_scanner_android');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
