import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phone_settings_checker/phone_settings_checker.dart';
import 'package:phone_settings_checker/phone_settings_checker_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelPhoneSettingsChecker platform =
      MethodChannelPhoneSettingsChecker();
  const MethodChannel channel = MethodChannel('phone_settings_checker');

  /// What the fake Kotlin side sends back for `isAutoTimeEnabled`.
  bool? autoTimeAnswer;

  /// What the fake Kotlin side sends back for `isAutoTimeZoneEnabled`.
  bool? autoTimeZoneAnswer;

  /// What the fake Kotlin side sends back for `isDeveloperOptionsEnabled`.
  bool? developerOptionsAnswer;

  /// What the fake Kotlin side sends back for `isUsbDebuggingEnabled`.
  bool? usbDebuggingAnswer;

  /// What the fake Kotlin side sends back for `isAirplaneModeEnabled`.
  bool? airplaneModeAnswer;

  /// What the fake Kotlin side sends back for `getAll`.
  Map<String, bool>? getAllAnswer;

  /// Method names the fake Kotlin side received, in order.
  final List<String> receivedMethods = [];

  setUp(() {
    autoTimeAnswer = true;
    autoTimeZoneAnswer = true;
    developerOptionsAnswer = true;
    usbDebuggingAnswer = true;
    airplaneModeAnswer = true;
    getAllAnswer = {
      'isAutoTimeEnabled': true,
      'isAutoTimeZoneEnabled': true,
      'isDeveloperOptionsEnabled': true,
      'isUsbDebuggingEnabled': true,
      'isAirplaneModeEnabled': true,
    };
    receivedMethods.clear();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
          receivedMethods.add(methodCall.method);
          if (methodCall.method == 'isAutoTimeEnabled') {
            return autoTimeAnswer;
          }
          if (methodCall.method == 'isAutoTimeZoneEnabled') {
            return autoTimeZoneAnswer;
          }
          if (methodCall.method == 'isDeveloperOptionsEnabled') {
            return developerOptionsAnswer;
          }
          if (methodCall.method == 'isUsbDebuggingEnabled') {
            return usbDebuggingAnswer;
          }
          if (methodCall.method == 'isAirplaneModeEnabled') {
            return airplaneModeAnswer;
          }
          if (methodCall.method == 'getAll') {
            return getAllAnswer;
          }
          return null;
        });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('isAutoTimeEnabled returns true when Kotlin says ON', () async {
    autoTimeAnswer = true;
    expect(await platform.isAutoTimeEnabled(), isTrue);
  });

  test('isAutoTimeEnabled returns false when Kotlin says OFF', () async {
    autoTimeAnswer = false;
    expect(await platform.isAutoTimeEnabled(), isFalse);
  });

  test(
    'isAutoTimeEnabled falls back to false when Kotlin sends null',
    () async {
      autoTimeAnswer = null;
      expect(await platform.isAutoTimeEnabled(), isFalse);
    },
  );

  test('isAutoTimeEnabled calls Kotlin with the exact method name', () async {
    await platform.isAutoTimeEnabled();
    expect(receivedMethods, ['isAutoTimeEnabled']);
  });

  test('isAutoTimeZoneEnabled returns true when Kotlin says ON', () async {
    autoTimeZoneAnswer = true;
    expect(await platform.isAutoTimeZoneEnabled(), isTrue);
  });

  test('isAutoTimeZoneEnabled returns false when Kotlin says OFF', () async {
    autoTimeZoneAnswer = false;
    expect(await platform.isAutoTimeZoneEnabled(), isFalse);
  });

  test(
    'isAutoTimeZoneEnabled falls back to false when Kotlin sends null',
    () async {
      autoTimeZoneAnswer = null;
      expect(await platform.isAutoTimeZoneEnabled(), isFalse);
    },
  );

  test(
    'isAutoTimeZoneEnabled calls Kotlin with the exact method name',
    () async {
      await platform.isAutoTimeZoneEnabled();
      expect(receivedMethods, ['isAutoTimeZoneEnabled']);
    },
  );

  test('isDeveloperOptionsEnabled returns true when Kotlin says ON', () async {
    developerOptionsAnswer = true;
    expect(await platform.isDeveloperOptionsEnabled(), isTrue);
  });

  test(
    'isDeveloperOptionsEnabled returns false when Kotlin says OFF',
    () async {
      developerOptionsAnswer = false;
      expect(await platform.isDeveloperOptionsEnabled(), isFalse);
    },
  );

  test(
    'isDeveloperOptionsEnabled falls back to false when Kotlin sends null',
    () async {
      developerOptionsAnswer = null;
      expect(await platform.isDeveloperOptionsEnabled(), isFalse);
    },
  );

  test(
    'isDeveloperOptionsEnabled calls Kotlin with the exact method name',
    () async {
      await platform.isDeveloperOptionsEnabled();
      expect(receivedMethods, ['isDeveloperOptionsEnabled']);
    },
  );

  test('isUsbDebuggingEnabled returns true when Kotlin says ON', () async {
    usbDebuggingAnswer = true;
    expect(await platform.isUsbDebuggingEnabled(), isTrue);
  });

  test('isUsbDebuggingEnabled returns false when Kotlin says OFF', () async {
    usbDebuggingAnswer = false;
    expect(await platform.isUsbDebuggingEnabled(), isFalse);
  });

  test(
    'isUsbDebuggingEnabled falls back to false when Kotlin sends null',
    () async {
      usbDebuggingAnswer = null;
      expect(await platform.isUsbDebuggingEnabled(), isFalse);
    },
  );

  test(
    'isUsbDebuggingEnabled calls Kotlin with the exact method name',
    () async {
      await platform.isUsbDebuggingEnabled();
      expect(receivedMethods, ['isUsbDebuggingEnabled']);
    },
  );

  test('isAirplaneModeEnabled returns true when Kotlin says ON', () async {
    airplaneModeAnswer = true;
    expect(await platform.isAirplaneModeEnabled(), isTrue);
  });

  test('isAirplaneModeEnabled returns false when Kotlin says OFF', () async {
    airplaneModeAnswer = false;
    expect(await platform.isAirplaneModeEnabled(), isFalse);
  });

  test(
    'isAirplaneModeEnabled falls back to false when Kotlin sends null',
    () async {
      airplaneModeAnswer = null;
      expect(await platform.isAirplaneModeEnabled(), isFalse);
    },
  );

  test(
    'isAirplaneModeEnabled calls Kotlin with the exact method name',
    () async {
      await platform.isAirplaneModeEnabled();
      expect(receivedMethods, ['isAirplaneModeEnabled']);
    },
  );

  test('getAll turns the Kotlin map into PhoneSettings', () async {
    getAllAnswer = {
      'isAutoTimeEnabled': true,
      'isAutoTimeZoneEnabled': false,
      'isDeveloperOptionsEnabled': true,
      'isUsbDebuggingEnabled': false,
      'isAirplaneModeEnabled': true,
    };
    expect(
      await platform.getAll(),
      const PhoneSettings(
        isAutoTimeEnabled: true,
        isAutoTimeZoneEnabled: false,
        isDeveloperOptionsEnabled: true,
        isUsbDebuggingEnabled: false,
        isAirplaneModeEnabled: true,
      ),
    );
  });

  test('getAll counts a missing name as OFF', () async {
    getAllAnswer = {'isAutoTimeEnabled': true};
    expect(
      await platform.getAll(),
      const PhoneSettings(
        isAutoTimeEnabled: true,
        isAutoTimeZoneEnabled: false,
        isDeveloperOptionsEnabled: false,
        isUsbDebuggingEnabled: false,
        isAirplaneModeEnabled: false,
      ),
    );
  });

  test('getAll falls back to all OFF when Kotlin sends null', () async {
    getAllAnswer = null;
    expect(
      await platform.getAll(),
      const PhoneSettings(
        isAutoTimeEnabled: false,
        isAutoTimeZoneEnabled: false,
        isDeveloperOptionsEnabled: false,
        isUsbDebuggingEnabled: false,
        isAirplaneModeEnabled: false,
      ),
    );
  });

  test('getAll asks Kotlin only once', () async {
    await platform.getAll();
    expect(receivedMethods, ['getAll']);
  });

  group('on a platform other than Android', () {
    setUp(() => debugDefaultTargetPlatformOverride = TargetPlatform.iOS);
    tearDown(() => debugDefaultTargetPlatformOverride = null);

    test('every check throws UnsupportedError', () async {
      await expectLater(platform.isAutoTimeEnabled(), throwsUnsupportedError);
      await expectLater(
        platform.isAutoTimeZoneEnabled(),
        throwsUnsupportedError,
      );
      await expectLater(
        platform.isDeveloperOptionsEnabled(),
        throwsUnsupportedError,
      );
      await expectLater(
        platform.isUsbDebuggingEnabled(),
        throwsUnsupportedError,
      );
      await expectLater(
        platform.isAirplaneModeEnabled(),
        throwsUnsupportedError,
      );
      await expectLater(platform.getAll(), throwsUnsupportedError);
    });

    test('the error says Android only and how to fix it', () async {
      await expectLater(
        platform.getAll(),
        throwsA(
          isA<UnsupportedError>().having(
            (e) => e.message,
            'message',
            allOf(
              contains('only works on Android'),
              contains('getAll()'),
              contains('iOS'),
              contains('isSupported'),
            ),
          ),
        ),
      );
    });

    test('nothing reaches Kotlin', () async {
      await expectLater(platform.isAutoTimeEnabled(), throwsUnsupportedError);
      await expectLater(platform.getAll(), throwsUnsupportedError);
      expect(receivedMethods, isEmpty);
    });
  });
}
