import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'phone_settings_checker_method_channel.dart';
import 'src/phone_settings.dart';

abstract class PhoneSettingsCheckerPlatform extends PlatformInterface {
  /// Constructs a PhoneSettingsCheckerPlatform.
  PhoneSettingsCheckerPlatform() : super(token: _token);

  static final Object _token = Object();

  static PhoneSettingsCheckerPlatform _instance =
      MethodChannelPhoneSettingsChecker();

  /// The default instance of [PhoneSettingsCheckerPlatform] to use.
  ///
  /// Defaults to [MethodChannelPhoneSettingsChecker].
  static PhoneSettingsCheckerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PhoneSettingsCheckerPlatform] when
  /// they register themselves.
  static set instance(PhoneSettingsCheckerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Returns `true` when the phone's "Automatic date & time" setting is ON.
  ///
  /// On Android this reads `Settings.Global.AUTO_TIME`. No permission needed.
  Future<bool> isAutoTimeEnabled() {
    throw UnimplementedError('isAutoTimeEnabled() has not been implemented.');
  }

  /// Returns `true` when the phone's "Set time zone automatically" setting is ON.
  ///
  /// On Android this reads `Settings.Global.AUTO_TIME_ZONE`. No permission needed.
  Future<bool> isAutoTimeZoneEnabled() {
    throw UnimplementedError(
      'isAutoTimeZoneEnabled() has not been implemented.',
    );
  }

  /// Returns `true` when the phone's "Developer options" are turned ON.
  ///
  /// On Android this reads `Settings.Global.DEVELOPMENT_SETTINGS_ENABLED`. No permission needed.
  Future<bool> isDeveloperOptionsEnabled() {
    throw UnimplementedError(
      'isDeveloperOptionsEnabled() has not been implemented.',
    );
  }

  /// Returns `true` when the phone's "USB debugging" setting is ON.
  ///
  /// On Android this reads `Settings.Global.ADB_ENABLED`. "Wireless debugging"
  /// is a separate switch and is not part of this check. No permission needed.
  Future<bool> isUsbDebuggingEnabled() {
    throw UnimplementedError(
      'isUsbDebuggingEnabled() has not been implemented.',
    );
  }

  /// Returns `true` when the phone's "Airplane mode" is ON.
  ///
  /// On Android this reads `Settings.Global.AIRPLANE_MODE_ON`. No permission needed.
  Future<bool> isAirplaneModeEnabled() {
    throw UnimplementedError(
      'isAirplaneModeEnabled() has not been implemented.',
    );
  }

  /// Reads every setting in one call and returns them together.
  Future<PhoneSettings> getAll() {
    throw UnimplementedError('getAll() has not been implemented.');
  }
}
