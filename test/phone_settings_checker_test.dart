import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phone_settings_checker/phone_settings_checker.dart';
import 'package:phone_settings_checker/phone_settings_checker_platform_interface.dart';
import 'package:phone_settings_checker/phone_settings_checker_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPhoneSettingsCheckerPlatform
    with MockPlatformInterfaceMixin
    implements PhoneSettingsCheckerPlatform {

  @override
  Future<bool> isAutoTimeEnabled() => Future.value(true);

  @override
  Future<bool> isAutoTimeZoneEnabled() => Future.value(true);

  @override
  Future<bool> isDeveloperOptionsEnabled() => Future.value(true);

  @override
  Future<bool> isUsbDebuggingEnabled() => Future.value(true);

  @override
  Future<bool> isAirplaneModeEnabled() => Future.value(true);

  @override
  Future<PhoneSettings> getAll() => Future.value(const PhoneSettings(
        isAutoTimeEnabled: true,
        isAutoTimeZoneEnabled: true,
        isDeveloperOptionsEnabled: true,
        isUsbDebuggingEnabled: true,
        isAirplaneModeEnabled: true,
      ));
}

void main() {
  final PhoneSettingsCheckerPlatform initialPlatform = PhoneSettingsCheckerPlatform.instance;

  test('$MethodChannelPhoneSettingsChecker is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelPhoneSettingsChecker>());
  });

  test('isAutoTimeEnabled returns the platform answer', () async {
    PhoneSettingsChecker phoneSettingsCheckerPlugin = PhoneSettingsChecker();
    MockPhoneSettingsCheckerPlatform fakePlatform = MockPhoneSettingsCheckerPlatform();
    PhoneSettingsCheckerPlatform.instance = fakePlatform;

    expect(await phoneSettingsCheckerPlugin.isAutoTimeEnabled(), isTrue);
  });

  test('isAutoTimeZoneEnabled returns the platform answer', () async {
    PhoneSettingsChecker phoneSettingsCheckerPlugin = PhoneSettingsChecker();
    MockPhoneSettingsCheckerPlatform fakePlatform = MockPhoneSettingsCheckerPlatform();
    PhoneSettingsCheckerPlatform.instance = fakePlatform;

    expect(await phoneSettingsCheckerPlugin.isAutoTimeZoneEnabled(), isTrue);
  });

  test('isDeveloperOptionsEnabled returns the platform answer', () async {
    PhoneSettingsChecker phoneSettingsCheckerPlugin = PhoneSettingsChecker();
    MockPhoneSettingsCheckerPlatform fakePlatform = MockPhoneSettingsCheckerPlatform();
    PhoneSettingsCheckerPlatform.instance = fakePlatform;

    expect(await phoneSettingsCheckerPlugin.isDeveloperOptionsEnabled(), isTrue);
  });

  test('isUsbDebuggingEnabled returns the platform answer', () async {
    PhoneSettingsChecker phoneSettingsCheckerPlugin = PhoneSettingsChecker();
    MockPhoneSettingsCheckerPlatform fakePlatform = MockPhoneSettingsCheckerPlatform();
    PhoneSettingsCheckerPlatform.instance = fakePlatform;

    expect(await phoneSettingsCheckerPlugin.isUsbDebuggingEnabled(), isTrue);
  });

  test('isAirplaneModeEnabled returns the platform answer', () async {
    PhoneSettingsChecker phoneSettingsCheckerPlugin = PhoneSettingsChecker();
    MockPhoneSettingsCheckerPlatform fakePlatform = MockPhoneSettingsCheckerPlatform();
    PhoneSettingsCheckerPlatform.instance = fakePlatform;

    expect(await phoneSettingsCheckerPlugin.isAirplaneModeEnabled(), isTrue);
  });

  test('getAll returns the platform answer', () async {
    PhoneSettingsChecker phoneSettingsCheckerPlugin = PhoneSettingsChecker();
    MockPhoneSettingsCheckerPlatform fakePlatform = MockPhoneSettingsCheckerPlatform();
    PhoneSettingsCheckerPlatform.instance = fakePlatform;

    final settings = await phoneSettingsCheckerPlugin.getAll();
    expect(settings.isAutoTimeEnabled, isTrue);
    expect(settings.isAirplaneModeEnabled, isTrue);
  });

  test('isSupported is true on Android', () {
    expect(PhoneSettingsChecker().isSupported, isTrue);
  });

  test('isSupported is false on iOS', () {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    addTearDown(() => debugDefaultTargetPlatformOverride = null);
    expect(PhoneSettingsChecker().isSupported, isFalse);
  });
}
