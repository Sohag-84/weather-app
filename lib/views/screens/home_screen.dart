// ignore_for_file: prefer_const_constructors, unused_element, unused_label

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_application/services/api_services.dart';
import 'package:weather_application/utils/utils.dart';
import 'package:weather_application/views/components/hourly_weather_list_item.dart';
import 'package:weather_application/views/components/today_wather.dart';

import '../../models/weather_model.dart';
import '../components/future_weather_list_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchController = TextEditingController();
  String queryText = "auto:ip";

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  _showTextInputDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Search Location'),
          content: TextField(
            controller: searchController,
            decoration: const InputDecoration(hintText: "search by city,zip"),
          ),
          actions: [
            ElevatedButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                if (searchController.text.isEmpty) {
                  return;
                }
                Navigator.pop(context, searchController.text);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 97, 95, 95).withOpacity(.70),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Weather App"),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () async {
              searchController.clear();
              String text = await _showTextInputDialog(context);
              setState(() {
                queryText = text;
              });
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                queryText = "auto:ip";
              });
            },
            icon: const Icon(Icons.my_location),
          ),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: ApiServices().getWeatherData(location: queryText),
          builder: (context, AsyncSnapshot snapshot) {
            WeatherModel? weatherData = snapshot.data;
            if (snapshot.hasData) {
              return Column(
                children: [
                  TodayWeather(weatherData: weatherData),
                  SizedBox(height: 10.h),
                  Text(
                    "Weather by Hours",
                    style: TextStyle(
                       fontSize: 16.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 8.h),
                  SizedBox(
                    height: 115.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: weatherData!
                              .forecast?.forecastday?[0].hour?.length ??
                          0,
                      itemBuilder: (context, index) {
                        Hour? hour = weatherData
                            .forecast!.forecastday![0].hour![index];
                        return HourlyWeatherListItem(hour: hour);
                      },
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    "Next 7 Days Weather",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: weatherData.forecast!.forecastday!.length,
                        itemBuilder: (context, index) {
                          Forecastday? forcastDay =
                              weatherData.forecast!.forecastday![index];
                          return FutureWeatherDataListItem(
                            forecastday: forcastDay,
                          );
                        }),
                  )
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("No data found"),
              );
            } else {
              return indicator();
            }
          },
        ),
      ),
    );
  }
}
