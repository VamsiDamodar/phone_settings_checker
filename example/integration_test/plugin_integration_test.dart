// This is a basic Flutter integration test.
//
// Since integration tests run in a full Flutter application, they can interact
// with the host side of a plugin implementation, unlike Dart unit tests.
//
// For more information about Flutter integration tests, please see
// https://flutter.dev/to/integration-testing

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:phone_settings_checker/phone_settings_checker.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('every check answers on a real phone', (
    WidgetTester tester,
  ) async {
    final PhoneSettingsChecker plugin = PhoneSettingsChecker();
    // ON or OFF depends on the phone, so just check each call answers without crashing.
    expect(await plugin.isAutoTimeEnabled(), isA<bool>());
    expect(await plugin.isAutoTimeZoneEnabled(), isA<bool>());
    expect(await plugin.isDeveloperOptionsEnabled(), isA<bool>());
    expect(await plugin.isUsbDebuggingEnabled(), isA<bool>());
    expect(await plugin.isAirplaneModeEnabled(), isA<bool>());
  });

  testWidgets('getAll gives the same answers as the single checks', (
    WidgetTester tester,
  ) async {
    final PhoneSettingsChecker plugin = PhoneSettingsChecker();
    final PhoneSettings all = await plugin.getAll();
    expect(all.isAutoTimeEnabled, await plugin.isAutoTimeEnabled());
    expect(all.isAutoTimeZoneEnabled, await plugin.isAutoTimeZoneEnabled());
    expect(
      all.isDeveloperOptionsEnabled,
      await plugin.isDeveloperOptionsEnabled(),
    );
    expect(all.isUsbDebuggingEnabled, await plugin.isUsbDebuggingEnabled());
    expect(all.isAirplaneModeEnabled, await plugin.isAirplaneModeEnabled());
  });
}
