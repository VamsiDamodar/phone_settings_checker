package io.github.vamsidamodar.phone_settings_checker

import android.content.Context
import android.provider.Settings
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** PhoneSettingsCheckerPlugin */
class PhoneSettingsCheckerPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var context: Context

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    context = flutterPluginBinding.applicationContext
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "phone_settings_checker")
    channel.setMethodCallHandler(this)
  }

  /// The phone book: each check's method name → the `Settings.Global` key it reads.
  /// `getAll` sends back the same names, so Dart can find each answer.
  private val globalSettings = mapOf(
    "isAutoTimeEnabled" to Settings.Global.AUTO_TIME,
    "isAutoTimeZoneEnabled" to Settings.Global.AUTO_TIME_ZONE,
    "isDeveloperOptionsEnabled" to Settings.Global.DEVELOPMENT_SETTINGS_ENABLED,
    "isUsbDebuggingEnabled" to Settings.Global.ADB_ENABLED,
    "isAirplaneModeEnabled" to Settings.Global.AIRPLANE_MODE_ON,
  )

  override fun onMethodCall(call: MethodCall, result: Result) {
    val settingName = globalSettings[call.method]
    when {
      settingName != null -> result.success(isGlobalSettingOn(settingName))
      call.method == "getAll" -> result.success(globalSettings.mapValues { isGlobalSettingOn(it.value) })
      else -> result.notImplemented()
    }
  }

  /// Reads an on/off value from `Settings.Global`. `1` = ON, anything else = OFF.
  private fun isGlobalSettingOn(name: String): Boolean =
    Settings.Global.getInt(context.contentResolver, name, 0) == 1

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
