// import 'package:dashboard/controller/audioBook_controller.dart';
// import 'package:dashboard/model/audio_model.dart';
// import 'package:dashboard/music_player.dart';
// import 'package:flutter/material.dart';
//
// import 'package:audioplayers/audioplayers.dart';
// import 'package:like_button/like_button.dart';
//
// class AudiobookListScreen extends StatefulWidget {
//   @override
//   _AudiobookListScreenState createState() => _AudiobookListScreenState();
// }
//
// class _AudiobookListScreenState extends State<AudiobookListScreen> {
//   late Future<List<Audiobook>> _audiobooks;
//   final AudioPlayer _audioPlayer = AudioPlayer();
//   bool _isPlaying = false; // Track whether the audio is playing
//
//   @override
//   void initState() {
//     super.initState();
//     _audiobooks = ApiService.fetchAudiobooks();
//   }
//   // Method to toggle play/pause
//   void _togglePlayPause(Audiobook audiobook) {
//     if (_isPlaying) {
//       _audioPlayer.pause();
//     } else {
//       _audioPlayer.play(UrlSource(audiobook.audioUrl));
//     }
//     setState(() {
//       _isPlaying = !_isPlaying; // Toggle the play/pause state
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Audiobooks'),
//       ),
//       body: FutureBuilder<List<Audiobook>>(
//         future: _audiobooks,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No audiobooks available.'));
//           }
//
//           final audiobooks = snapshot.data!;
//           return ListView.builder(
//             itemCount: audiobooks.length,
//             itemBuilder: (context, index) {
//               final audiobook = audiobooks[index];
//               return ListTile(
//                 // leading: Image.network(  audiobook.coverImage ?? 'https://example.com/placeholder.jpg',
//                 //     width: 50, height: 50, fit: BoxFit.cover),
//                 title: GestureDetector(
//                     onTap : (){
//                       Navigator.push(context, MaterialPageRoute(builder: (context)=> MusicView(
//                           audioName : audiobook.title,
//                           audioAuthor : audiobook.author,
//                           audioUrl : audiobook.audioUrl,
//                           duration: audiobook.duration!,
//                       )));
//
//                     },child: Text(audiobook.title)),
//                 subtitle: Text(audiobook.author),
//                 trailing: IconButton(
//                   icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
//                   onPressed: () {
//                     _togglePlayPause(audiobook);
//                   },
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
//
//



import 'package:book_management/modules/audioBook/controller/audioBook_controller.dart';
import 'package:book_management/modules/audioBook/view/PlayingControls.dart';
import 'package:book_management/modules/audioBook/view/PositionSeekWidget.dart';
import 'package:book_management/modules/audioBook/view/SongSelector.dart';
import 'package:book_management/widgets/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class AudiobookView extends StatefulWidget {
  const AudiobookView({super.key});

  @override
  State<AudiobookView> createState() => _AudiobookViewState();
}

class _AudiobookViewState extends State<AudiobookView> {
late  AudioController audioController;
final ThemeController themeController = Get.put(ThemeController());
    String? currentAudioTitle ;
    String? currentAudioAuthor ;

    @override
  void initState() {
      audioController = Get.put(AudioController());
      audioController.fetchAudios();
    // TODO: implement initState
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    var isDark = themeController.isDarkTheme.value == true;
    final current = audioController.assetsAudioPlayer.current;

    final bool isAudioReady =
        current.hasValue && current.value?.audio != null;

    return MaterialApp(
      home: Scaffold(
        backgroundColor: isDark ? Colors.black : Colors.grey[200],
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 48.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(height: 20),
                  Stack(
                    children: <Widget>[
                      StreamBuilder<Playing?>(
                          stream: audioController.assetsAudioPlayer.current,
                          builder: (context, playing) {
                            if (playing.data != null) {
                              final myAudio = find(
                                  audioController.audios, playing.data!.audio.assetAudioPath);
                              currentAudioTitle = myAudio.metas.title;
                              currentAudioAuthor = myAudio.metas.artist;
                              return
                                Container(
                        height: 240,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          ),
                          boxShadow: [
                            BoxShadow(color: Colors.orange.withOpacity(0.5), blurRadius: 0, spreadRadius: 5),
                          ],
                        ),

                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: CircleAvatar(
                                      radius: 75,
                                      backgroundImage: myAudio.metas.image?.type ==
                                          ImageType.network
                                          ? NetworkImage(myAudio.metas.image!.path)
                                          : AssetImage(myAudio.metas.image!.path)
                                      as ImageProvider,
                                    ),
                                  ),
                                ),
                              );
                            }
                            return    Container(
                              height: 240,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(50),
                                  bottomRight: Radius.circular(50),
                                ),
                                boxShadow: [
                                  BoxShadow(color: Colors.orange.withOpacity(0.5), blurRadius: 0, spreadRadius: 5),
                                ],
                              ),

                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: CircleAvatar(
                                    radius: 75,
                                    backgroundImage: NetworkImage('https://image.shutterstock.com/image-vector/pop-music-text-art-colorful-600w-515538502.jpg')

                                    as ImageProvider,
                                  ),
                                ),
                              ),
                            );
                          }),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: const Icon(Icons.add_alert, color: Colors.grey),
                          onPressed: () {
                            AssetsAudioPlayer.playAndForget(
                                Audio('assets/audios/horn.mp3'));
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // audioController.assetsAudioPlayer.builderCurrent(
                  //     builder: (context, Playing? playing) {
                  //
                  //       return Column(
                  //         children: <Widget>[
                  //       Column(
                  //                 children: [
                  //                   Text("${currentAudioTitle}",
                  //                     style: TextStyle(color: Colors.white, fontSize: 34, fontWeight: FontWeight.w600),
                  //                   ),
                  //
                  //                   Text("${currentAudioAuthor}",
                  //                     style: TextStyle(color: Colors.grey),
                  //                   ),
                  //
                  //                 ],
                  //               ),
                  //
                  //           audioController.assetsAudioPlayer.builderLoopMode(
                  //             builder: (context, loopMode) {
                  //               return PlayerBuilder.isPlaying(
                  //                   player:  audioController.assetsAudioPlayer,
                  //                   builder: (context, isPlaying) {
                  //                     return PlayingControls(
                  //                       loopMode: loopMode,
                  //                       isPlaying: isPlaying,
                  //                       isPlaylist: true,
                  //                       onStop: () {
                  //                         audioController.assetsAudioPlayer.stop();
                  //                       },
                  //                       toggleLoop: () {
                  //                         audioController.assetsAudioPlayer.toggleLoop();
                  //                       },
                  //                       onPlay: () {
                  //                         audioController.assetsAudioPlayer.playOrPause();
                  //                       },
                  //                       onNext: () {
                  //                         audioController.assetsAudioPlayer.next(
                  //                             keepLoopMode: true);
                  //                       },
                  //                       onPrevious: () {
                  //                         audioController.assetsAudioPlayer.previous();
                  //                       },
                  //                     );
                  //                   });
                  //             },
                  //           ),
                  //           audioController.assetsAudioPlayer.builderRealtimePlayingInfos(
                  //               builder: (context, RealtimePlayingInfos? infos) {
                  //                 if (infos == null) {
                  //                   return const SizedBox();
                  //                 }
                  //                 return Column(
                  //                   children: [
                  //                     PositionSeekWidget(
                  //                       currentPosition: infos.currentPosition,
                  //                       duration: infos.duration,
                  //                       seekTo: (to) {
                  //                         audioController.assetsAudioPlayer.seek(to);
                  //                       },
                  //
                  //                     ),
                  //                     Row(
                  //                       mainAxisAlignment: MainAxisAlignment.center,
                  //                       children: [
                  //                         ElevatedButton(
                  //                           onPressed: () {
                  //                             audioController.assetsAudioPlayer
                  //                                 .seekBy(Duration(seconds: -10));
                  //                           },
                  //                           child: const Text('-10'),
                  //                         ),
                  //                         const SizedBox(width: 12),
                  //                         ElevatedButton(
                  //                           onPressed: () {
                  //                             audioController.assetsAudioPlayer
                  //                                 .seekBy(Duration(seconds: 10));
                  //                           },
                  //                           child: const Text('+10'),
                  //                         ),
                  //                       ],
                  //                     ),
                  //                   ],
                  //                 );
                  //               }),
                  //         ],
                  //       );
                  //     }),

          //        (!isAudioReady)
          // ? buildNoAudioSection() :
            audioController.assetsAudioPlayer.builderCurrent(
                  builder: (context, Playing? playing) {

                    // ---------- 1. If NO AUDIO is loaded ----------


                    // ---------- 2. Audio is Loaded ----------
                    return Column(
                      children: <Widget>[
                        // TITLE + ARTIST
                        Column(
                          children: [
                            Text(
                              currentAudioTitle ?? "",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 34,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              currentAudioAuthor ?? "",
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),

                        // PLAYER CONTROLS
                        audioController.assetsAudioPlayer.builderLoopMode(

                          builder: (context, loopMode) {


                            return PlayerBuilder.isPlaying(
                              player: audioController.assetsAudioPlayer,
                              builder: (context, isPlaying) {
                                return PlayingControls(
                                  loopMode: loopMode,
                                  isPlaying: isPlaying,
                                  isPlaylist: true,

                                  // disable controls
                                  onStop:  !isAudioReady
                                      ? null
                                      : () => audioController.assetsAudioPlayer.stop(),

                                  toggleLoop:  !isAudioReady
                                      ? null
                                      : () => audioController.assetsAudioPlayer.toggleLoop(),

                                  onPlay:  !isAudioReady
                                      ? () {} // disabled
                                      : () {
                                    audioController.assetsAudioPlayer.playOrPause();
                                  },




                                  onNext: !isAudioReady
                                      ? null
                                      : () => audioController.assetsAudioPlayer.next(
                                    keepLoopMode: true,
                                  ),

                                  onPrevious: !isAudioReady
                                      ? null
                                      : () => audioController.assetsAudioPlayer.previous(),
                                );
                              },
                            );
                          },
                        ),

                        // PROGRESS BAR + SEEK BUTTONS
                        audioController.assetsAudioPlayer.builderRealtimePlayingInfos(
                          builder: (context, RealtimePlayingInfos? infos) {
                            if (infos == null) {
                              return const SizedBox();
                            }

                            return Column(
                              children: [
                                PositionSeekWidget(
                                  currentPosition: infos.currentPosition,
                                  duration: infos.duration,
                                  seekTo: (to) =>
                                      audioController.assetsAudioPlayer.seek(to),
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: playing == null
                                          ? null
                                          : () => audioController.assetsAudioPlayer
                                          .seekBy(const Duration(seconds: -10)),
                                      child: const Text('-10'),
                                    ),
                                    const SizedBox(width: 12),
                                    ElevatedButton(
                                      onPressed: playing == null
                                          ? null
                                          : () => audioController.assetsAudioPlayer
                                          .seekBy(const Duration(seconds: 10)),
                                      child: const Text('+10'),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 20),
                  audioController.assetsAudioPlayer.builderCurrent(
                      builder: (BuildContext context, Playing? playing) {
                        return SongsSelector(
                          audios:  audioController.audios,
                          onPlaylistSelected: (myAudios) {
                            audioController.assetsAudioPlayer.open(
                              Playlist(audios: myAudios),
                              showNotification: true,
                              headPhoneStrategy:
                              HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
                              audioFocusStrategy: AudioFocusStrategy.request(
                                  resumeAfterInterruption: true),
                            );
                          },
                          onSelected: (myAudio) async {
                            try {
                              await  audioController.assetsAudioPlayer.open(
                                myAudio,
                                autoStart: true,
                                showNotification: true,
                                playInBackground: PlayInBackground.enabled,
                                audioFocusStrategy: AudioFocusStrategy.request(
                                    resumeAfterInterruption: true,
                                    resumeOthersPlayersAfterDone: true),
                                headPhoneStrategy:
                                HeadPhoneStrategy.pauseOnUnplug,
                                loopMode: LoopMode.playlist, // Ensures the playlist loops

                              );
                            } catch (e) {
                              print(e);
                            }
                          },
                          playing: playing,
                        );
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget buildNoAudioSection() {
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 5)),
      builder: (context, snapshot) {
        // ⏳ Still waiting → show loader
        if (snapshot.connectionState != ConnectionState.done) {
          return const Column(
            children: [
              SizedBox(height: 20),
              CircularProgressIndicator(color: Colors.white),
              SizedBox(height: 10),
              Text(
                "Loading audio...",
                style: TextStyle(color: Colors.white70),
              ),
            ],
          );
        }

        // ❌ After delay and still no audio → show message
        return const Column(
          children: [
            SizedBox(height: 20),
            Text(
              "No audio loaded",
              style: TextStyle(color: Colors.red, fontSize: 20),
            ),
          ],
        );
      },
    );
  }

}