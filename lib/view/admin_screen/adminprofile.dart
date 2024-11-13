import 'package:bookinghotel/model/app_constants.dart';
import 'package:bookinghotel/view/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// Import your LoginScreen here

class AdminProfile extends StatefulWidget {
  const AdminProfile({super.key});

  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  // Method to fetch user data from Firestore
  Future<DocumentSnapshot> _getUserData() async {
    String? userId = AppConstants.currentUser.id; // Get the current user ID
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Profile"),
        backgroundColor: Colors.green, // Customizing app bar color
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: _getUserData(),
        builder: (context, snapshot) {
          // Show loading indicator while waiting for data
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Handle errors
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          // Check if document exists or if there's no data
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text("User data not found"));
          }

          // Extracting user data from Firestore snapshot
          var userData = snapshot.data!;
          var firstName = userData['firstName'] ?? 'N/A';
          var lastName = userData['lastName'] ?? 'N/A';
          var email = userData['email'] ?? 'N/A';
          var city = userData['city'] ?? 'N/A';
          var country = userData['country'] ?? 'N/A';
          var bio = userData['bio'] ?? 'No bio available';

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile picture (optional placeholder here)
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.green,
                  child:
                      const Icon(Icons.person, size: 50, color: Colors.white),
                ),
                const SizedBox(height: 20),

                // Display user information
                Text(
                  'Name: $firstName $lastName',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text('Email: $email', style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                Text('City: $city', style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                Text('Country: $country', style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                Text('Bio: $bio', style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 20),

                // Logout button
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {
                      // Logout action: navigate to LoginScreen
                      // You might want to clear user session data if you're using any
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red, // Button color
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Logout',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
