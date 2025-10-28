import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; //helper that lets the app remember small things between runs (like the chosen theme).

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isSubscribed =
      false; //tracks whether the user checked the newsletter box.
  TextEditingController nameController =
      TextEditingController(); //lets the code read and control the text the user types into the TextField.
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    //runs once when screen is created. It sets a default name
    super.initState();
    nameController.text = "Soliana";
    _loadProfile();
  }

  @override
  void dispose() {
    //cleans up resources when the screen is removed (this avoids memory leaks)
    nameController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  _loadProfile() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      nameController.text = pref.getString('userName') ?? "Soliana";
      isSubscribed = pref.getBool('isSubscribed') ?? false;
    });
  }

  _saveProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userName', nameController.text);
    prefs.setBool('isSubscribed', isSubscribed);
  }

  void _showDialog() {
    _saveProfile();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Profile Updated!"),
        content: const Text("Your changes have been saved."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile Screen")),
      body: SingleChildScrollView(
        //makes the page scrollable if its contents are taller than the screen.
        controller: scrollController,
        padding: const EdgeInsets.all(
          16,
        ), //Padding gives space inside the edges.
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://picsum.photos/200'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Enter your name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            CheckboxListTile(
              title: const Text("Subscribed to Newsletter"),
              value: isSubscribed,
              onChanged: (val) {
                setState(() => isSubscribed = val!);
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: _showDialog,
              icon: const Icon(Icons.save),
              label: const Text("Save Profile"),
            ),

            const SizedBox(height: 10),
            GestureDetector(
              //listens for raw gestures like taps
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("You tapped the container!")),
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                color: Colors.blueAccent,
                child: const Text(
                  "Tap Me (GestureDetector)",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
