import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});
static  const route ="/notification-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Push Notifications"),
      ),
      body: const Center(
        child:  Text("Push Notification page"),
      ),
    );
  }
}