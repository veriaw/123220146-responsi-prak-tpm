import 'dart:convert';

import 'package:http/http.dart' as http;

class BaseNetwork {
  static const String baseUrl = 'https://resp-api-three.vercel.app';

  static Future<Map<String, dynamic>> getAllDataPhone() async {
    final response = await http.get(
      Uri.parse(baseUrl+"/phones"),
    );

    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      print(data);
      return data;
    }else{
      throw Exception('Failed to Load Data!');
    }
  }

  static Future<Map<String, dynamic>> getPhoneDetail(int id) async {
    final response = await http.get(
      Uri.parse(baseUrl+"/phones/$id"),
    );

    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      print(data);
      return data;
    }else{
      throw Exception('Failed to Load Data!');
    }
  }

  static Future<bool> addPhoneData(String name, String brand, int price, String spesification) async {
    final response = await http.post(
      Uri.parse(baseUrl+"/phones"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': '$name',
        'brand':'$brand',
        'price':price,
        'spesification':'$spesification'
      }),
    );

    if(response.statusCode == 200){
      return true;
    }else{
      throw Exception('Failed to Load Data!');
    }
  }

  static Future<bool> updatePhoneData(int id, String name, String brand, int price, String spesification) async {
    final response = await http.patch(
      Uri.parse(baseUrl+"/phones/$id"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': '$name',
        'brand':'$brand',
        'price':price,
        'spesification':'$spesification'
      }),
    );

    if(response.statusCode == 200){
      return true;
    }else{
      throw Exception('Failed to Load Data!');
    }
  }

  static Future<bool> deletePhoneData(int id) async {
    final response = await http.delete(
      Uri.parse(baseUrl+"/phones/$id"),
    );

    if(response.statusCode == 200){
      return true;
    }else{
      throw Exception('Failed to Load Data!');
    }
  }
}