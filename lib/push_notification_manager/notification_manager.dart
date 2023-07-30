import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_notification/main.dart';
import 'package:flutter_notification/pages/home_screen.dart';

class PushNotificationManager {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageReceived);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);

    // Handle initial notification when the app is launched from a terminated state
    RemoteMessage? initialMessage =
        await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      print('Opened app from terminated state: ${initialMessage.data}');
      _navigateToScreenBasedOnPayload(initialMessage.data);
    }
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // Handle background notifications here (optional)
    print("Opened app from onBackgroundMessage: ${message.data}");
  }

  static Future<void> _onMessageReceived(RemoteMessage message) async {
    // for handling navigation after tapping and set custom notification logo.

    var androidInitialize =
        const AndroidInitializationSettings("@mipmap/ic_launcher");
    var iosInitialize = const DarwinInitializationSettings();
    var initializationSettings =
        InitializationSettings(android: androidInitialize, iOS: iosInitialize);

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) async {
        try {
          if (payload.payload != null && payload.payload!.isNotEmpty) {
            if (payload.payload == "home") {
              navigatorKey.currentState
                  ?.push(MaterialPageRoute(builder: (_) => const HomeScreen()));
            }
          } else {}
        } catch (e) {}
        return;
      },
    );

    // Handle foreground notifications here
    print('Received notification while app is in foreground: ${message.data}');

    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      message.notification!.body.toString(),
      htmlFormatBigText: true,
      contentTitle: message.notification!.title.toString(),
      htmlFormatContentTitle: true,
    );

    AndroidNotificationDetails androidPlatformChannelSpecific =
        AndroidNotificationDetails(
      "dbfood",
      "dbfood",
      importance: Importance.high,
      styleInformation: bigTextStyleInformation,
      priority: Priority.high,
      playSound: true,
    );

    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecific,
      iOS: const DarwinNotificationDetails(),
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      platformChannelSpecifics,
      payload: message.data['screen'],
    );
  }

  static void _onMessageOpenedApp(RemoteMessage message) {
    // Handle notification when user taps on it to open the app (app is in the background or closed)
    print('Opened app from notification: ${message.data}');

    _navigateToScreenBasedOnPayload(message.data);
  }

  static void _navigateToScreenBasedOnPayload(Map<String, dynamic> payload) {
    // Here, you can extract the necessary information from the payload and navigate to the appropriate screen.
    // For example, if your payload contains a 'type' field, you can use it to decide which screen to navigate to.

    // You can use Navigator to navigate to the relevant screen, for example:
    // Navigator.push(context, MaterialPageRoute(builder: (context) => YourScreen()));

    String type = payload['screen'] ??
        ''; // Assuming 'type' is the field in your payload that determines the screen

    // Navigate to the relevant screen based on the 'type' field
    switch (type) {
      case 'home':
        navigatorKey.currentState
            ?.push(MaterialPageRoute(builder: (_) => const HomeScreen()));
        break;
    }
  }
}
