import 'package:flutter/material.dart';
import 'job_posts.dart'; // Import the global job posts list

class provider extends StatefulWidget {
  @override
  _providerState createState() => _providerState();
}

class _providerState extends State<provider> {
  void _showAddJobDialog() {
    // Capture the parent's context to later show the SnackBar
    final parentContext = context;
    // Create a GlobalKey for the form
    final _formKey = GlobalKey<FormState>();

    // Controllers for the text fields
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController workersController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header Title
                    Text(
                      "Add Your Job",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Job Title Field
                    TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(
                        labelText: "Job Title",
                        prefixIcon: Icon(Icons.title),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter the job title";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    // Job Description Field
                    TextFormField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                        labelText: "Job Description",
                        prefixIcon: Icon(Icons.description),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                      ),
                      maxLines: 3,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter the job description";
                        }
                        // Count the number of words in the description
                        final words = value.trim().split(RegExp(r'\s+'));
                        if (words.length < 10) {
                          return "Job description must have at least 10 words";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    // Number of Workers Field
                    TextFormField(
                      controller: workersController,
                      decoration: InputDecoration(
                        labelText: "Number of Workers",
                        prefixIcon: Icon(Icons.people),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter the number of workers";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 25),
                    // Action Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Cancel Button
                        TextButton(
                          onPressed: () {
                            Navigator.of(dialogContext).pop();
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        // Add Post Button
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // If validation passes, add the job post to the global list
                              setState(() {
                                globalJobPosts.add({
                                  "title": titleController.text,
                                  "description": descriptionController.text,
                                  "workers": workersController.text,
                                });
                              });
                              // Close the dialog
                              Navigator.of(dialogContext).pop();
                              // Show a SnackBar alert on the parent's scaffold
                              ScaffoldMessenger.of(parentContext).showSnackBar(
                                SnackBar(content: Text("Posted!")),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            "Add Post",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Daily Earn",
          style: TextStyle(fontFamily: 'Cursive', fontSize: 22),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Button to add a job post
            ElevatedButton(
              onPressed: _showAddJobDialog,
              child: Text("+ Add your work"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
            ),
            const SizedBox(height: 20),
            // Display job posts from the global list
            Expanded(
              child: globalJobPosts.isEmpty
                  ? Center(
                child: Text(
                  "No job posts yet.",
                  style: TextStyle(fontSize: 16),
                ),
              )
                  : ListView.builder(
                itemCount: globalJobPosts.length,
                itemBuilder: (context, index) {
                  final post = globalJobPosts[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(post["title"] ?? ""),
                      subtitle: Text(post["description"] ?? ""),
                      trailing: Text("Workers: ${post["workers"] ?? ""}"),
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
