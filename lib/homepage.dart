import 'package:flutter/material.dart';
import 'job_posts.dart';

// Track job applications
Map<int, List<String>> jobApplications = {};
Map<int, List<String>> acceptedApplicants = {}; // Track accepted users

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.description), label: 'Jobs'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          // Navigate to job posting page (if needed)
        },
      ),
      body: SafeArea(
        child: Column(
          children: [
            // App title
            Container(
              color: Colors.blue,
              padding: EdgeInsets.all(20),
              alignment: Alignment.center,
              child: const Text(
                'Daily Earn',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cursive',
                  color: Colors.white,
                ),
              ),
            ),
            // Search bar
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search for jobs...',
                  prefixIcon: Icon(Icons.search, color: Colors.blue),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            // Job List
            Expanded(
              child: globalJobPosts.isEmpty
                  ? Center(child: Text("No job posts available."))
                  : ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: globalJobPosts.length,
                itemBuilder: (context, index) {
                  final post = globalJobPosts[index];
                  bool isAccepted =
                      acceptedApplicants[index]?.contains("User123") ?? false; // Example user

                  return InkWell(
                    onTap: () {
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    post["title"] ?? "",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    post["description"] ?? "",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Icon(Icons.people, color: Colors.blue),
                                      SizedBox(width: 5),
                                      Text(
                                        "Workers: ${post["workers"] ?? ""}",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Icon(Icons.attach_money, color: Colors.green),
                                      SizedBox(width: 5),
                                      Text(
                                        "Wage: ${post["wage"] ?? "Not specified"}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  isAccepted
                                      ? Text(
                                    "You have been accepted for this job!",
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                      : ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        jobApplications[index] ??= [];
                                        jobApplications[index]!.add("User123"); // Example user
                                      });
                                      Navigator.of(dialogContext).pop();
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text("Applied for the job!"),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size(double.infinity, 40),
                                      backgroundColor: Colors.blue,
                                      foregroundColor: Colors.white,
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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 3,
                      color: Colors.white,
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
                                color: Colors.blue[800],
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              post["description"] ?? "",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Icons.people, color: Colors.blue),
                                SizedBox(width: 5),
                                Text(
                                  "Workers: ${post["workers"] ?? ""}",
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Icon(Icons.attach_money, color: Colors.green),
                                SizedBox(width: 5),
                                Text(
                                  "Wage: ${post["wage"] ?? "Not specified"}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
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
