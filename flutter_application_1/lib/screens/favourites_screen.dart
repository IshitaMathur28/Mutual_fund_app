import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/favourites.dart';
import '../widgets/fund_tile.dart';

class FavoritesScreen extends StatelessWidget {
const FavoritesScreen({super.key});
@override
Widget build(BuildContext context) {
final fav = Get.find<FavoritesController>();
return Scaffold(
appBar: AppBar(title: const Text('Favorites')),
body: Obx(() {
final list = fav.favs;
if (list.isEmpty) return const Center(child: Text('No favorites'));
return ListView.separated(
itemCount: list.length,
separatorBuilder: (_, __) => const Divider(height: 1),
itemBuilder: (context, idx) { //builds each row
final s = list[idx];
return FundTile(scheme: s);
},
);
}),
);
}
} 