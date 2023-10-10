import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:coworking/view/view.dart';

import 'package:get/get.dart';
import 'package:device_preview/device_preview.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initializeDateFormatting();
  runApp(DevicePreview(
      enabled: false,
      builder: (BuildContext context) => GetMaterialApp(
            useInheritedMediaQuery: true,
            builder: DevicePreview.appBuilder,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
            ),
            initialRoute: FirebaseAuth.instance.currentUser != null ? '/navigation' : '/login',
            getPages: [
              GetPage(name: '/login', page: () => LoginView()),
              GetPage(name: '/navigation', page: () => NavigationBarView()),
              GetPage(name: '/room', page: () => RoomView()),
              GetPage(name: '/history', page: () => HistoryView()),
              GetPage(name: '/account', page: () => AccountView()),
            ],
          )));
}
