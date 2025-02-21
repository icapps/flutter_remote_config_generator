import 'package:remote_config_generator/src/model/remote_config_response_data.dart';
import 'package:remote_config_generator/src/remote_config_service.dart';

class RemoteConfig {
  RemoteConfig._();

  static Future<RemoteConfigResponse?> getRemoteConfigValues(FirebaseRemoteConfigService service) => service.fetchRemoteConfig();
}
