import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_notification/main.dart';
import 'package:flutter_notification/pages/notification_screen.dart';

Future<void> handleBackgroundMessaging(RemoteMessage message)async{
  print("Title: ${message.notification?.title}");
  print("Body: ${message.notification?.body}");
  print("Payload: ${message.data}");
}



class FirebaseApi{
  final _firebaseMessaging  = FirebaseMessaging.instance;

void handleMessage(RemoteMessage? message){
  if(message == null) return;

  navigatorKey.currentState?.pushNamed(NotificationScreen.route,
  arguments: message
  );
  }


Future initPushNotifications() async{
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
  FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  FirebaseMessaging.onBackgroundMessage(handleBackgroundMessaging);

}


  Future<void> initNotifications() async{
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
   
    initPushNotifications();
  }

  //  Future<void> _saveTokenToDatabase(String token) async {
  //   DatabaseReference databaseReference =
  //       FirebaseDatabase.instance.ref();

  //   await databaseReference.child('UserTokens').child('User1').set({
  //     'token': token,
  //   });
  // }
}