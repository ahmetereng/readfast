import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FirstPage extends StatefulWidget {
  FirstPage({super.key});
  final List images = FirstPageState()
      .storyNames
      .map(
        (e) => "assets/images/covers/$e.png",
      )
      .toList();

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 400.h,
          child: PageView(
            children: [
              Image.asset(
                widget.images[0],
              ),
              Image.asset(
                widget.images[1],
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 30.h),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                  50.w,
                  0.h,
                  5.w,
                  0,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    loadTextFile(
                      FirstPageState.selectedStoryName,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFDDDCDB),
                    textStyle: TextStyle(
                      fontSize: 24.sp,
                    ),
                    overlayColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.elliptical(30.w, 25.h),
                      ),
                    ),
                    minimumSize: const Size(
                      300,
                      60,
                    ),
                  ),
                  child: const Text(
                    '    START!   ',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              IconButton.filled(
                onPressed: () {},
                icon: const Icon(Icons.settings),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> loadTextFile(String nameOfStory) async {
    final String response = await rootBundle.loadString(
      'assets/data/$nameOfStory.txt',
    );

    final fileContent = response
        .replaceAll(".", " ")
        .replaceAll(";", " ")
        .replaceAll("?", " ")
        .replaceAll("-", "- ")
        .replaceAll("\n", "")
        .split(" ")
        .where(
          (a) => a != "",
        )
        .toList();
    Navigator.pushNamed(
      context,
      "/start",
      arguments: fileContent,
    );
  }
}

getCoverImage(
  int index,
  List images,
) {
  return images[index];
}

class FirstPageState extends ChangeNotifier {
  List storyNames = [
    "clown",
    "gallipoli",
  ];
  static String selectedStoryName = "clown";

  void selectStoryName(int index) {
    //TODO according to pageController change the storyname (pageController,changeNotifier,listeners,)
    if (index == 0) {
      selectedStoryName = "clown";
    } else {
      selectedStoryName = "gallipoli";
    }
  }
}
