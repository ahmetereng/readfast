import 'dart:async';
import 'package:flutter/material.dart';
import 'package:readfast/constants/speed.dart';

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
  void startTimer() async {
    widget.start = widget.contentName.length;
    widget.timer = Timer.periodic(
      ReadingSpeed().medium,
      (timer) {
        setState(
          () {
            if (widget.start > 1) {
              widget.start--;
              widget.reader++;
            } else {
              timer.cancel();
            }
          },
        );
      },
    );
  }

  @override
  void dispose() {
    widget.timer.cancel();
    widget.reader = 0;
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    widget.contentName =
        ModalRoute.of(context)!.settings.arguments as List<String>;
    startTimer();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: widget.contentName.isEmpty
            ? const SizedBox(
                height: 100,
                width: 100,
                child: CircularProgressIndicator(),
              )
            : Text(
                widget.contentName[widget.reader],
                style: const TextStyle(fontSize: 50),
              ),
      ),
    );
  }
}
