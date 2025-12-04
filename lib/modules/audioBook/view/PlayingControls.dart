import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class PlayingControls extends StatelessWidget {
  final bool isPlaying;
  final LoopMode? loopMode;
  final bool isPlaylist;
  final Function()? onPrevious;
  final Function() onPlay;
  final Function()? onNext;
  final Function()? toggleLoop;
  final Function()? onStop;

  PlayingControls({
    required this.isPlaying,
    this.isPlaylist = false,
    this.loopMode,
    this.toggleLoop,
    this.onPrevious,
    required this.onPlay,
    this.onNext,
    this.onStop,
  });

  Widget _loopIcon(BuildContext context) {
    final iconSize = 34.0;
    if (loopMode == LoopMode.none) {
      return Icon(
        Icons.loop,
        size: iconSize,
        color: Colors.grey,
      );
    } else if (loopMode == LoopMode.playlist) {
      return Icon(
        Icons.loop,
        size: iconSize,
        color: Colors.black,
      );
    } else {
      // Single loop
      return Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.loop,
            size: iconSize,
            color: Colors.black,
          ),
          Center(
            child: Text(
              '1',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        GestureDetector(
          onTap: () {
            if (toggleLoop != null) toggleLoop!();
          },
          child: _loopIcon(context),
        ),
        SizedBox(width: 12),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(), // Make the button circular
            padding: const EdgeInsets.all(18), // Add padding
            elevation: 4, // Optional: adjust elevation for the button's shadow
            backgroundColor: isPlaylist ? Colors.blue : Colors.grey, // Adjust color based on the condition
          ),
          onPressed: isPlaylist ? onPrevious : null, // Handle enabling/disabling of the button
          child: const Icon(Icons.skip_previous, color: Colors.white), // Icon inside the button
        ),
        SizedBox(width: 12),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(), // Make the button circular
            padding: const EdgeInsets.all(24), // Add padding for play button
            elevation: 4,
            backgroundColor: isPlaying ? Colors.red : Colors.green, // Change color based on play/pause
          ),
          onPressed: onPlay,
          child: Icon(
            isPlaying ? Icons.pause : Icons.play_arrow,
            size: 32,
            color: Colors.white,
          ),
        ),
        SizedBox(width: 12),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(18),
            elevation: 4,
            backgroundColor: isPlaylist ? Colors.blue : Colors.grey,
          ),
          onPressed: isPlaylist ? onNext : null,
          child: const Icon(Icons.skip_next, color: Colors.white),
        ),
        SizedBox(width: 15),
        if (onStop != null)
          const CustomLikeButton()
          // ElevatedButton(
          //   style: ElevatedButton.styleFrom(
          //     shape: const CircleBorder(),
          //     padding: const EdgeInsets.all(18),
          //     elevation: 4,
          //     backgroundColor: Colors.red,
          //   ),
          //   onPressed: onStop,
          //   child: const Icon(Icons.stop, color: Colors.white),
          // ),
      ],
    );
  }
}
class CustomLikeButton extends StatelessWidget {
  const CustomLikeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return LikeButton(
      size: 30,
      circleSize: 30,
      circleColor: const CircleColor(start: Colors.teal, end: Colors.teal),
      bubblesColor: const BubblesColor(
        dotPrimaryColor: Colors.teal,
        dotSecondaryColor: Colors.teal,
      ),
      likeBuilder: (bool isLiked) {
        return isLiked
            ? const Icon(
          Icons.favorite,
          color: Colors.teal,
          size: 25,
        )
            : const Icon(
          Icons.favorite_border_outlined,
          color: Colors.white,
          size: 25,
        );
      },
    );
  }
}