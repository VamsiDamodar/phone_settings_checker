## 0.1.0

* First release.
* Checks for automatic date & time, automatic time zone, developer options,
  USB debugging and airplane mode.
* `getAll()` reads every setting in one call and returns a `PhoneSettings` snapshot.
* `isSupported` tells you whether the current platform is supported. On other
  platforms every check throws an `UnsupportedError`.
