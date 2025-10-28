import 'package:flutter/material.dart';
import 'package:practice_app/galleryScreen.dart';
import 'package:practice_app/profileScreen.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback toggleTheme; // VoidCallback is a type definition for a function that takes no arguments and returns nothing.
  //accepts a toggleTheme function from MyApp. That lets HomeScreen ask the app to switch themes
  const HomeScreen({required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold( //gives a standard app page structure: top bar, body, etc
      appBar: AppBar( //top bar with a title.
        title: const Text("flutter practice home"),
        actions: [ //show buttons or icons on the right side of the app bar
          IconButton(onPressed: toggleTheme, icon: const Icon(Icons.brightness_6)
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Welcome! Choose a screen to explore."),
            const SizedBox(height: 20),
            ElevatedButton(onPressed:() => Navigator.push(
              context,
              MaterialPageRoute(builder:(_) => ProfileScreen()),
            ), 
            child: const Text("Go to Profile Screen"),
            ),
            ElevatedButton(onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => GalleryScreen()),
            ), 
            child: const Text("Go to Gallery Screen"),
            ),
          ]
        ),
      )
    );
  }
}
