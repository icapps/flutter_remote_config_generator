import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:remote_config_generator/src/model/remote_config_response_data.dart';

class FirebaseRemoteConfigService {
  final String projectId;
  final String accessToken;

  FirebaseRemoteConfigService({required this.projectId, required this.accessToken});

  Future<RemoteConfigResponse?> fetchRemoteConfig() async {
    final String url = 'https://firebaseremoteconfig.googleapis.com/v1/projects/$projectId/remoteConfig';

    final response = await http.get(Uri.parse(url), headers: {'Authorization': 'Bearer $accessToken', 'Accept-Encoding': 'gzip'});

    if (response.statusCode == 200) {
      return RemoteConfigResponse.fromJson(jsonDecode(response.body));
    } else {
      print('Failed to fetch remote config. Status Code: ${response.statusCode}');
      print('Response: ${response.body}');
      return null;
    }
  }
}
