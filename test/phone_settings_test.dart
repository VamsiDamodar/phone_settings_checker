import 'package:flutter_test/flutter_test.dart';
import 'package:phone_settings_checker/phone_settings_checker.dart';

/// Builds a fresh snapshot with every setting ON, unless told otherwise.
PhoneSettings snapshot({bool airplaneMode = true}) => PhoneSettings(
      isAutoTimeEnabled: true,
      isAutoTimeZoneEnabled: true,
      isDeveloperOptionsEnabled: true,
      isUsbDebuggingEnabled: true,
      isAirplaneModeEnabled: airplaneMode,
    );

void main() {
  test('two snapshots with the same answers are equal', () {
    expect(snapshot(), snapshot());
    expect(snapshot().hashCode, snapshot().hashCode);
  });

  test('snapshots with a different answer are not equal', () {
    expect(snapshot(airplaneMode: false), isNot(snapshot()));
  });

  test('toString shows every answer', () {
    expect(
      snapshot().toString(),
      'PhoneSettings(isAutoTimeEnabled: true, isAutoTimeZoneEnabled: true, '
      'isDeveloperOptionsEnabled: true, isUsbDebuggingEnabled: true, '
      'isAirplaneModeEnabled: true)',
    );
  });
}
