import 'package:firebase_remote_config/firebase_remote_config.dart';

class FirebaseRemoteConfigClass {
  final remoteConfig = FirebaseRemoteConfig.instance;

  Future initRemoteConfig() async {
    print("remote config is");
    print(remoteConfig);
    // try {
    // Fetch and activate values
    try {
      await remoteConfig.fetchAndActivate();
    } catch (exception) {
      print('Error fetching remote config: $exception');
    }

    var temp = remoteConfig.getInt("appbar_color");
    return temp;
  }
}
