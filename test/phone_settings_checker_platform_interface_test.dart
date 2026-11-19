import 'package:flutter_test/flutter_test.dart';
import 'package:phone_settings_checker/phone_settings_checker_platform_interface.dart';

/// A new platform that has not implemented any check yet.
class UnimplementedPlatform extends PhoneSettingsCheckerPlatform {}

void main() {
  final platform = UnimplementedPlatform();

  /// Every check on the menu card, by name.
  final checks = <String, Object? Function()>{
    'isAutoTimeEnabled': platform.isAutoTimeEnabled,
    'isAutoTimeZoneEnabled': platform.isAutoTimeZoneEnabled,
    'isDeveloperOptionsEnabled': platform.isDeveloperOptionsEnabled,
    'isUsbDebuggingEnabled': platform.isUsbDebuggingEnabled,
    'isAirplaneModeEnabled': platform.isAirplaneModeEnabled,
    'getAll': platform.getAll,
  };

  for (final check in checks.entries) {
    test(
      '${check.key} throws UnimplementedError until a platform implements it',
      () {
        expect(
          check.value,
          throwsA(
            isA<UnimplementedError>().having(
              (e) => e.message,
              'message',
              contains(check.key),
            ),
          ),
        );
      },
    );
  }
}
