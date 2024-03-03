import 'package:flutter/material.dart';
import 'package:flutter_music_player/provider/playlist_provider.dart';
import 'package:flutter_music_player/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_music_player/pages/home_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => PlaylistProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
