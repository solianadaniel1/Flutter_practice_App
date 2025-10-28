import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GalleryScreen extends StatelessWidget {
  final List<String> images = List.generate(6, (index) => 'https://picsum.photos/200?image=$index');

  @override
  Widget build(BuildContext context) {
    return DefaultTabController( //provides simple tab behavior (switching between tabs)
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Gallery Screen"),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.list), text: "ListView"),
              Tab(icon: Icon(Icons.grid_on), text: "GridView"),
            ],
          ),
        ),
        body: TabBarView( //holds the content for each tab
          children: [
            ListView.builder(
              itemCount: images.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: Image.network(images[index]),
                    title: Text("Image $index"),
                    subtitle: const Text("A random image from the web"),
                  ),
                );
              },
            ),
            GridView.count(
              crossAxisCount: 2,
              children: images.map((url) {
                return Card(
                  child: Image.network(url, fit: BoxFit.fitHeight),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}