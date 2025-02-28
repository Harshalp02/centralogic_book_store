import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  final List<String> categories = [
    "Fiction",
    "Non-Fiction",
    "Science",
    "History",
    "Technology",
    "Children's Books",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Categories'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 2,
              margin: EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: Icon(
                  Icons.category,
                  color: Color.fromRGBO(74, 138, 196, 1),
                ),
                title: Text(categories[index]),
                onTap: () {
                  // Navigate to books filtered by this category
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
