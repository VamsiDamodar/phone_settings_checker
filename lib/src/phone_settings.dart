import 'package:flutter/foundation.dart';

/// All the phone settings this package can read, taken at one moment.
///
/// Get one with `PhoneSettingsChecker().getAll()`. Each value is `true` when
/// that setting is ON.
@immutable
class PhoneSettings {
  /// Creates a snapshot. Handy for faking answers in your own tests.
  const PhoneSettings({
    required this.isAutoTimeEnabled,
    required this.isAutoTimeZoneEnabled,
    required this.isDeveloperOptionsEnabled,
    required this.isUsbDebuggingEnabled,
    required this.isAirplaneModeEnabled,
  });

  /// "Automatic date & time" is ON.
  final bool isAutoTimeEnabled;

  /// "Set time zone automatically" is ON.
  final bool isAutoTimeZoneEnabled;

  /// Developer options are turned on.
  final bool isDeveloperOptionsEnabled;

  /// USB debugging is ON. Wireless debugging is a separate switch and is not included.
  final bool isUsbDebuggingEnabled;

  /// Airplane mode is ON.
  final bool isAirplaneModeEnabled;

  @override
  bool operator ==(Object other) =>
      other is PhoneSettings &&
      other.isAutoTimeEnabled == isAutoTimeEnabled &&
      other.isAutoTimeZoneEnabled == isAutoTimeZoneEnabled &&
      other.isDeveloperOptionsEnabled == isDeveloperOptionsEnabled &&
      other.isUsbDebuggingEnabled == isUsbDebuggingEnabled &&
      other.isAirplaneModeEnabled == isAirplaneModeEnabled;

  @override
  int get hashCode => Object.hash(
        isAutoTimeEnabled,
        isAutoTimeZoneEnabled,
        isDeveloperOptionsEnabled,
        isUsbDebuggingEnabled,
        isAirplaneModeEnabled,
      );

  @override
  String toString() => 'PhoneSettings('
      'isAutoTimeEnabled: $isAutoTimeEnabled, '
      'isAutoTimeZoneEnabled: $isAutoTimeZoneEnabled, '
      'isDeveloperOptionsEnabled: $isDeveloperOptionsEnabled, '
      'isUsbDebuggingEnabled: $isUsbDebuggingEnabled, '
      'isAirplaneModeEnabled: $isAirplaneModeEnabled)';
}
