import 'package:flutter/material.dart';
import 'package:flutter_notification/services/firebase_api.dart';

class FCMScreen extends StatefulWidget {
  const FCMScreen({super.key});

  @override
  State<FCMScreen> createState() => _FCMScreenState();
}

class _FCMScreenState extends State<FCMScreen> {

String? mToken = "";
// //late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

// initAndShowNotification(){

//   var androidInitialize = const AndroidInitializationSettings("@mipmap/ic_launcher");
//   var iosInitialize = const DarwinInitializationSettings();
//   var initializationSettings = InitializationSettings(
//     android: androidInitialize, iOS: iosInitialize
//   );

//   flutterLocalNotificationsPlugin.initialize(initializationSettings, 
//   onDidReceiveNotificationResponse:  (payload) async {
//       try{
//         if(payload.input != null && payload.input!.isNotEmpty){

//         }else{

//         }
//       }catch(e){

//       }
//       return;
//     }, );
  
//   FirebaseMessaging.onMessage.listen((RemoteMessage message) async{

// print("...................OnMessage..................");
// print("onMessage: ${message.notification?.title}/${message.notification?.body}");

// // From this all about to show the notfication in foreground.
// BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
//   message.notification!.body.toString(),  htmlFormatBigText: true, 
//   contentTitle: message.notification!.title.toString(),
//   htmlFormatContentTitle: true, 
// );

// AndroidNotificationDetails androidPlatformChannelSpecific = 
// AndroidNotificationDetails("dbfood", "dbfood", importance: Importance.high,
// styleInformation: bigTextStyleInformation, priority: Priority.high, playSound: true,
// );

// NotificationDetails platformChannelSpecifics = NotificationDetails(
//   android: androidPlatformChannelSpecific,
//   iOS: const DarwinNotificationDetails(),
// );

// await flutterLocalNotificationsPlugin.show(0, message.notification?.title,
//  message.notification?.body, platformChannelSpecifics, payload: message.data['body'],);

//      });
  
// }





// Future<void> saveToken(String token)async{
// await FirebaseFirestore.instance.collection("UserTokens").doc("User1").set({
// 'token': token,
// });
// }


// Future<void> getDeviceToken() async{
//   await FirebaseMessaging.instance.getToken().then((token) {
// setState(() {
//   mToken = token;
//   print("Device Token is : $mToken");
// }
// );
// saveToken(token!);
//   }
//    );
// }


  // Future<void> requestPersmission() async{
  //   FirebaseMessaging messaging =  FirebaseMessaging.instance;
  //   NotificationSettings settings = await messaging.requestPermission(
  //     alert: true,
  //     announcement: false,
  //     badge: true,
  //     carPlay: false,
  //     criticalAlert: false,
  //     sound: true,
  //   );

  //   if(settings.authorizationStatus == AuthorizationStatus.authorized){
  //     print("User granted permission");

  //   }else if(settings.authorizationStatus == AuthorizationStatus.provisional){
  //     print("User granted provisional permission");
  //   }else{
  //     print("User declined or has not accepted permission");
  //     AppSettings.openAppSettings();
  //   }
  // }

FirebaseApi services = FirebaseApi();

  @override
  void initState() {
   // requestPersmission();
    //getDeviceToken();
   // initAndShowNotification();
   services.initNotifications();
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
  
}