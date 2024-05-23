import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  static int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    List images = Story.storyNames
        .map(
          (e) => "assets/images/covers/$e.png",
        )
        .toList();

    return Column(
      children: [
        Stack(
          children: [
            Image.asset(getCoverImage(selectedIndex, images)),
            Positioned(
              top: 200.h,
              left: 5,
              child: IconButton.filled(
                  iconSize: 20,
                  onPressed: () {
                    setState(() {
                      if (selectedIndex != 0) {
                        selectedIndex--;
                        Story().selectStoryName(selectedIndex);
                      } else {
                        selectedIndex = 1;
                        Story().selectStoryName(selectedIndex);
                      }
                    });
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_rounded)),
            ),
            Positioned(
              top: 200.h,
              right: 5,
              child: IconButton.filled(
                  iconSize: 20,
                  onPressed: () {
                    setState(() {
                      if (selectedIndex == images.length - 1) {
                        selectedIndex = 0;
                        Story().selectStoryName(selectedIndex);
                      } else {
                        selectedIndex++;
                        Story().selectStoryName(selectedIndex);
                      }
                    });
                  },
                  icon: const Icon(Icons.arrow_forward_ios_rounded)),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 0, 5, 0),
                child: ElevatedButton(
                  onPressed: () {
                    loadTextFile(Story.selectedStoryName);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFDDDCDB),
                    textStyle: const TextStyle(fontSize: 24),
                    overlayColor: Colors.black,
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(30, 25))),
                    minimumSize: const Size(300, 60),
                  ),
                  child: const Text(
                    '    START!   ',
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                ),
              ),
              IconButton.filled(
                  onPressed: () {}, icon: const Icon(Icons.settings))
            ],
          ),
        ),
      ],
    );
  }

  Future<void> loadTextFile(String nameOfStory) async {
    final String response =
        await rootBundle.loadString('assets/data/$nameOfStory.txt');

    final fileContent = response
        .replaceAll(".", " ")
        .replaceAll(";", " ")
        .replaceAll("?", " ")
        .replaceAll("-", "- ")
        .replaceAll("\n", "")
        .split(" ")
        .where((a) => a != "")
        .toList();
    Navigator.pushNamed(context, "/start", arguments: fileContent);
  }
}

getCoverImage(int index, List images) {
  return images[index];
}

class Story extends ChangeNotifier {
  static List storyNames = ["clown", "gallipoli"];
  static String selectedStoryName = "clown";

  void selectStoryName(int index) {
    if (index == 0) {
      selectedStoryName = "clown";
      notifyListeners();
    } else {
      selectedStoryName = "gallipoli";
      notifyListeners();
    }
  }
}
