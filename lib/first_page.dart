import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FirstPage extends StatefulWidget {
  FirstPage({super.key});
  // final List images = FirstPageState()
  //     .storyNames
  //     .map(
  //       (e) => "assets/images/covers/$e.png",
  //     )
  //     .toList();
  final List<Image> immutablePages = FirstPageState()
      .storyNames
      .map(
        (e) => Image.asset("assets/images/covers/$e.png"),
      )
      .toList();

  List<Image> pages = FirstPageState()
      .storyNames
      .map(
        (e) => Image.asset("assets/images/covers/$e.png"),
      )
      .toList();
  final PageController pageController = PageController();

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  void initState() {
    widget.pageController.addListener(
      () {
        if ((widget.pageController.page ?? 0) <= 1 &&
            0 <= (widget.pageController.page ?? 0)) {
          widget.pages = [
            ...widget.immutablePages,
            ...widget.pages,
          ];
        } else if ((widget.pageController.page ?? 0) <=
                widget.pages.length - 1 &&
            widget.pages.length - 2 <= (widget.pageController.page ?? 0)) {
          widget.pages = [
            ...widget.pages,
            ...widget.immutablePages,
          ];
        }
      },
    );
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if ((widget.pageController.page ?? 0) <= 1 &&
          0 <= (widget.pageController.page ?? 0)) {
        print("giriyor");
        widget.pages = [
          ...widget.immutablePages,
          ...widget.pages,
        ];
        print(widget.pages);
      } else if ((widget.pageController.page ?? 0) <= widget.pages.length - 1 &&
          widget.pages.length - 2 <= (widget.pageController.page ?? 0)) {
        widget.pages = [
          ...widget.pages,
          ...widget.immutablePages,
        ];
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 400.h,
          child: PageView.builder(
            controller: widget.pageController,
            itemBuilder: (context, index) {
              return widget.pages[index];
            },
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

  Widget cycledPageView(BuildContext context, int index) {
    if (index == 0) {
      widget.pages = [
        ...widget.immutablePages,
        ...widget.pages,
      ];
    } else if (index == widget.pages.length - 1) {
      widget.pages = [
        ...widget.pages,
        ...widget.immutablePages,
      ];
    }

    return widget.pages[index];
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
    //TODO according to pageController change the selectedStoryName (pageController,changeNotifier,listeners,)
    if (index == 0) {
      selectedStoryName = "clown";
    } else {
      selectedStoryName = "gallipoli";
    }
  }
}
