import 'package:flutter/material.dart';
import 'first_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        unselectedLabelStyle: const TextStyle(
          color: Colors.black,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_rounded,
              color: Colors.black,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_sharp,
              color: Colors.black,
            ),
            label: "Profile",
          ),
        ],
        backgroundColor: const Color(
          0xFFB8B0A0,
        ),
      ),
      body: FirstPage(),
    );
  }
}
