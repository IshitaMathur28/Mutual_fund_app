import 'package:flutter/material.dart';
import '../controller/favourites.dart';
import '../controller/scheme_controller.dart';
import '../widgets/fund_tile.dart';
import 'favourites_screen.dart';
import 'package:get/get.dart';


class HomeScreen extends StatelessWidget {
const HomeScreen({super.key});


@override
Widget build(BuildContext context) {
  //calling controllers
final ctrl = Get.find<SchemeController>();
final favCtrl = Get.find<FavoritesController>();
final searchCtrl = TextEditingController();


return Scaffold(
appBar: AppBar(
title: const Text('Mutual Funds'),
),
//drawer 
drawer: Drawer(
  child:ListView(
    padding:EdgeInsets.zero,
    children: [
      const DrawerHeader(
        decoration: BoxDecoration(color:Colors.blueGrey),
        child:Text(
          'Menu',
          style: TextStyle(color:Colors.white,fontSize: 24),
          
        ),
        ),
        ListTile(
          leading:const Icon(Icons.home),
          title: const Text('Home'),
          onTap:(){
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading : const Icon(Icons.favorite),
          title: const Text('Favourites'),
          onTap: (){
            Navigator.pop(context);
            //switching to fav screen
            Get.to(()=> const FavoritesScreen());
          },
        ),
    ],
  ),
),
//for searchbox
body: Column(
children: [
Padding(
padding: const EdgeInsets.all(8.0),
child: TextField(
controller: searchCtrl,
onChanged: ctrl.search,//search method in scheme 
decoration: const InputDecoration(
prefixIcon: Icon(Icons.search),
hintText: 'Search by name or scheme code',
border: OutlineInputBorder(),
),
),
),
Expanded(
child: Obx(() {
if (ctrl.loading.value) return const Center(child: CircularProgressIndicator());
if (ctrl.error.value != null) return Center(child: Text('Error: ${ctrl.error.value}'));
final list = ctrl.filtered;
if (list.isEmpty) return const Center(child: Text('No schemes found'));
return ListView.separated(//scrolling list 
itemCount: list.length,
separatorBuilder: (_, __) => const Divider(height: 1),
itemBuilder: (context, idx) {
final s = list[idx];
return FundTile(scheme: s);
},
);
}),
),
],
),
);
}
}
