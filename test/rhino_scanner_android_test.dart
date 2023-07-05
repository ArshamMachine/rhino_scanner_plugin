import 'package:flutter_test/flutter_test.dart';
import 'package:rhino_scanner_android/rhino_scanner_android.dart';
import 'package:rhino_scanner_android/rhino_scanner_android_platform_interface.dart';
import 'package:rhino_scanner_android/rhino_scanner_android_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockRhinoScannerAndroidPlatform
    with MockPlatformInterfaceMixin
    implements RhinoScannerAndroidPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final RhinoScannerAndroidPlatform initialPlatform = RhinoScannerAndroidPlatform.instance;

  test('$MethodChannelRhinoScannerAndroid is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelRhinoScannerAndroid>());
  });

  test('getPlatformVersion', () async {
    RhinoScannerAndroid rhinoScannerAndroidPlugin = RhinoScannerAndroid();
    MockRhinoScannerAndroidPlatform fakePlatform = MockRhinoScannerAndroidPlatform();
    RhinoScannerAndroidPlatform.instance = fakePlatform;

    expect(await rhinoScannerAndroidPlugin.getPlatformVersion(), '42');
  });
}
