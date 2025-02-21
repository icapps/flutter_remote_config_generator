import 'dart:io';

import 'package:path/path.dart';
import 'package:remote_config_generator/src/model/config.dart';
import 'package:yaml/yaml.dart';

class ConfigReader {
  ConfigReader._();

  static final defaultConfigPath = 'remote_config_generator${Platform.pathSeparator}config.yaml';

  static PubSpecConfig? readPubspec() {
    final pubspecYaml = File(join(Directory.current.path, 'pubspec.yaml'));
    if (!pubspecYaml.existsSync()) {
      throw Exception('This program should be run from the root of a flutter/dart project');
    }

    final doc = loadYaml(pubspecYaml.readAsStringSync());
    if (doc == null) return null;
    if (doc is! YamlMap) {
      throw Exception('Could not parse the pubspec.yaml');
    }

    return PubSpecConfig(packageName: doc['name']);
  }

  static Config? readConfig() {
    final configFile = File(defaultConfigPath);
    if (!configFile.existsSync()) {
      throw Exception('Config file not found at $defaultConfigPath');
    }

    final doc = loadYaml(configFile.readAsStringSync());
    if (doc == null) return null;
    if (doc is! YamlMap) {
      throw Exception('Could not parse the config.yaml');
    }

    return Config(credentialsPath: doc['credentials_path'], projectId: doc['project_id']);
  }
}
