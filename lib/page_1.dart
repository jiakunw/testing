import 'package:flutter/material.dart';
import 'custom_widgets.dart';
import 'dart:async';
import 'globals.dart';
import 'page_2.dart';
import 'package:cloud_functions/cloud_functions.dart';

class PageOne extends StatefulWidget {
  const PageOne({super.key});

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  final TextEditingController _emailController = TextEditingController();
  Timer? _timer;
  int _start = 0;
  int _remainingSeconds =
      60 - (DateTime.now().difference(lastEmailVeriTime).inSeconds);
  final Duration _clickTimeLimit = const Duration(seconds: 4);
  final String _warningClick =
      "we are proessing your request, do not send frequent resuests";
  DateTime _lastClickedTimeVerify = DateTime(2020, 9, 7, 17, 30);

  void startTimer(int seconds) {
    _start = seconds;
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (mounted) {
          if (_start == 0) {
            setState(() {
              timer.cancel();
            });
          } else {
            print("gon set state");
            setState(() {
              _remainingSeconds = getRemainingSeconds();
              print(_remainingSeconds);
              _start--;
            });
          }
        }
      },
    );
  }

  @override
  void dispose() {
    print("call dispose");
    if (_timer != null) {
      _timer!.cancel();
    }
    // Future.delayed(Duration(seconds: 1));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.pink,
      ),
      body: Column(
        children: [
          CustomSingleTextField2(
            "Google Email",
            "15251",
            "e.g. scs251@gmail.com",
            _emailController,
          ),
          const SizedBox(
            height: 30,
          ),
          CustomMajorButton(
              context,
              checkIsEmailVerificationValid()
                  ? 'Send Verification'
                  : 'Resend Vefitiaction in  ${_remainingSeconds}s', () async {
            /*
                  EMAIL VALIDITY CHECKS
                */

            if (!checkIsEmailVerificationValid()) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      'You can only resend verificaiton email after ${_remainingSeconds}s')));
              return;
            }

            DateTime currentTime =
                DateTime.now(); // dateTime1.isAtSameMomentAs(dateTime2);
            if (currentTime.difference(_lastClickedTimeVerify) <
                _clickTimeLimit) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(_warningClick)));
              return;
            }
            _lastClickedTimeVerify = DateTime.now();

            final sendEmailVerificationFunc = FirebaseFunctions.instance
                .httpsCallable('sendVerificationEmail');
            final data = {'email': _emailController.text};
            sendEmailVerificationFunc(data);

            setState(() {
              lastEmailVeriTime = DateTime.now();
            });

            startTimer(60);

            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PageTwo(email: _emailController.text)));
          })
        ],
      ),
    );
  }
}

bool checkIsEmailVerificationValid() {
  // DateTime.now() - lastEmailVeriTime > 1 second
  // Need to check if lastEmailVeriTime is initialized.
  return DateTime.now().difference(lastEmailVeriTime).inSeconds > 60;
}

int getRemainingSeconds() {
  // Precond: checkIsEailVerificationValid should return false
  int result = 60 - (DateTime.now().difference(lastEmailVeriTime).inSeconds);
  //print(result);
  return result;
}
