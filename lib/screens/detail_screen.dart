import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../model/scheme.dart';
import '../controller/nav_controller.dart';
import '../controller/favourites.dart';
import '../widgets/nav_chart.dart';


class DetailsScreen extends StatefulWidget {
  final Scheme scheme;

  const DetailsScreen({required this.scheme, super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late final NavController navctrl;
  late final FavoritesController favctrl;
  @override
  void initState(){
    super.initState();

    navctrl=Get.put(NavController(),permanent: true);
    favctrl=Get.find<FavoritesController>();
    //ensures navs is loaded after widget is ready not during build
    Future.microtask(()=> navctrl.loadNavs(widget.scheme.schemeCode));
  }
  @override
  Widget build(BuildContext context){
  return Scaffold(
appBar: AppBar(
title: Text(widget.scheme.schemeName),
actions: [
Obx(() {
  //favourite
final isFav = favctrl.contains(widget.scheme);
return IconButton(
icon: Icon(isFav ? Icons.favorite : Icons.favorite_border),
onPressed: () => isFav ? favctrl.remove(widget.scheme) : favctrl.add(widget.scheme),
);
})
],
),
body: Obx(() {
if (navctrl.loading.value) return const Center(child: CircularProgressIndicator());
if (navctrl.error.value != null) return Center(child: Text('Error: ${navctrl.error.value}'));
final navs = navctrl.navs;
if (navs.isEmpty) return const Center(child: Text('No NAV data'));
final latest = navs.last.date;
final gains = navctrl.gainsFor(latest);
    return Padding(
padding: const EdgeInsets.all(12.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
        Text('Scheme Code: ${widget.scheme.schemeCode}'),
const SizedBox(height: 8),
Row(
  mainAxisAlignment: MainAxisAlignment.spaceAround,
  children: [
          _gainCard('1 Year', gains['1y'] ?? '—'),
          _gainCard('3 Years', gains['3y'] ?? '—'),
          _gainCard('5 Years', gains['5y'] ?? '—'),
        ],
  ),
const SizedBox(height: 12),
Expanded(child: NavChart(navs: navs)),

],
),
);
}),
);
}
Widget _gainCard(String title, String value) => Card(
  
child: SizedBox(
width: 110,
height: 70,
child: Padding(
padding: const EdgeInsets.all(8.0),
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Text(title, style: const TextStyle(fontSize: 12)),
const SizedBox(height: 6),
Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
],
),
),
),
);
}
 
