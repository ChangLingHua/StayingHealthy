import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/sedentary_page/round_button.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:sensors_plus/sensors_plus.dart';
import '../menu_widget.dart';


class Remind extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.orange
      ),
      home: RemindState(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RemindState extends StatefulWidget {
  const RemindState({Key? key}) : super(key: key);

  @override
  _RemindState createState() => _RemindState();
}

class _RemindState extends State<RemindState>
    with TickerProviderStateMixin{
  late AnimationController controller;
  bool isPlaying = false;

  List<double>? _gyroscopeValues;
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];

  final Color mainColor = Color(0xFFF9A825);


  String get countText {
    Duration count = controller.duration! * controller.value;
    return controller.isDismissed
        ? '${controller.duration!.inHours}:${(controller.duration!.inMinutes % 60).toString().padLeft(2, '0')}:${(controller.duration!.inSeconds % 60).toString().padLeft(2, '0')}'
        : '${count.inHours}:${(count.inMinutes % 60).toString().padLeft(2, '0')}:${(count.inSeconds % 60).toString().padLeft(2, '0')}';
  }
  double progress = 1.0;

  void notify() {
    if (countText == '0:00:00') {
      FlutterRingtonePlayer.play(fromAsset: 'assets/armsdealermusic.mp3');
      //showAlertDialog(context);

    }
  }

  final _sensors = Sensors();

  Stream<GyroscopeEvent> get gyroscopeEvents {
    return _sensors.gyroscopeEvents;
  }

  @override
  void initState() {

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
    );

    controller.addListener(() {
      notify();
      if (controller.isAnimating) {
        setState(() {
          progress = controller.value;
        });
      } else {
        setState(() {
          progress = 1.0;
          isPlaying = false;
        });
      }
    });
    double x = 0;
    double y = 0;
    double z = 0;

    _streamSubscriptions.add(
      gyroscopeEvents.listen((GyroscopeEvent event) {

        _gyroscopeValues = <double>[event.x, event.y, event.z];

        x = event.x;
        y = event.y;
        z = event.z;

        setState(() {

          if(y < 1) {
            Future.delayed(Duration(seconds: 90),() {

              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content:Text('坐太久了喔！ 起來動一動吧')));


            });
          }

        });
      },
      ),
    );

    super.initState();
  }


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
    for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text('提醒'),
        leading: MenuWidget() ,
      ),
      body: Column(
        children: [
          Expanded(child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 300,
                height: 300,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey.shade300,
                  value: progress,
                  strokeWidth: 6,
                ),
              ),
              GestureDetector(
                onTap: (){
                  if (controller.isDismissed){
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => SizedBox(
                        height: 300,
                        child: CupertinoTimerPicker(
                          initialTimerDuration: controller.duration!,
                          onTimerDurationChanged: (time){
                            setState(() {
                              controller.duration = time;
                            });
                          },
                        ),
                      ),
                    );
                  }
                },
                child: AnimatedBuilder(
                  animation: controller,
                  builder: (context, child) => Text(
                    countText,
                    style: const TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    if (controller.isAnimating) {
                      controller.stop();
                      setState(() {
                        isPlaying = false;
                      });
                    } else {
                      controller.reverse(
                          from: controller.value == 0 ? 1.0 : controller.value);
                      setState(() {
                        isPlaying = true;
                      });
                    }
                  },
                  child: RoundButton(
                    icon: isPlaying == true ? Icons.pause : Icons.play_arrow,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.reset();
                    setState(() {
                      isPlaying = false;
                    });
                  },
                  child: const RoundButton(
                    icon: Icons.stop,
                  ),
                ),

              ],
            ),
          ),
         /* Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Gyroscope: $_gyroscopeValues'),

              ],
            ),
          ),*/
        ],
      ),
    );
  }
}

Future<void> _showAlertDialog(BuildContext context) {
  return showDialog(context: context,
      builder: (BuildContext context) {
    return AlertDialog(
      title: Text('提醒'),
      content: const Text('已經坐太久了喔！'),
      actions: [
        ElevatedButton(
          child: Text('我知道了！'),
          onPressed: (){
            Navigator.of(context).pop();
          }, ),
      ],
    );
      });
}

