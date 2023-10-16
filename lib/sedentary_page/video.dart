
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../menu_widget.dart';



class Video extends StatefulWidget{
  const Video({Key?key}) : super(key: key);

  @override
  State<Video> createState() => _VideoState();
}
class _VideoState extends State<Video> {

  late YoutubePlayerController controller;

  @override
  void initState() {
    super.initState();

    const url = 'https://www.youtube.com/watch?v=l_-t4J1DGPA&t=255s';


    controller = YoutubePlayerController(initialVideoId: YoutubePlayer.convertUrlToId(url)!,
      flags: const YoutubePlayerFlags(
        mute: false, //is video sound playing?
        loop: false, //is same video repeated?
        autoPlay: false, //is video player when initialized?

      ),
    )..addListener(() {
      if (mounted){
        setState(() {

        });
      }
    });
  }

  @override
  void deactivate() {
    controller.pause();
    super.deactivate();
  }


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => YoutubePlayerBuilder(
    player: YoutubePlayer(controller: controller),
    builder: (context, player) => Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: const Text('伸展影片'),
        leading: MenuWidget(),
        elevation: 0,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                player,
                SizedBox(height: 10,),
                Padding(padding: const EdgeInsets.fromLTRB(17, 0, 10, 0),
                child: Text(controller.metadata.title,style: TextStyle(color: Colors.black,fontSize: 18)),),

                SizedBox(height: 8,),
                Padding(padding: const EdgeInsets.fromLTRB(17, 0, 10, 0),
                  child: Text(controller.metadata.author,style: TextStyle(color: Colors.black,fontSize: 13)),),

                SizedBox(height: 5,),
                //Text('${controller.metadata.duration.inSeconds.remainder(60)} seconds'),

                Padding(padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
                  child: Row(
                    children: [
                      InkWell(
                        child: Row(
                          children: [
                            InkWell(
                              splashColor: Colors.brown.withOpacity(0.5),
                              child: Ink(
                                height: 100,
                                width: 150,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/s1.png'),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 15,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text.rich(
                                  TextSpan(text: ' 【肩頸拉筋】Coffee教你五分鐘\n',style: TextStyle(color: Colors.black,fontSize: 13),
                                    children: [
                                      TextSpan(text: '將肩頸膊放鬆：針對低頭族\n',style: TextStyle(color: Colors.black,fontSize: 13)),
                                      TextSpan(text: '長時間使用手機電腦必學',style: TextStyle(color: Colors.black,fontSize: 13)),

                                    ],
                                  ), ),
                                SizedBox(height: 5,),
                                Text('Cosmopolitan HK',style: TextStyle(color: Colors.black,fontSize: 13)),
                              ],
                            ),

                          ],
                        ),
                        onTap: () {
                          const url = 'https://www.youtube.com/watch?v=l_-t4J1DGPA&t=255s';
                          controller.load(YoutubePlayer.convertUrlToId(url)!);
                        },
                      ),
                    ],
                  ),),
                Padding(padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
                    child: Row(
                      children: [
                        InkWell(
                          child: Row(
                            children: [
                              InkWell(
                                splashColor: Colors.brown.withOpacity(0.5),
                                child: Ink(
                                  height: 100,
                                  width: 150,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage('assets/s2.png'),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 15,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,                                children: const [
                                  Text.rich(
                                    TextSpan(text: '三個必備久坐伸展動作｜\n',style: TextStyle(color: Colors.black,fontSize: 14),
                                      children: [
                                        TextSpan(text: '改善駝背、肩頸酸痛｜\n',style: TextStyle(color: Colors.black,fontSize: 14)),
                                        TextSpan(text: '低頭族、上班族必看',style: TextStyle(color: Colors.black,fontSize: 14)),
                                      ],
                                    ), ),
                                  //SizedBox(width: 5,),
                                  Text('Jojo DJ 養生麻吉',style: TextStyle(color: Colors.black,fontSize: 13)),
                                ],
                              ),

                            ],
                          ),
                          onTap: () {
                            const url = 'https://www.youtube.com/watch?v=Wf44nuxGEQ8&t=3s';
                            controller.load(YoutubePlayer.convertUrlToId(url)!);
                          },
                        ),
                      ],
                    ),),

                  Padding(padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
                    child: Row(
                      children: [
                        InkWell(
                          child: Row(
                            children: [
                              InkWell(
                                splashColor: Colors.brown.withOpacity(0.5),
                                child: Ink(
                                  height: 100,
                                  width: 150,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/s3.png'),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 15,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,                              children: const [
                                  Text.rich(
                                    TextSpan(text: '緩解腰痠的10分鐘小運動！\n',style: TextStyle(color: Colors.black,fontSize: 14),
                                      children: [
                                        TextSpan(text: '久坐族必看！\n',style: TextStyle(color: Colors.black,fontSize: 14)),
                                      ],
                                    ), ),
                                  //SizedBox(width: 10,),
                                  Text('詹珞瑤 物理治療師 Veronica Rehab',style: TextStyle(color: Colors.black,fontSize: 11)),
                                ],
                              ),

                            ],
                          ),
                          onTap: () {
                            const url = 'https://www.youtube.com/watch?v=T8cjpnqwj4A';
                            controller.load(YoutubePlayer.convertUrlToId(url)!);
                          },
                        ),
                      ],
                    ),),

                Padding(padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
                  child: Row(
                    children: [
                      InkWell(
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {}, // Handle your callback.
                              splashColor: Colors.brown.withOpacity(0.5),
                              child: Ink(
                                height: 100,
                                width: 150,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/s4.png'),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 15,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text.rich(
                                  TextSpan(text: '久坐族必學臀部伸展\n',style: TextStyle(color: Colors.black,fontSize: 14),
                                    children: [
                                      TextSpan(text: '10分鐘放鬆緊繃肌肉\n',style: TextStyle(color: Colors.black,fontSize: 14)),
                                      TextSpan(text: '尤其第6招超舒服！',style: TextStyle(color: Colors.black,fontSize: 14)),
                                    ],
                                  ), ),
                                //SizedBox(width: 10,),
                                Text('健康2.0',style: TextStyle(color: Colors.black,fontSize: 13)),
                              ],
                            ),

                          ],
                        ),
                        onTap: () {
                          const url = 'https://www.youtube.com/watch?v=-e9l0CheaUI';
                          controller.load(YoutubePlayer.convertUrlToId(url)!);
                        },
                      ),
                    ],
                  ),),
                Padding(padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
                  child: Row(
                    children: [
                      InkWell(
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {}, // Handle your callback.
                              splashColor: Colors.brown.withOpacity(0.5),
                              child: Ink(
                                height: 100,
                                width: 150,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/s5.png'),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 15,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text.rich(
                                  TextSpan(text: '久坐族腰痛很久了嗎？\n',style: TextStyle(color: Colors.black,fontSize: 14),
                                    children: [
                                      TextSpan(text: '這3招幫你放鬆寬關節！\n',style: TextStyle(color: Colors.black,fontSize: 14)),
                                    ],
                                  ), ),
                                //SizedBox(width: 10,),
                                Text('詹珞瑤 物理治療師 Veronica Rehab',style: TextStyle(color: Colors.black,fontSize: 11)),
                              ],
                            ),

                          ],
                        ),
                        onTap: () {
                          const url = 'https://www.youtube.com/watch?v=iJMs7mlW3g4';
                          controller.load(YoutubePlayer.convertUrlToId(url)!);
                        },
                      ),
                    ],
                  ),),
              ],
            ),
          ),
        ],
      ),
    ),

  );
}
