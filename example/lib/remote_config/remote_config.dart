import 'package:example/remote_config/remote_config_base.dart';
import 'package:example/remote_config/remote_config_data.dart';
import 'package:flutter/foundation.dart';

class RemoteConfig extends RemoteConfigBase {
  static final RemoteConfig instance = RemoteConfig._();

  static RemoteConfigData get values => instance.remoteConfigValues;

  Map<String, dynamic> _values = {};

  RemoteConfig._();

  @override
  @protected
  Future<void> refreshRemoteConfig() async {
    _values = {'minimum_build': '1', 'latest_build': '1'};
  }

  @override
  String? getOptionalValue(String key) {
    return _values[key];
  }
}
