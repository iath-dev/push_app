import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:push/firebase_options.dart';

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static final StreamController<String> _controller =
      StreamController.broadcast();
  static Stream<String> get msgStream => _controller.stream;

  @pragma('vm:entry-point')
  static Future _onBackgroundHandler(RemoteMessage message) async {
    _controller.add(message.data["uid"] ?? "No Data");
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    _controller.add(message.data["uid"] ?? "No Data");
  }

  static Future _onMessageOpenAppHandler(RemoteMessage message) async {
    _controller.add(message.data["uid"] ?? "No Data");
  }

  static Future initializeApp() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    token = await FirebaseMessaging.instance.getToken();
    print("Token: $token");

    FirebaseMessaging.onBackgroundMessage(_onBackgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenAppHandler);
  }

  static closeStream() {
    _controller.close();
  }
}
