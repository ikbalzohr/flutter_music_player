import 'package:flutter/material.dart';
import 'package:flutter_music_player/components/music_box.dart';
import 'package:flutter_music_player/provider/playlist_provider.dart';
import 'package:provider/provider.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  String formatTime(Duration duration) {
    String twoDigitSecond =
        duration.inSeconds.remainder(60).toString().padLeft(2, "0");
    String foramttedTime = "${duration.inMinutes}:$twoDigitSecond";

    return foramttedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(builder: (context, value, child) {
      // GET PLAYLIST
      final playlist = value.playlist;

      // GET CURRENT SONG INDEX
      final currentSong = playlist[value.currentSongIndex ?? 0];

      // UI
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0, bottom: 25),
            child: Column(
              children: [
                // APP BAR WIDGET
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // BACK BUTTON
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                    ),

                    // TITLE
                    const Text("P L A Y L I S T"),

                    // MENU BUTTON
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.menu),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                // ALBUM ARTWORK
                Column(
                  children: [
                    MusicBox(
                      child: Column(
                        children: [
                          // IMAGE
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              currentSong.albumArtImagePath,
                              height: 300,
                              fit: BoxFit.cover,
                            ),
                          ),

                          // SONG ARTIST ICON
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // SONG AND ARTIST NAME
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      currentSong.songName,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(currentSong.artistName)
                                  ],
                                ),

                                // HEART ICON
                                const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(height: 35),

                    // SONG DURATION PROGRESS
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // START TIME
                          Text(formatTime(value.currentDuration)),

                          // SUFFLE ICON
                          const Icon(Icons.shuffle),

                          // REPEAT ICON
                          const Icon(Icons.repeat),

                          // END TIME
                          Text(formatTime(value.totalDuration)),
                        ],
                      ),
                    ),

                    // PROGRESS BAR
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        thumbShape:
                            const RoundSliderThumbShape(enabledThumbRadius: 5),
                        activeTrackColor: Colors.green,
                        thumbColor: Colors.green,
                      ),
                      child: Slider(
                        min: 0,
                        max: value.totalDuration.inSeconds.toDouble(),
                        value: value.currentDuration.inSeconds.toDouble(),
                        activeColor: Colors.green,
                        onChanged: (double double) {
                          // DURING WHEN THE USER IS SLIDING AORUND
                        },
                        onChangeEnd: (double double) {
                          value.seekTo(Duration(seconds: double.toInt()));
                        },
                      ),
                    ),

                    const SizedBox(height: 15),

                    // PLAYBACK CONTROLS
                    Row(
                      children: [
                        // SKIP PREVIOUS ICON
                        Expanded(
                          child: GestureDetector(
                            onTap: value.playPreviousSong,
                            child: const MusicBox(
                              child: Icon(Icons.skip_previous),
                            ),
                          ),
                        ),

                        const SizedBox(width: 25),

                        // PLAY PAUSE ICON
                        Expanded(
                          flex: 2,
                          child: GestureDetector(
                            onTap: value.toggleSong,
                            child: MusicBox(
                              child: Icon(value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow),
                            ),
                          ),
                        ),

                        const SizedBox(width: 25),

                        // SKIP FORWARD ICON
                        Expanded(
                          child: GestureDetector(
                            onTap: value.playNextSong,
                            child: const MusicBox(
                              child: Icon(Icons.skip_next),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
