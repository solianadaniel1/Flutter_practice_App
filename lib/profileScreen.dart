import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isSubscribed = false;
  TextEditingController nameController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    nameController.text = "Soliana";
  }

  @override
  void dispose() {
    nameController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Profile Updated!"),
        content: const Text("Your changes have been saved."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK"))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile Screen")),
      body: SingleChildScrollView(
        controller: scrollController,
        padding: const EdgeInsets.all(16),
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
