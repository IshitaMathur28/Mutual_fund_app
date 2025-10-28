import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/scheme.dart';
import 'package:flutter_application_1/screens/detail_screen.dart';
import 'package:get/get.dart';
import '../../controller/favourites.dart';

class FundTile extends StatelessWidget {
final Scheme scheme;
const FundTile({required this.scheme, super.key});


@override
Widget build(BuildContext context) {
final favCtrl = Get.find<FavoritesController>();
final isFav = favCtrl.contains(scheme);
return ListTile(
title: Text(scheme.schemeName),
subtitle: Text('Code: ${scheme.schemeCode}'),
trailing: IconButton(
icon: Icon(isFav ? Icons.favorite : Icons.favorite_border, color: isFav ? Colors.red : null),
onPressed: () => isFav ? favCtrl.remove(scheme) : favCtrl.add(scheme),
),
onTap: () => Get.to(() => DetailsScreen(scheme: scheme)),
);
}
}
 