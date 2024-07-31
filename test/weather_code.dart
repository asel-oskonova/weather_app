import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';

void main() async{
  test ('description', () async {
  final response = await Client().get(
  Uri.parse('https://www.weatherapi.com/docs/conditions.json'),
  headers: {},
  );

  final finalMap = <Map>[];

  if(response.statusCode ==200){
    const prefix = 'ï»¿';
    var body = response.body;
    if (body.startsWith(prefix)) {
      body = body.substring(prefix.length);
    }
    var jsonData = json.decode(body) as List;
    for (var data in jsonData) {
      if (data is Map && data.containsKey('languages')) {
        data.remove('languages');
      }
      finalMap.add(data);
    }
  }

  await File('weather_codes.json').writeAsString(jsonEncode(finalMap));

  expect(2, 1 + 1);
  });
}