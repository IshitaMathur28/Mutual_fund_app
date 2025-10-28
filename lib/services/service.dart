import 'package:dio/dio.dart';
import '../model/scheme.dart';
import '../model/nav_entry.dart';


class Service {
final Dio _dio = Dio(BaseOptions(baseUrl: 'https://api.mfapi.in'));


Future<List<Scheme>> fetchAllSchemes() async {
final resp = await _dio.get('/mf'); //stroing response 
if (resp.statusCode == 200) {
final List data = resp.data as List;//returns json array as dart list 
return data.map((e) => Scheme.fromJson(Map<String, dynamic>.from(e))).toList();
}
throw Exception('Failed to load schemes');
}

//fetching data fro specific scheme
Future<List<NavEntry>> fetchNavs(String schemeCode) async {
final resp = await _dio.get('/mf/$schemeCode');
if (resp.statusCode == 200) {
final Map s = resp.data as Map;
final List data = s['data'] as List;
final entries = data.map((e) => NavEntry.fromJson(Map<String, dynamic>.from(e))).toList();
entries.sort((a, b) => a.date.compareTo(b.date));
return entries;
}
throw Exception('Failed to load navs');
}
}