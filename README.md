# phone_settings_checker

Check Android phone settings from Flutter: automatic date & time, automatic
time zone, developer options, USB debugging and airplane mode.

One package, one call, no permissions.

## Features

| Check | Method | Android setting it reads |
|---|---|---|
| Automatic date & time | `isAutoTimeEnabled()` | `Settings.Global.AUTO_TIME` |
| Automatic time zone | `isAutoTimeZoneEnabled()` | `Settings.Global.AUTO_TIME_ZONE` |
| Developer options | `isDeveloperOptionsEnabled()` | `Settings.Global.DEVELOPMENT_SETTINGS_ENABLED` |
| USB debugging | `isUsbDebuggingEnabled()` | `Settings.Global.ADB_ENABLED` |
| Airplane mode | `isAirplaneModeEnabled()` | `Settings.Global.AIRPLANE_MODE_ON` |
| All of the above | `getAll()` | All five, in one call |

- **No permissions.** Nothing to add to `AndroidManifest.xml`.
- **No setup.** The plugin registers itself, so there is no `MainActivity` code to write.
- **Android only.** Use `isSupported` in apps that also run elsewhere (see [Platform support](#platform-support)).

## Install

```sh
flutter pub add phone_settings_checker
```

## Usage

### Read every setting at once

```dart
import 'package:phone_settings_checker/phone_settings_checker.dart';

final settings = await PhoneSettingsChecker().getAll();

if (settings.isDeveloperOptionsEnabled) {
  // For example, warn the user or turn off a sensitive feature.
}

print(settings);
// PhoneSettings(isAutoTimeEnabled: true, isAutoTimeZoneEnabled: true, ...)
```

### Read one setting

```dart
final autoTime = await PhoneSettingsChecker().isAutoTimeEnabled();

if (!autoTime) {
  // The user can set the clock by hand, so don't trust it for time-sensitive work.
}
```

### Apps that also run on iOS, web or desktop

```dart
final checker = PhoneSettingsChecker();

if (checker.isSupported) {
  final settings = await checker.getAll();
}
```

On platforms other than Android every check throws an `UnsupportedError`. It
never returns `false` there, because "developer options are off" would be a
wrong answer on an iPhone.

### Check again when the app comes back

Each call reads the setting at that moment. Users can change settings while
your app is in the background, so check again when it returns:

```dart
late final _listener = AppLifecycleListener(onResume: _checkSettings);
```

## Testing your app

`PhoneSettingsChecker` is a normal class, so your tests can swap in a fake:

```dart
class FakePhoneSettingsChecker extends PhoneSettingsChecker {
  @override
  Future<PhoneSettings> getAll() async => const PhoneSettings(
        isAutoTimeEnabled: false,
        isAutoTimeZoneEnabled: true,
        isDeveloperOptionsEnabled: true,
        isUsbDebuggingEnabled: false,
        isAirplaneModeEnabled: false,
      );
}
```

Pass the fake to the code under test in place of the real checker.

## Good to know

- **USB debugging is not Wireless debugging.** `isUsbDebuggingEnabled()` reads
  only the USB debugging switch. Wireless debugging (Android 11+) is a
  separate switch and is not part of this check.
- **Turning developer options off** also turns USB debugging off on most phones.
- If a phone does not report a setting at all, that check returns `false`.

## Platform support

| Android | iOS | Web | macOS | Windows | Linux |
|:---:|:---:|:---:|:---:|:---:|:---:|
| ✅ API 21+ | ❌ | ❌ | ❌ | ❌ | ❌ |

Tested on Android 12, 15 and 17.

## Issues and ideas

Found a bug, or want another setting checked? Open an issue on
[GitHub](https://github.com/VamsiDamodar/phone_settings_checker/issues).

## License

MIT. See [LICENSE](LICENSE).
