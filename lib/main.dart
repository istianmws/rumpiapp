import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rumpiapp/views/loginPage.dart';
import 'package:rumpiapp/views/registerPage.dart';

import 'views/homePage.dart';

Future<void> main() async {
  // await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final token = box.read('token');
    return SafeArea(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Rumpi App',
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: token != null ? const HomePage() : const LoginPage(),
        /*
        getPages: [
          GetPage(name: LoginPage.id, page: ()=> LoginPage()),
          GetPage(name: RegisterPage.id, page: ()=> RegisterPage())
        ],*/
      ),
    );
  }
}
