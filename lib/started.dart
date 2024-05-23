import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:readfast/first_page.dart';

class Read extends StatefulWidget {
  const Read({super.key});

  @override
  State<Read> createState() => _ReadState();
}

class _ReadState extends State<Read> {
  /* _ReadState({required this.nameOfStory}); */

  String nameOfStory = FirstPageState.selectedStoryName;
  late Timer timer;
  int reader = 0;
  List<String> contentName = [];
  int start = 0;

  void startTimer() async {
    start = contentName.length;
    print(start);
    timer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      setState(() {
        if (start > 1) {
          start--;
          reader++;
        } else {
          timer.cancel();
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    //String nameOfStory = ModalRoute.of(context)!.settings.arguments.toString();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
    reader = 0;
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    contentName = ModalRoute.of(context)!.settings.arguments as List<String>;
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: contentName.isEmpty
            ? const SizedBox(
                height: 100, width: 100, child: CircularProgressIndicator())
            : Text(
                contentName[reader],
                style: const TextStyle(fontSize: 50),
              ),
      ),
    );
  }
}
