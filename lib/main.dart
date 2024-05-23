import 'package:flutter/material.dart';
import 'package:readfast/home.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readfast/started.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        routes: {
          "/start": (context) => const Read(),
        },
        home: const HomePage(),
      ),
    );
  }
}
