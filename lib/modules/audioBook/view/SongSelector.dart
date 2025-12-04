import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class SongsSelector extends StatelessWidget {
  final Playing? playing;
  final List<Audio> audios;
  final Function(Audio) onSelected;
  final Function(List<Audio>) onPlaylistSelected;

  SongsSelector({
    required this.playing,
    required this.audios,
    required this.onSelected,
    required this.onPlaylistSelected,
  });

  Widget _image(Audio item) {
    if (item.metas.image == null) {
      return const SizedBox(height: 40, width: 40);
    }

    return item.metas.image?.type == ImageType.network
        ? Image.network(
      item.metas.image!.path,
      height: 40,
      width: 40,
      fit: BoxFit.cover,
    )
        : Image.asset(
      item.metas.image!.path,
      height: 40,
      width: 40,
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      color: Colors.white,
      elevation: 6,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // PLAYLIST BUTTON
            FractionallySizedBox(
              widthFactor: 1,
              child: ElevatedButton(
                onPressed: () => onPlaylistSelected(audios),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Play Entire Playlist',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // AUDIO LIST
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: audios.length,
              itemBuilder: (context, index) {
                final item = audios[index];
                final bool isPlaying =
                    item.path == playing?.audio.assetAudioPath;

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    color: isPlaying ? Colors.blue.shade50 : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isPlaying ? Colors.blueAccent : Colors.grey.shade200,
                      width: isPlaying ? 2 : 1,
                    ),
                    boxShadow: [
                      if (isPlaying)
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.3),
                          blurRadius: 12,
                          spreadRadius: 1,
                          offset: const Offset(0, 4),
                        ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isPlaying ? Colors.blueAccent : Colors.grey.shade300,
                          width: 2,
                        ),
                      ),
                      child: ClipOval(
                        child: _image(item),
                      ),
                    ),
                    title: Text(
                      item.metas.title ?? "Unknown Title",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: isPlaying ? Colors.blueAccent : Colors.black87,
                      ),
                    ),
                    subtitle: Text(
                      item.metas.artist ?? "Unknown Artist",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                      ),
                    ),
                    trailing: Icon(
                      isPlaying ? Icons.equalizer_rounded : Icons.play_arrow_rounded,
                      color: isPlaying ? Colors.blueAccent : Colors.grey,
                    ),
                    onTap: () => onSelected(item),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );

  }
}
