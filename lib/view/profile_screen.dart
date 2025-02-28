import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  "https://w7.pngwing.com/pngs/340/946/png-transparent-avatar-user-computer-icons-software-developer-avatar-child-face-heroes-thumbnail.png",
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Name: Harshal',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Email: harshal12@gmail.com',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 20),
            Divider(),
            Text(
              'Order History',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Replace with actual order count
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.book),
                    title: Text('Book Order #${index + 1}'),
                    subtitle: Text('Order placed on 12 Feb 2025'),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // Navigate to order details
                    },
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
