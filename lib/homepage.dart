import 'package:flutter/material.dart';
import 'job_posts.dart'; // Import the global job posts list

class homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.description), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.blue,
              padding: EdgeInsets.all(20),
              alignment: Alignment.center,
              child: Text(
                'Daily Earn',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cursive',
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search your jobs',
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey[300],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            // Display job posts from the global list
            Expanded(
              child: globalJobPosts.isEmpty
                  ? Center(child: Text("No job posts yet."))
                  : ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: globalJobPosts.length,
                itemBuilder: (context, index) {
                  final post = globalJobPosts[index];
                  return InkWell(
                    onTap: () {
                      // When the card is tapped, show a dialog with the post details.
                      showDialog(
                        context: context,
                        builder: (BuildContext dialogContext) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  // Post Title
                                  Text(
                                    post["title"] ?? "",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  // Post Description
                                  Text(
                                    post["description"] ?? "",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  SizedBox(height: 10),
                                  // Number of Workers
                                  Text(
                                    "Workers: ${post["workers"] ?? ""}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  // Apply Button at the bottom of the box
                                  ElevatedButton(
                                    onPressed: () {
                                      // Action to perform on apply.
                                      // For example, close the dialog and show a message.
                                      Navigator.of(dialogContext).pop();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content:
                                        Text("Applied for the job!"),
                                      ));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size(
                                          double.infinity, 40), // Full width button
                                    ),
                                    child: Text("Apply"),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Card(
                      color: Colors.grey[300],
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              post["title"] ?? "",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(post["description"] ?? ""),
                            SizedBox(height: 10),
                            Text("Workers: ${post["workers"] ?? ""}"),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
