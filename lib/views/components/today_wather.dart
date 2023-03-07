// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:intl/intl.dart';
import 'package:weather_application/models/weather_model.dart';

class TodayWeather extends StatelessWidget {
  final WeatherModel? weatherData;
  const TodayWeather({Key? key, required this.weatherData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WeatherBg(
          weatherType: WeatherType.lightRainy,
          width: MediaQuery.of(context).size.width,
          height: 250.h,
        ),
        Column(
          children: [
            Container(
              padding: EdgeInsets.all(5.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.r),
                color: Colors.white10,
              ),
              child: Column(
                children: [
                  Text(
                    weatherData!.location!.name ?? "",
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    DateFormat.yMMMMEEEEd().format(
                      DateTime.parse(
                        weatherData!.current!.lastUpdated.toString(),
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white10,
                          ),
                          child: Image.network(
                            "https:${weatherData!.current!.condition!.icon}",
                          ),
                        ),
                        Spacer(),
                        Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 8.h),
                                  child: Text(
                                    weatherData!.current!.tempC.toString(),
                                    style: TextStyle(
                                      color: Colors.pink,
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  "o",
                                  style: TextStyle(
                                    color: Colors.pink,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              weatherData!.current!.condition!.text ?? "",
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 14.h),
                  Container(
                    padding: EdgeInsets.all(8.w),
                    margin: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Feels like",
                                  style: TextStyle(
                                      fontSize: 15.sp, color: Colors.white),
                                ),
                                Text(
                                  weatherData!.current!.feelslikeC.toString(),
                                  style: TextStyle(
                                      fontSize: 15.sp, color: Colors.white),
                                ),
                              ],
                            ),
                            Spacer(),
                            Column(
                              children: [
                                Text(
                                  "Wind",
                                  style: TextStyle(
                                      fontSize: 15.sp, color: Colors.white),
                                ),
                                Text(
                                  "${weatherData!.current!.windKph} km/h",
                                  style: TextStyle(
                                      fontSize: 15.sp, color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                     
                        Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Humidiy",
                                  style: TextStyle(
                                      fontSize: 15.sp, color: Colors.white),
                                ),
                                Text(
                                  "${weatherData!.current!.humidity}%",
                                  style: TextStyle(
                                      fontSize: 15.sp, color: Colors.white),
                                ),
                              ],
                            ),
                            Spacer(),
                            Column(
                              children: [
                                Text(
                                  "Visibility",
                                  style: TextStyle(
                                      fontSize: 15.sp, color: Colors.white),
                                ),
                                Text(
                                  "${weatherData!.current!.visKm} km",
                                  style: TextStyle(
                                      fontSize: 15.sp, color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                     
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
