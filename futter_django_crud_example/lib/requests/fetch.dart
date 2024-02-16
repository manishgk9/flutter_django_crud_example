import 'dart:convert';

import 'package:futter_django_crud_example/requests/model.dart';
import 'package:http/http.dart' as http;

Future<List<Student>> fetchAndCreate() async {
  final response = await http.get(Uri.parse('http://10.0.2.2:8000/get'));
  if (response.statusCode == 200) {
    List<dynamic> jsonData = json.decode(response.body);
    return jsonData.map((data) => Student.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load data');
  }
}

udatedata(String id) async {
  var response = await http.get(Uri.parse('http://10.0.2.2:8000/get/$id'));
  // print(response.body);
  // print(jsonDecode(response.body)['name']);
  return jsonDecode(response.body);
}
