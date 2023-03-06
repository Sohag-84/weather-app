import 'dart:convert';

import 'package:weather_application/constant/constant.dart';
import 'package:weather_application/models/weather_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  Future<WeatherModel> getWeatherData({required location}) async {
    String url = "$baseUrl&q=$location&days=7";

    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body.toString());
        WeatherModel weatherModel = WeatherModel.fromJson(json);
        return weatherModel;
      } else {
        return throw "No data found";
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
