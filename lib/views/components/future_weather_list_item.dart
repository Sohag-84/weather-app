// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:weather_application/models/weather_model.dart';

class FutureWeatherDataListItem extends StatelessWidget {
  final Forecastday? forecastday;
  const FutureWeatherDataListItem({Key? key, required this.forecastday})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60.h,
      padding: EdgeInsets.symmetric(vertical: 8.h),
      margin: EdgeInsets.all(8.w),
      
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          Image.network(
            "https:${forecastday!.day!.condition!.icon}",
          ),
          Expanded(
            child: Text(
              DateFormat.MMMEd().format(
                DateTime.parse(forecastday!.date.toString()),
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            child: Text(
              forecastday!.day!.condition!.text.toString(),
              style: TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            child: Text(
              "^${forecastday!.day!.maxtempC}/${forecastday!.day!.mintempC}",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
