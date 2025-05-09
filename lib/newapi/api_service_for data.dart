import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService1 {
  final String baseUrl =
      "https://mohamedtahoon.runasp.net/api"; // Replace with your API URL

Future<List<dynamic>> fetchProperties() async {
  final response = await http.get(Uri.parse('$baseUrl/Properties'));
  if (response.statusCode == 200) {
    var result = json.decode(response.body);
    if (result is List) {
      return result; // إذا كانت الاستجابة قائمة مباشرة
    } else if (result is Map && result.containsKey('data')) {
      return result['data']; // إذا كانت الاستجابة كائنًا يحتوي على 'data'
    } else {
      throw Exception('Unexpected response format');
    }
  } else {
    throw Exception('Failed to load properties');
  }
}  // استخراج القائمة من المفتاح "data" (مثال)
}

