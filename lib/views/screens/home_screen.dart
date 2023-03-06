// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:weather_application/services/api_services.dart';
import 'package:weather_application/utils/utils.dart';
import 'package:weather_application/views/components/today_wather.dart';

import '../../models/weather_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 97, 95, 95).withOpacity(.70),
      body: SafeArea(
        child: FutureBuilder(
            future: ApiServices().getWeatherData(location: "Dhaka"),
            builder: (context,AsyncSnapshot snapshot) {
              var weatherData = snapshot.data;
              if (snapshot.hasData) {
                return Column(
                  children: [
                    TodayWeather(weatherData: weatherData),
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("Error has occure"),
                );
              } else {
                return indicator();
              }
            }),
      ),
    );
  }
}
