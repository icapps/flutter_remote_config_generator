import 'dart:convert';
import 'dart:io';

import 'package:googleapis_auth/auth_io.dart';
import "package:http/http.dart" as http;

class Authenticator {
  Authenticator._();

  static Future<AccessCredentials> obtainCredentials(
    String credentialsPath,
  ) async {
    var file = File(credentialsPath);
    if (!file.existsSync()) {
      throw Exception('Credentials file not found at $credentialsPath');
    }

    ServiceAccountCredentials? serviceAccount;
    var jsonContent = await file.readAsString();
    try {
      serviceAccount = ServiceAccountCredentials.fromJson(
        jsonDecode(jsonContent),
      );
    } catch (error) {
      throw Exception('Could not parse the credentials file');
    }

    var scopes = ['https://www.googleapis.com/auth/firebase.remoteconfig'];

    var client = http.Client();
    AccessCredentials credentials =
        await obtainAccessCredentialsViaServiceAccount(
          serviceAccount,
          scopes,
          client,
        );

    client.close();
    return credentials;
  }
}
