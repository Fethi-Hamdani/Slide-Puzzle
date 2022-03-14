import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class DeviceID {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  Future<String> get_token() async {
    if (Platform.isAndroid) return await _fcm.getToken() ?? "1999";
    return "web";
  }
}
