import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_music_player/provider/theme_provider.dart';

class MusicBox extends StatelessWidget {
  final Widget child;
  const MusicBox({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // IS DARK MODE
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(13)),
          color: Theme.of(context).colorScheme.background,
          boxShadow: [
            BoxShadow(
              color: isDarkMode ? Colors.black : Colors.brown.shade900,
              blurRadius: 15,
              offset: const Offset(4, 4),
            ),
            BoxShadow(
              color: isDarkMode ? Colors.grey.shade800 : Colors.brown.shade500,
              blurRadius: 15,
              offset: const Offset(-4, -4),
            )
          ]),
      padding: const EdgeInsets.all(12),
      child: child,
    );
  }
}
