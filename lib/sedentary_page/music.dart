
import 'dart:async';
import 'dart:developer';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../menu_widget.dart';



class Music extends StatelessWidget {
  const Music({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music',
      debugShowCheckedModeBanner: false,
      //theme: ThemeData.dark(),
      home: AllSongs(),
    );
  }
}
class AllSongs extends StatefulWidget {
  const AllSongs({Key? key}) : super(key: key);

  @override
  State<AllSongs> createState() => _AllSongsState();
}

class _AllSongsState extends State<AllSongs> {

  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();

  double screenHeight = 0;
  double screenWidth = 0;
  final Color mainColor = Color(0xFFF9A825);
  final Color bblack = Color(0xFF000000);
  final Color wwhite = Color(0xFFFFFFFF);

  final Color inactiveColor = Color(0xff5d6169);

  List<Audio> audioList = [
    Audio('assets/childhood_dreams.mp3',
        metas: Metas(
            title: 'Childhood Dreams',
            artist: 'Unknown Brain',
            image: MetasImage.network('assets/childhood_dreams.png'))),

    Audio('assets/in_the_nature.mp3',
        metas: Metas(
            title: 'In The Nature',
            artist: '',
            image: MetasImage.asset('assets/in_the_nature.png'))),

    Audio('assets/silence.mp3',
        metas: Metas(
            title: 'Silence',
            artist: 'Axollo,Josh Bogert',
            image: MetasImage.asset('assets/silence.png'))),

    Audio('assets/time.mp3',
        metas: Metas(
            title: 'Time',
            artist: 'Syn Cole',
            image: MetasImage.asset('assets/time.png'))),

    Audio('assets/dream_it_possible.mp3',
        metas: Metas(
            title: 'Dream It Possible',
            artist: '',
            image: MetasImage.asset('assets/dream_it_possible.png'))),

    Audio('assets/you_are_the_reason.mp3',
        metas: Metas(
            title: 'You Are The Reason',
            artist: 'Calum Scott ',
            image: MetasImage.asset('assets/you_are_the_reason.png'))),

    Audio('assets/ashitaka_and_san.mp3',
        metas: Metas(
            title: 'Ashitaka And San',
            artist: 'Joe Hisaishi',
            image: MetasImage.asset('assets/ashitaka_and_san.png'))),

    Audio('assets/one_summers_day.mp3',
        metas: Metas(
            title: "One Summer's Day",
            artist: 'Joe Hisaishi',
            image: MetasImage.asset('assets/one_summers_day.png'))),

    Audio('assets/merry_go_round.mp3',
        metas: Metas(
            title: 'Merry Go Round',
            artist: 'Joe Hisaishi',
            image: MetasImage.asset('assets/merry_go_round.png'))),
  ];


  @override
  void initState() {
    super.initState();
    setupPlaylist();
  }

  void setupPlaylist() async {
    audioPlayer.open(Playlist(audios: audioList),
        autoStart: false, loopMode: LoopMode.playlist);
  }


  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
  }

  Widget playlistImage() {
    return Container(
      height: screenHeight * 0.2,
      width: screenHeight * 0.2,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.asset('assets/music.JPG',
        fit: BoxFit.cover,),
      ),
    );
  }

  Widget playlistTitle() {
    return Text('Music Playlist',
    style: TextStyle(
        color: Colors.black,
        fontSize: 25,
        fontWeight: FontWeight.bold),
    );
  }

  Widget playButton() {
    return Container(
      width: screenWidth * 0.25,

      child: TextButton(
          onPressed: () => audioPlayer.playlistPlayAtIndex(0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.play_circle_outline_rounded,
                color: wwhite,
              ),
              SizedBox(width: 5),
              Text(
                'Play',
                style: TextStyle(color: wwhite),
              ),
            ],
          ),
          style: ButtonStyle(
              backgroundColor:
              MaterialStateColor.resolveWith((states) => Colors.black),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )))),
    );
  }

  Widget playlist(RealtimePlayingInfos realtimePlayingInfos) {
    return Container(
      height: screenHeight * 0.36,
      alignment: Alignment.bottomLeft,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: audioList.length,
          itemBuilder: (context, index) {
            return playlistItem(index);
          })
    );
  }

  Widget playlistItem(int index) {
    return Column(
      children: [
        InkWell(
          onTap: () => audioPlayer.playlistPlayAtIndex(index),
          splashColor: Colors.transparent,
          highlightColor: mainColor,
          child: Container(
            height: screenHeight * 0.07,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Row(
                children: [
                  // 照片
                  Container(
                    height: screenHeight * 0.08,
                    width: screenHeight * 0.08,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset(
                        audioList[index].metas.image!.path,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  /*Text('0${index +1}',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      ),
                  ),*/
                  SizedBox(width: screenWidth *0.04),
                  Expanded(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 歌曲名稱
                      Text(
                        audioList[index].metas.title.toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,),
                      ),
                      SizedBox(height: screenHeight * 0.005),
                      // 原唱
                      Text(
                        audioList[index].metas.artist.toString(),
                        style: TextStyle(
                            fontSize: 13,
                            color: Color(0xff5d6169),),
                      ),
                    ],
                  )),
                  Icon(Icons.play_arrow,color: Colors.black,),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: screenWidth * 0.02),
      ],
    );
  }


  Widget bottomPlayContainer(RealtimePlayingInfos realtimePlayingInfos) {
    return Container(
      margin: EdgeInsets.fromLTRB(2, 0, 2, 0),
      height: screenHeight * 0.1,
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(10.0))
              /*topLeft: Radius.circular(20.0), 
              topRight: Radius.circular(20.0)*/
          
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Row(
          children: [
            Container(
              height: screenHeight * 0.08,
              width: screenHeight * 0.08,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  realtimePlayingInfos.current!.audio.audio.metas.image!.path,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: screenWidth * 0.05),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    realtimePlayingInfos.current!.audio.audio.metas.title.toString(),
                    style: TextStyle(
                        fontSize: 15,
                        color: wwhite,
                        fontWeight: FontWeight.bold,),
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  Text(
                    realtimePlayingInfos.current!.audio.audio.metas.artist.toString(),
                    style: TextStyle(
                        fontSize: 13, color: mainColor),
                  )
                ],
              ),
            ),
            SizedBox(
              width: screenWidth * 0.02,
            ),
            IconButton(
                icon: Icon(realtimePlayingInfos.isPlaying
                    ? Icons.pause_circle_filled_rounded
                    : Icons.play_circle_fill_rounded),
                iconSize: screenHeight * 0.07,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                color: wwhite,
                onPressed: () => audioPlayer.playOrPause())
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: wwhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: wwhite,
        title: const Text('Music Playlist',style: TextStyle(color: Colors.black),),
        centerTitle: true,
        leading: MenuWidget(),
        iconTheme: IconThemeData(color: bblack),
      ),

      body: audioPlayer.builderRealtimePlayingInfos(
          builder: (context, RealtimePlayingInfos? realtimePlayingInfos) {
            if (realtimePlayingInfos != null) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //SizedBox(height: 5),
                  playlistImage(),
                  SizedBox(height: screenHeight *0.01),
                  //playlistTitle(),
                 // SizedBox(height: screenHeight *0.02),
                  playButton(),
                  SizedBox(height: screenHeight *0.02),
                  playlist(realtimePlayingInfos),
                  SizedBox(height: screenHeight *0.01),
                  bottomPlayContainer(realtimePlayingInfos),
                ],
              );
            } else {
              return Column();
            }
          }),

    );
  }

}

