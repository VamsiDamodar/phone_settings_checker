import 'package:flutter/foundation.dart';

/// `true` when the app runs on Android, the only platform this package supports.
bool get isSupportedPlatform =>
    !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

/// The error every check throws on a platform this package does not support.
UnsupportedError unsupportedPlatformError(String method) {
  final platform = kIsWeb ? 'web' : defaultTargetPlatform.name;
  return UnsupportedError(
    'phone_settings_checker only works on Android, but $method() was called on '
    '$platform. Check PhoneSettingsChecker().isSupported before calling it.',
  );
}
