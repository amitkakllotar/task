import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task/ChatScreen.dart';
import 'package:task/FirstScreen.dart';

import 'package:task/SingUp_Screen.dart';

Future<void> main() async {
  Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: 'AIzaSyB75GwzGiHbBFJy-Wj3hQo5Zv1OCV48hKE',
            appId: ' 1:546354510597:android:b3b13d86694e163121d56c',
            messagingSenderId: '546354510597',
            projectId: 'task-7cde6'));

  }

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  ));
}
