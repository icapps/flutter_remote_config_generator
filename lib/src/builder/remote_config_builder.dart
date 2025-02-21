import 'dart:io';

import 'package:remote_config_generator/src/builder/remote_config_base_builder.dart';
import 'package:remote_config_generator/src/builder/remote_config_data_builder.dart';
import 'package:remote_config_generator/src/builder/remote_config_keys_builder.dart';
import 'package:remote_config_generator/src/model/config.dart';
import 'package:remote_config_generator/src/model/remote_config_response_data.dart';

class RemoteConfigBuilder {
  RemoteConfigBuilder._();

  static final defaultRemoteConfigDataPath = ['lib', 'remote_config', 'remote_config_data.dart'].join(Platform.pathSeparator);

  static final defaultRemoteConfigBasePath = ['lib', 'remote_config', 'remote_config_base.dart'].join(Platform.pathSeparator);

  static final defaultRemoteConfigKeysPath = ['lib', 'remote_config', 'remote_config_keys.dart'].join(Platform.pathSeparator);

  static void build({required RemoteConfigResponse data, required PubSpecConfig pubspec}) {
    print('Building remote config data');
    _buildRemoteConfigBase(pubspec: pubspec);

    print('Building remote config base');
    _buildRemoteConfigData(parameters: data.parameters, pubspec: pubspec);

    print('Building remote config keys');
    _buildRemoteConfigKeys(data: data);
  }

  static void _buildRemoteConfigBase({required PubSpecConfig pubspec}) {
    final file = File(defaultRemoteConfigBasePath);
    if (!file.existsSync()) {
      file.create(recursive: true);
    }

    file.writeAsStringSync(RemoteConfigBaseBuilder.build(pubspec: pubspec));
  }

  static void _buildRemoteConfigData({required List<RemoteConfigParameter> parameters, required PubSpecConfig pubspec}) {
    final file = File(defaultRemoteConfigDataPath);
    if (!file.existsSync()) {
      file.create(recursive: true);
    }

    file.writeAsStringSync(RemoteConfigDataBuilder.build(parameters: parameters, pubspec: pubspec));
  }

  static void _buildRemoteConfigKeys({required RemoteConfigResponse data}) {
    final file = File(defaultRemoteConfigKeysPath);
    if (!file.existsSync()) {
      file.create(recursive: true);
    }

    file.writeAsStringSync(RemoteConfigKeysBuilder.build(parameters: data.parameters));
  }
}
