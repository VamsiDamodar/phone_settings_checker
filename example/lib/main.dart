import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:phone_settings_checker/phone_settings_checker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _phoneSettingsCheckerPlugin = PhoneSettingsChecker();

  /// The latest answers. `null` until the first check finishes.
  PhoneSettings? _settings;

  /// `true` when the last check failed.
  bool _failed = false;

  @override
  void initState() {
    super.initState();
    _checkSettings();
  }

  /// Asks the plugin for every setting in one call and shows the answers.
  Future<void> _checkSettings() async {
    try {
      final settings = await _phoneSettingsCheckerPlugin.getAll();
      if (!mounted) return;
      setState(() {
        _settings = settings;
        _failed = false;
      });
    } on PlatformException {
      if (!mounted) return;
      setState(() => _failed = true);
    }
  }

  /// Turns one answer into ON ✅ / OFF ❌ text for the screen.
  String _label(bool? isOn) {
    if (_failed) return 'Failed to check.';
    if (isOn == null) return 'Checking...';
    return isOn ? 'ON ✅' : 'OFF ❌';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Plugin example app')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Auto time: ${_label(_settings?.isAutoTimeEnabled)}'),
              const SizedBox(height: 16),
              Text(
                'Auto timezone: ${_label(_settings?.isAutoTimeZoneEnabled)}',
              ),
              const SizedBox(height: 16),
              Text(
                'Developer options: ${_label(_settings?.isDeveloperOptionsEnabled)}',
              ),
              const SizedBox(height: 16),
              Text(
                'USB debugging: ${_label(_settings?.isUsbDebuggingEnabled)}',
              ),
              const SizedBox(height: 16),
              Text(
                'Airplane mode: ${_label(_settings?.isAirplaneModeEnabled)}',
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _checkSettings,
                icon: const Icon(Icons.refresh),
                label: const Text('Refresh'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
