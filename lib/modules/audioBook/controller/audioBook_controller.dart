
import 'dart:convert';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:book_management/modules/audioBook/model/audio_model.dart';
import 'package:book_management/repository/api_client.dart';
import 'package:book_management/repository/api_endpoints.dart';
import 'package:book_management/widgets/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
class AudioController extends GetxController {
  final AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
  final RxList<Audio> audios = <Audio>[].obs;
  final RxBool isLoading = true.obs;
  final RxBool loaded = false.obs;


  @override
  void onInit() {
    super.onInit();
    fetchAudios();
  }

  Future<List<Audiobook>> fetchAudioData() async {
    Widgets.showLoader("Fetching");
    final response = await ApiHelper.get(ApiEndpoints.audioBook);
    if(kDebugMode) {
      print(response);
    }
    if (response['status'] == "S") {
      Widgets.hideLoader();

      final List<dynamic> data = response['data'];   // << correct
      return data.map((json) => Audiobook.fromJson(json)).toList();

    } else {
      Widgets.hideLoader();

      throw Exception('Failed to load audio data');
    }
  }

  Future<void> fetchAudios() async {
    Widgets.showLoader("Fetching");

    try {
      final audioData = await fetchAudioData();
      audios.value = audioData.map((audioModel) {
        return Audio.network(
          audioModel.audioUrl,
          metas: Metas(
            id: audioModel.id,
            title: audioModel.title,
            artist: audioModel.author,
            album: audioModel.description,
            image: MetasImage.network(
                'https://image.shutterstock.com/image-vector/pop-music-text-art-colorful-600w-515538502.jpg'),
          ),
        );
      }).toList();
      loaded.value = true;

      openPlayer();
    } catch (e) {
      Widgets.hideLoader();
      print('Error2: $e');
    } finally {
      Widgets.hideLoader();

      isLoading.value = false;
    }
  }

  void openPlayer() async {
    if (audios.isNotEmpty) {
      await assetsAudioPlayer.open(
        Playlist(audios: audios, startIndex: 0),
        showNotification: true,
        autoStart: false,
      );
    }
  }

  @override
  void onClose() {
    assetsAudioPlayer.dispose();
    super.onClose();
  }
}
Audio find(List<Audio> source, String fromPath) {
  return source.firstWhere((element) => element.path == fromPath);
}