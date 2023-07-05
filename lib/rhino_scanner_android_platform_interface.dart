import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'rhino_scanner_android_method_channel.dart';

abstract class RhinoScannerAndroidPlatform extends PlatformInterface {
  /// Constructs a RhinoScannerAndroidPlatform.
  RhinoScannerAndroidPlatform() : super(token: _token);

  static final Object _token = Object();

  static RhinoScannerAndroidPlatform _instance = MethodChannelRhinoScannerAndroid();

  /// The default instance of [RhinoScannerAndroidPlatform] to use.
  ///
  /// Defaults to [MethodChannelRhinoScannerAndroid].
  static RhinoScannerAndroidPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [RhinoScannerAndroidPlatform] when
  /// they register themselves.
  static set instance(RhinoScannerAndroidPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
