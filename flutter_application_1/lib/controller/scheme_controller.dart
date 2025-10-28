import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../model/scheme.dart';
import '../services/service.dart';


class SchemeController extends GetxController {
final Service _service = Service();
final storage = GetStorage();


final schemes = <Scheme>[].obs;
final filtered = <Scheme>[].obs;
final loading = false.obs;
final error = RxnString();


static const storageKey = 'all_schemes_v1';

@override
void onInit() async {
	super.onInit();
	try {
		final stored = storage.read(storageKey);
		if (stored != null) {
			final List arr = stored as List;
			schemes.value = arr.map((e) => Scheme.fromJson(Map<String, dynamic>.from(e))).toList();
			filtered.assignAll(schemes);
			loading.value = false;
			// refresh in background
			refreshFromApi();
		} else {
			final fetched = await _service.fetchAllSchemes();
			schemes.assignAll(fetched);
			filtered.assignAll(fetched);
			await storage.write(storageKey, fetched.map((e) => e.toJson()).toList());
			loading.value = false;
		}
	} catch (e) {
		loading.value = false;
		error.value = e.toString();
	}
}


Future<void> refreshFromApi() async {
try {
final fetched = await _service.fetchAllSchemes();
if (fetched.length != schemes.length) {
schemes.assignAll(fetched);
filtered.assignAll(fetched);
await storage.write(storageKey, fetched.map((e) => e.toJson()).toList());
}
} catch (_) {}
}


void search(String q) {
final t = q.trim().toLowerCase();
if (t.isEmpty) {
filtered.assignAll(schemes);
return;
}
final byName = schemes.where((s) => s.schemeName.toLowerCase().contains(t));
final byCode = schemes.where((s) => s.schemeCode.toLowerCase().contains(t));
final merged = {...byName, ...byCode}.toList();
filtered.assignAll(merged);
}
}