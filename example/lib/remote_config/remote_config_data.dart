import 'package:example/remote_config/remote_config_base.dart';

class RemoteConfigData {
  RemoteConfigData({required this.reviewBuild, required this.sendBlockedErrorsToFirebase, required this.latestBuild, required this.minimumBuild});

  factory RemoteConfigData.fromRemoteConfig(RemoteConfigBase remoteConfigBase) {
    return RemoteConfigData(
      reviewBuild: remoteConfigBase.getOptionalDouble('review_build') ?? 1,
      sendBlockedErrorsToFirebase: remoteConfigBase.getOptionalBool('send_blocked_errors_to_firebase') ?? false,
      latestBuild: remoteConfigBase.getOptionalDouble('latest_build') ?? 2,
      minimumBuild: remoteConfigBase.getOptionalDouble('minimum_build') ?? 1,
    );
  }

  final double reviewBuild;

  final bool sendBlockedErrorsToFirebase;

  final double latestBuild;

  final double minimumBuild;
}
