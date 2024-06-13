import 'dart:async';
import 'package:flutter/material.dart';
import 'package:readfast/first_page.dart';

class Read extends StatefulWidget {
  late Timer timer;
  int reader = 0;
  List<String> contentName = [];
  int start = 0;
  Read({super.key});

  @override
  State<Read> createState() => _ReadState();
}

class _ReadState extends State<Read> {
  /* _ReadState({required this.nameOfStory}); */

  

  void startTimer() async {
    widget.start = widget.contentName.length;
    widget.timer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      setState(() {
        if (widget.start > 1) {
          widget.start--;
          widget.reader++;
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
    widget.timer.cancel();
    super.dispose();
    widget.reader = 0;
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    widget.contentName = ModalRoute.of(context)!.settings.arguments as List<String>;
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: widget.contentName.isEmpty
            ? const SizedBox(
                height: 100, width: 100, child: CircularProgressIndicator())
            : Text(
                widget.contentName[widget.reader],
                style: const TextStyle(fontSize: 50),
              ),
      ),
    );
  }
}
