import 'package:flutter/material.dart'; //Brings in the main Flutter building blocks (buttons, text, layout, colors)
import 'package:practice_app/homeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart'; //helper that lets the app remember small things between runs (like the chosen theme).

void main() { //app’s starting point — the first thing the phone runs.
  runApp(const MyApp()); //Start the app and use MyApp as the root of the interface
}

class MyApp extends StatefulWidget { //can change over time (for example switching between dark and light theme)
  const MyApp({super.key});


//createState() returns an object (_MyAppState) that actually holds the changing data and logic.
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkTheme = false; //a private variable to track the current theme state.

  @override
  void initState() { //runs once when this widget is first created
    super.initState();
    _loadTheme(); //to check the saved preference (if the user previously chose dark mode)
  }

  _loadTheme() async { //reads the saved theme from SharedPreferences.
   //gets the notebook (this is asynchronous — it may take a moment).
    SharedPreferences prefs = await SharedPreferences.getInstance(); 
    setState(() { //tells Flutter to redraw the app with the new value
      _isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
    });
  }

  _saveTheme(bool value) async { //writes the chosen theme (true or false) into the notebook so it’s remembered next time
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkTheme', value);
  }

  void _toggleTheme() { //flips between dark and light.
    setState(() {
      _isDarkTheme = !_isDarkTheme;
      _saveTheme(_isDarkTheme);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Practice App',
      debugShowCheckedModeBanner: false,
      theme: _isDarkTheme ? ThemeData.dark() : ThemeData.light(),
      //sets the first screen the user sees and passes the _toggleTheme function into that screen so a button there can change the theme
      home: HomeScreen(toggleTheme: _toggleTheme),
    );
  }
}
