import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../model/scheme.dart';


class FavoritesController extends GetxController {
final storage = GetStorage();//local data
final favs = <Scheme>[].obs;
static const favKey = 'mf_favorites_v1'; //key for local storage 


@override
void onInit() {
super.onInit();
final stored = storage.read(favKey);
if (stored != null) {
final List arr = stored as List;//json to dart list if fav exists
favs.assignAll(arr.map((e) => Scheme.fromJson(Map<String, dynamic>.from(e))).toList());
}
}


void add(Scheme s) {
if (!favs.any((e) => e.schemeCode == s.schemeCode)) {
favs.add(s);
_save();
}
}


void remove(Scheme s) {
favs.removeWhere((e) => e.schemeCode == s.schemeCode);
_save();
}


bool contains(Scheme s) => favs.any((e) => e.schemeCode == s.schemeCode);


void _save() => storage.write(favKey, favs.map((e) => e.toJson()).toList());
}
