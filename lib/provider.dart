import 'package:flutter/material.dart';
import 'homepage.dart';
import 'job_posts.dart'; // Import the global job posts list

class ProviderPage extends StatefulWidget {
  @override
  _ProviderPageState createState() => _ProviderPageState();
}

class _ProviderPageState extends State<ProviderPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _workersController = TextEditingController();
  final TextEditingController _wagesController = TextEditingController();

  void _addJob() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(
            "Add New Job",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: "Job Title",
                  prefixIcon: Icon(Icons.work),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: "Job Description",
                  prefixIcon: Icon(Icons.description),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _workersController,
                decoration: InputDecoration(
                  labelText: "Workers Needed",
                  prefixIcon: Icon(Icons.people),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextField(
                controller: _wagesController,
                decoration: InputDecoration(
                  labelText: "Wages (per day/hour)",
                  prefixIcon: Icon(Icons.attach_money),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext); // Close dialog
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (_titleController.text.isNotEmpty &&
                    _descriptionController.text.isNotEmpty &&
                    _workersController.text.isNotEmpty &&
                    _wagesController.text.isNotEmpty) {

                  setState(() {
                    globalJobPosts.add({
                      "title": _titleController.text,
                      "description": _descriptionController.text,
                      "workers": _workersController.text,
                      "wages": _wagesController.text,
                    });
                  });

                  // Clear fields after adding
                  _titleController.clear();
                  _descriptionController.clear();
                  _workersController.clear();
                  _wagesController.clear();

                  Navigator.pop(dialogContext); // Close dialog
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Job Added Successfully!")),
                  );
                }
              },
              child: Text("Add Job"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Job Provider"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            ElevatedButton.icon(
              onPressed: _addJob,
              icon: Icon(Icons.add),
              label: Text("Add Job"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: globalJobPosts.length,
                itemBuilder: (context, index) {
                  final post = globalJobPosts[index];
                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post["title"] ?? "",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Text(
                            post["description"] ?? "",
                            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(Icons.people, color: Colors.blue),
                              SizedBox(width: 5),
                              Text("Workers: ${post["workers"] ?? ""}"),
                              SizedBox(width: 15),
                              Icon(Icons.attach_money, color: Colors.green),
                              SizedBox(width: 5),
                              Text("Wages: ${post["wages"] ?? ""}"),
                            ],
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Applicants for ${post["title"]}"),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: jobApplications[index]?.map((applicant) {
                                        return Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(applicant),
                                            Row(
                                              children: [
                                                IconButton(
                                                  icon: Icon(Icons.check, color: Colors.green),
                                                  onPressed: () {
                                                    setState(() {
                                                      acceptedApplicants[index] ??= [];
                                                      acceptedApplicants[index]!.add(applicant);
                                                    });

                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(content: Text("Accepted $applicant")),
                                                    );
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                IconButton(
                                                  icon: Icon(Icons.close, color: Colors.red),
                                                  onPressed: () {
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(content: Text("Declined $applicant")),
                                                    );
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                            )
                                          ],
                                        );
                                      }).toList() ??
                                          [Text("No applicants yet")],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Text("View Applicants"),
                          ),
                        ],
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
