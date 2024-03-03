import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_player/models/song.dart';

class PlaylistProvider extends ChangeNotifier {
  // PLAYLIST OF SONGS
  final List<Song> _playlist = [
    // SONG 1
    Song(
      songName: "Tally",
      artistName: "Blackpink",
      albumArtImagePath: "assets/images/bp_tally.png",
      audioPath: "songs/bp_tally.mp3",
    ),
    // SONG 2
    Song(
      songName: "Cupid ",
      artistName: "Fifty Fifty",
      albumArtImagePath: "assets/images/ff_cupid.png",
      audioPath: "songs/ff_cupid.mp3",
    ),
    // SONG 3
    Song(
      songName: "OMG",
      artistName: "New Jeans",
      albumArtImagePath: "assets/images/nj_omg.png",
      audioPath: "songs/nj_omg.mp3",
    ),
    Song(
      songName: "Mr Chu",
      artistName: "Apink",
      albumArtImagePath: "assets/images/apk_mc.png",
      audioPath: "songs/apk_mc.mp3",
    ),
    Song(
      songName: "What is love?",
      artistName: "Twice",
      albumArtImagePath: "assets/images/tws_wil.png",
      audioPath: "songs/tws_wil.mp3",
    )
  ];

  /*
  A U D I O P L A Y E R
  */

  // CURRENT SONG PLAYLIST INDEX
  int? _currentSongIndex;

  final AudioPlayer _audioPlayer = AudioPlayer();

  // DURATION OF CURRENT SONG
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  // CONSTRUCTOR
  PlaylistProvider() {
    listenToDuration();
  }

  // LISTEN TO DURATION
  void listenToDuration() {
    // LISTEN FOR TOTAL DURATION
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    // LISTEN FOR CURRENT DURATION
    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    // LISTEN FOR SONG COMPLETION
    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }

  // INITIALLY NOT PLAYING
  bool _isPlaying = false;

  // PLAY THE SONG
  void playSong() async {
    final String path = _playlist[_currentSongIndex!].audioPath;
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(path));
    _isPlaying = true;
    notifyListeners();
  }

  // PAUSE THE SONG
  void pauseSong() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  // RESUME THE SONG
  void resumeSong() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  // PAUSE OR RESUME THE SONG
  void toggleSong() async {
    if (_isPlaying) {
      pauseSong();
    } else {
      resumeSong();
    }
    notifyListeners();
  }

  // SEEK TO A SPECIFIC POSITION IN THE SONG
  void seekTo(Duration position) async {
    await _audioPlayer.seek(position);
  }

  // PLAY THE NEXT SONG
  void playNextSong() {
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < _playlist.length - 1) {
        _currentSongIndex = _currentSongIndex! + 1;
      } else {
        _currentSongIndex = 0;
      }
    }
    playSong();
  }

  // PLAY THE PREVIOUS SONG
  void playPreviousSong() {
    if (_currentDuration.inSeconds > 3) {
      seekTo(Duration.zero);
    } else {
      if (_currentSongIndex! > 0) {
        _currentSongIndex = _currentSongIndex! - 1;
      } else {
        _currentSongIndex = _playlist.length - 1;
      }
    }
    playSong();
  }

  /*
    G E T T E R S
  */
  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  /*
  S E T T E R S
  */
  set currentSongIndex(int? newIndex) {
    // UPDATE CURRENT SONG INDEX
    _currentSongIndex = newIndex;
    if (newIndex != null) {
      playSong();
    }
    notifyListeners();
  }
}
