import 'package:remote_config_generator/src/authenticator.dart';
import 'package:remote_config_generator/src/builder/remote_config_builder.dart';
import 'package:remote_config_generator/src/config_reader.dart';
import 'package:remote_config_generator/src/remote_config.dart';
import 'package:remote_config_generator/src/remote_config_service.dart';

class RemoteConfigGenerator {
  static Future<void> generate() async {
    print('Reading config file');
    final pubSpecConfig = ConfigReader.readPubspec();
    final config = ConfigReader.readConfig();
    if (config == null || pubSpecConfig == null) return;

    print('Authenticating with credentials at ${config.credentialsPath}');
    final credentials = await Authenticator.obtainCredentials(config.credentialsPath);

    print('Retrieving remote config');
    final service = FirebaseRemoteConfigService(projectId: config.projectId, accessToken: credentials.accessToken.data);
    final values = await RemoteConfig.getRemoteConfigValues(service);

    if (values == null) {
      print('Not remote config values found');
      return;
    }

    print('Generating remote config');
    RemoteConfigBuilder.build(data: values, pubspec: pubSpecConfig);
  }
}
