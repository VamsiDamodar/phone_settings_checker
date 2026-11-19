import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'phone_settings_checker_platform_interface.dart';
import 'src/phone_settings.dart';
import 'src/platform_support.dart';

/// An implementation of [PhoneSettingsCheckerPlatform] that uses method channels.
class MethodChannelPhoneSettingsChecker extends PhoneSettingsCheckerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('phone_settings_checker');

  @override
  Future<bool> isAutoTimeEnabled() => _readBool('isAutoTimeEnabled');

  @override
  Future<bool> isAutoTimeZoneEnabled() => _readBool('isAutoTimeZoneEnabled');

  @override
  Future<bool> isDeveloperOptionsEnabled() =>
      _readBool('isDeveloperOptionsEnabled');

  @override
  Future<bool> isUsbDebuggingEnabled() => _readBool('isUsbDebuggingEnabled');

  @override
  Future<bool> isAirplaneModeEnabled() => _readBool('isAirplaneModeEnabled');

  @override
  Future<PhoneSettings> getAll() async {
    _ensureSupported('getAll');
    final map =
        await methodChannel.invokeMapMethod<String, bool>('getAll') ?? const {};
    // A missing name counts as OFF, the same as the single checks.
    return PhoneSettings(
      isAutoTimeEnabled: map['isAutoTimeEnabled'] ?? false,
      isAutoTimeZoneEnabled: map['isAutoTimeZoneEnabled'] ?? false,
      isDeveloperOptionsEnabled: map['isDeveloperOptionsEnabled'] ?? false,
      isUsbDebuggingEnabled: map['isUsbDebuggingEnabled'] ?? false,
      isAirplaneModeEnabled: map['isAirplaneModeEnabled'] ?? false,
    );
  }

  /// Asks Kotlin one on/off question. A missing answer counts as OFF.
  Future<bool> _readBool(String method) async {
    _ensureSupported(method);
    final enabled = await methodChannel.invokeMethod<bool>(method);
    return enabled ?? false;
  }

  /// Stops the call when there is no Android side to answer it.
  void _ensureSupported(String method) {
    if (!isSupportedPlatform) throw unsupportedPlatformError(method);
  }
}
