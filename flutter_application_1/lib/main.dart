import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/scheme_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'screens/home_screen.dart';
import 'controller/favourites.dart';
import 'controller/nav_controller.dart';

void main() async {
WidgetsFlutterBinding.ensureInitialized();
await GetStorage.init();


// initialize controllers
Get.put(SchemeController());
Get.put(FavoritesController());
Get.put(NavController(),permanent: true);


runApp(const MyApp());
}


class MyApp extends StatelessWidget {
const MyApp({super.key});


@override
Widget build(BuildContext context) {
return GetMaterialApp(
title: 'Mutual Funds Explorer',
theme: ThemeData(primarySwatch: Colors.indigo),
home: const HomeScreen(),
);
}
}