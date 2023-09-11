import 'package:flutter/material.dart';
import 'package:push/router/router.dart';
import 'package:push/services/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationService.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> msgKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();

    PushNotificationService.msgStream.listen((event) {
      navKey.currentState?.pushNamed("message", arguments: event);

      final snackBar = SnackBar(content: Text(event));
      msgKey.currentState?.showSnackBar(snackBar);
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navKey,
      scaffoldMessengerKey: msgKey,
      title: 'Push Notifications',
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.getAppRoutes(),
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
