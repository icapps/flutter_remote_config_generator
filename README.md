A generator that helps you generate code for your remote config, currently only firebase is supported.

## Features

Generates the nescessary code for accessing your remote config

## Getting started

To get started you need 2 things, first is a firebase service account key of a service account that has access to the remote config. Second is a config.yaml file stored in the remote_config_generator folder in the root of your project.

The file should look something like this

```yaml
credentials_path: path to credentials (ex. remote_config_generator/credentials.json)
project_id: project id of your firebase project
```

After that just run the tool by running this command:
```bash
flutter packages run remote_config_generator
```

This will generate 3 files. remote_config_base.dart, remote_config_data.dart and remote_config_keys.dart. To then use these generated files create a class which extends the remoteConfigBase like this:

```dart
class RemoteConfig extends RemoteConfigBase {
  RemoteConfig._();

  @override
  @protected
  Future<void> refreshRemoteConfig() async {
    // Refresh remote config here
  }

  @override
  String? getOptionalValue(String key) {
    // Get the value out of your remote config (doesn't have to be from firebase)
  }
}
```

Now all you have to do is initialize the remote config and call the values:

```dart
final remoteConfig = RemoteConfig();
remoteConfig.init();
remoteConfig.values.{valueName}
```

It is advised to make the RemoteConfig a singleton so you always access the same values.
