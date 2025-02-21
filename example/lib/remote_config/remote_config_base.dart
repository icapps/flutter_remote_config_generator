import 'dart:convert';

import 'package:example/remote_config/remote_config_data.dart';
import 'package:flutter/foundation.dart';

abstract class RemoteConfigBase {
  @protected
  late RemoteConfigData _remoteConfigValues;

  RemoteConfigData get remoteConfigValues {
    try {
      final returnValues = _remoteConfigValues;
      return returnValues;
    } catch (e) {
      throw Exception('Remote config not initialized, call init() first');
    }
  }

  Future<void> refreshRemoteConfig();

  String? getOptionalString(String key) => getOptionalValue(key);

  int? getOptionalInt(String key) => int.tryParse(getOptionalValue(key) ?? '');

  bool? getOptionalBool(String key) =>
      bool.tryParse(getOptionalValue(key) ?? '');

  double? getOptionalDouble(String key) =>
      double.tryParse(getOptionalValue(key) ?? '');

  String? getOptionalValue(String key);

  Map<T, R> getCustomObjectMap<T, R>(
      String key, R Function(Map<String, dynamic> json) fromJson) {
    final value = getOptionalValue(key);
    if (value == null) return {};
    final map = jsonDecode(value) as Map<T, dynamic>;
    return map.map(
        (key, value) => MapEntry(key, fromJson(value as Map<String, dynamic>)));
  }

  List<T> getCustomObjectList<T>(
      String key, T Function(Map<String, dynamic> json) fromJson) {
    final value = getOptionalValue(key);
    if (value == null) return [];
    final mapList = jsonDecode(value) as List<dynamic>;
    return mapList.map<T>((e) => fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<void> init() async {
    await refreshRemoteConfig();
    _remoteConfigValues = RemoteConfigData.fromRemoteConfig(this);
  }
}
