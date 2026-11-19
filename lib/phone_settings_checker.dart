import 'phone_settings_checker_platform_interface.dart';
import 'src/phone_settings.dart';
import 'src/platform_support.dart';

export 'src/phone_settings.dart';

/// Reads Android phone settings such as auto time, developer options,
/// USB debugging and airplane mode.
///
/// Android only. On other platforms every check throws an [UnsupportedError],
/// so check [isSupported] first in cross-platform apps.
///
/// ```dart
/// final checker = PhoneSettingsChecker();
/// if (checker.isSupported) {
///   final settings = await checker.getAll();
/// }
/// ```
class PhoneSettingsChecker {
  /// `true` on Android. `false` on iOS, web and desktop, where every check
  /// throws an [UnsupportedError].
  bool get isSupported => isSupportedPlatform;

  /// Returns `true` when the phone's "Automatic date & time" setting is ON.
  ///
  /// ```dart
  /// final autoTime = await PhoneSettingsChecker().isAutoTimeEnabled();
  /// ```
  Future<bool> isAutoTimeEnabled() {
    return PhoneSettingsCheckerPlatform.instance.isAutoTimeEnabled();
  }

  /// Returns `true` when the phone's "Set time zone automatically" setting is ON.
  ///
  /// ```dart
  /// final autoZone = await PhoneSettingsChecker().isAutoTimeZoneEnabled();
  /// ```
  Future<bool> isAutoTimeZoneEnabled() {
    return PhoneSettingsCheckerPlatform.instance.isAutoTimeZoneEnabled();
  }

  /// Returns `true` when the phone's "Developer options" are turned ON.
  ///
  /// ```dart
  /// final devOptions = await PhoneSettingsChecker().isDeveloperOptionsEnabled();
  /// ```
  Future<bool> isDeveloperOptionsEnabled() {
    return PhoneSettingsCheckerPlatform.instance.isDeveloperOptionsEnabled();
  }

  /// Returns `true` when the phone's "USB debugging" setting is ON.
  ///
  /// "Wireless debugging" is a separate switch and is not part of this check.
  ///
  /// ```dart
  /// final usbDebugging = await PhoneSettingsChecker().isUsbDebuggingEnabled();
  /// ```
  Future<bool> isUsbDebuggingEnabled() {
    return PhoneSettingsCheckerPlatform.instance.isUsbDebuggingEnabled();
  }

  /// Returns `true` when the phone's "Airplane mode" is ON.
  ///
  /// ```dart
  /// final airplane = await PhoneSettingsChecker().isAirplaneModeEnabled();
  /// ```
  Future<bool> isAirplaneModeEnabled() {
    return PhoneSettingsCheckerPlatform.instance.isAirplaneModeEnabled();
  }

  /// Reads every setting in one call and returns them together.
  ///
  /// ```dart
  /// final settings = await PhoneSettingsChecker().getAll();
  /// if (settings.isDeveloperOptionsEnabled) {
  ///   // ...
  /// }
  /// ```
  Future<PhoneSettings> getAll() {
    return PhoneSettingsCheckerPlatform.instance.getAll();
  }
}
