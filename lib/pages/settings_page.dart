import 'package:flutter/material.dart';
import 'package:flutter_music_player/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("S E T T I N G S"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: const BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.all(25.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // DARK MODE
            const Text(
              " Dark Mode",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            // SWITCH
            Switch(
              inactiveThumbColor: Colors.brown,
              activeColor: Colors.green,
              value:
                  Provider.of<ThemeProvider>(context, listen: false).isDarkMode,
              onChanged: (_) =>
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleTheme(),
            ),
          ],
        ),
      ),
    );
  }
}
