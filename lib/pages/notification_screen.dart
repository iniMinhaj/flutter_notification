import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});
  static const route = "/notification-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications Screen"),
      ),
      body: const Center(
        child: Text("This is Notification page"),
      ),
    );
  }
}
