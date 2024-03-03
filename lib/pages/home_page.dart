import 'package:flutter/material.dart';
import 'package:flutter_music_player/pages/song_page.dart';
import 'package:provider/provider.dart';

import 'package:flutter_music_player/components/my_drawer.dart';
import 'package:flutter_music_player/models/song.dart';
import 'package:flutter_music_player/provider/playlist_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // GET THE PLAYLIST PROVIDER
  late final dynamic playlistProvider;

  @override
  void initState() {
    super.initState();
    // GET PLAYLIST PROVIDER
    playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
  }

  // GO TO SONG
  void goTosong(int songIndex) {
    // UPDATE CURRENT SONG INDEX
    playlistProvider.currentSongIndex = songIndex;

    // NAVIGATE TO SONG PAGE
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SongPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('P L A Y L I S T'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      drawer: const MyDrawer(),
      body: Consumer<PlaylistProvider>(builder: (context, value, child) {
        // GET THE PLAYLIST
        final List<Song> playlist = value.playlist;

        // RETURN THE LISTVIEW
        return ListView.builder(
          itemCount: playlist.length,
          itemBuilder: (context, index) {
            // GET INDIVIDUAL SONG
            final Song song = playlist[index];

            // RETURN THE LIST TILE UI
            return ListTile(
              title: Text(song.songName),
              subtitle: Text(song.artistName),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(
                  song.albumArtImagePath,
                  width: 80,
                  fit: BoxFit.contain,
                ),
              ),
              onTap: () => goTosong(index),
            );
          },
        );
      }),
    );
  }
}
