import 'dart:async';

import 'package:get/get.dart';


class TimerController extends GetxController {
  late RxInt remainingTime;
  var status = false.obs;

  TimerController() {
    remainingTime = 0.obs;
  }

  Timer? _timer;

  void startTimer() {
    status.value = true;
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (remainingTime == 43200) {
          stopTimer();
        } else {
          remainingTime++;
        }
      },
    );
  }

  void stopTimer() {
    _timer?.cancel();
    status.value = false;
    remainingTime.value = 0;
  }

  String getRemainingTime() {
    return '${(remainingTime ~/ 3600).toString().padLeft(2, '0')}:'
        '${(remainingTime ~/ 60 % 60).toString().padLeft(2, '0')}:'
        '${(remainingTime % 60).toString().padLeft(2, '0')}';
  }
}