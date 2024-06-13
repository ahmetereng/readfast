import 'package:flutter/material.dart';
import 'package:readfast/home.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readfast/started.dart';

void main() {
  WidgetsBinding binding = WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const ReadFastApp(),
  );
}

class ReadFastApp extends StatelessWidget {
  const ReadFastApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(
        375,
        812,
      ),
      minTextAdapt: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          "/start": (context) => 
           Read(),
        }, //TODO GoRouter or GetX navigation
        home: const HomePage(),
      ),
    );
  }
}
