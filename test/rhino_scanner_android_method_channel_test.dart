import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhino_scanner_android/rhino_scanner_android_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelRhinoScannerAndroid platform = MethodChannelRhinoScannerAndroid();
  const MethodChannel channel = MethodChannel('rhino_scanner_android');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
