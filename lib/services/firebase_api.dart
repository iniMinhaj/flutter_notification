import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> handleBackgroundMessaging(RemoteMessage message) async {
  print("Title: ${message.notification?.title}");
  print("Body: ${message.notification?.body}");
  print("Payload: ${message.data}");
}

 FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

// void handleMessage(RemoteMessage? message){
//   if(message == null) return;
//   navigatorKey.currentState?.pushNamed(NotificationScreen.route,
//   arguments: message
//   );
//   }

  showForgroundNotification() {
    var androidInitialize =
        const AndroidInitializationSettings("@mipmap/ic_launcher");
    var iosInitialize = const DarwinInitializationSettings();
    var initializationSettings =
        InitializationSettings(android: androidInitialize, iOS: iosInitialize);

   
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        print("...................OnMessage..................");
        print(
            "onMessage: ${message.notification?.title}/${message.notification?.body}");
            print("Payload: ${message.data.toString()} ");
            print("Payload Individual: ${message.data["type"]} ");
            print("Payload Individual: ${message.data["id"]} ");

    // From this all about to show the notfication in foreground - start.
        BigTextStyleInformation bigTextStyleInformation =
            BigTextStyleInformation(
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
          payload: message.data['body'],
        );
      },
    );
    // End....................
  

  
// Payload section for redirect screen
     flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) async {
        try {
          if (payload.input != null && payload.input!.isNotEmpty) {

            print("Payload section................");
            print(payload.notificationResponseType.name);
          } else {}
        } catch (e) {}
        return;
      },
    );

  
  
  }




  Future initBackgroundNotifications() async {
    // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    //   alert: true,
    //   badge: true,
    //   sound: true,
    // );

    // FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    // FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessaging);
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    _firebaseMessaging.getToken().then((token) {
      if (token != null) {
        //  _saveTokenToDatabase(token);
      }
      print("Token: $token");
    });

    // if token changed.
    _firebaseMessaging.onTokenRefresh.listen((token) {
      //  _saveTokenToDatabase(token);
      print("Refreshed Token = $token");
    });

    initBackgroundNotifications();
    showForgroundNotification();
  }

  //  Future<void> _saveTokenToDatabase(String token) async {
  //   DatabaseReference databaseReference =
  //       FirebaseDatabase.instance.ref();

  //   await databaseReference.child('UserTokens').child('User1').set({
  //     'token': token,
  //   });
  // }
}
