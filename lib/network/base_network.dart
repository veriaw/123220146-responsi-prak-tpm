import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:responsi_prak_mob/models/PhoneModel.dart';

class BaseNetwork {
  static const String baseUrl = 'https://resp-api-three.vercel.app';

  static Future<Map<String, dynamic>> getAllDataPhone() async {
    final response = await http.get(
      Uri.parse(baseUrl+"/phones"),
    );

    if(response.statusCode >= 200 && response.statusCode < 300){
      final data = jsonDecode(response.body);
      print(data);
      return data;
    }else{
      throw Exception('Failed to Load Data!');
    }
  }

  static Future<Map<String, dynamic>> getPhoneDetail(int id) async {
    print("id detail network: $id");
    final response = await http.get(
      Uri.parse(baseUrl+"/phone/$id"),
    );

    print('Status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if(response.statusCode >= 200 && response.statusCode < 300){
      final data = jsonDecode(response.body);
      return data;
    }else{
      throw Exception('Failed to Load Data!');
    }
  }

  static Future<bool> addPhoneData(PhoneModel phone) async {
    print("id add network: ${phone.id}");
    final response = await http.post(
      Uri.parse(baseUrl+"/phone"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': '${phone.name}',
        'brand':'${phone.brand}',
        'price':phone.price,
        'specification':'${phone.specification}'
      }),
    );
    final data = jsonDecode(response.body);
    print("Add Status: ${response.statusCode}");

    if(response.statusCode >= 200 && response.statusCode < 300){
      print("Berhasil Ditambahkan");
      return true;
    }else{
      throw Exception('Failed to Load Data!');
    }
  }

  static Future<bool> updatePhoneData(PhoneModel phone) async {
    print("id update network: ${phone.id}");
    final response = await http.put(
      Uri.parse(baseUrl+"/phone/${phone.id}"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': '${phone.name}',
        'brand':'${phone.brand}',
        'price':phone.price,
        'specification':'${phone.specification}'
      }),
    );
    print("Update Status: ${response.statusCode}");
    

    if(response.statusCode >= 200 && response.statusCode < 300){
      print("Berhasil DiEdit");
      return true;
    }else{
      throw Exception('Failed to Load Data!');
    }
  }

  static Future<bool> deletePhoneData(int id) async {
    final response = await http.delete(
      Uri.parse(baseUrl+"/phone/$id"),
    );

    if(response.statusCode >= 200 && response.statusCode < 300){
      return true;
    }else{
      throw Exception('Failed to Load Data!');
    }
  }
}