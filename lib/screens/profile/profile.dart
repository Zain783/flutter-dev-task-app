import 'package:flutter/material.dart';
import 'package:my_test_app/providers/themeProvider.dart';
import 'package:my_test_app/providers/userProvider.dart';
import 'package:my_test_app/resources/auth_methords.dart';
import 'package:my_test_app/screens/auth_screens/auth_screen.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkModeEnabled =
        themeProvider.themeData.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CircleAvatar(
                radius: 80,
                // backgroundImage: AssetImage('assets/images/profile_image.jpg'),
              ),
            ),
            const SizedBox(height: 16),
            Consumer<UserProvider>(
              builder: (context, value, child) {
                return Text(
                  value.user!.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            Text(
              'Software Developer',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'About Me',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Contact',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Consumer<UserProvider>(
              builder: (context, value, child) {
                return ListTile(
                  leading: Icon(Icons.email),
                  title: Text(value.user!.email),
                );
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                // Handle logout button press
                final auth = AuthMethods();
                await auth.signOut();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AuthenticationScreen(),
                    ));
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                onPrimary: Colors.white,
              ),
              child: const Text('Logout'),
            ),
            Switch(
              value: isDarkModeEnabled,
              onChanged: (value) {
                themeProvider.toggleTheme(value);
              },
            ),
            isDarkModeEnabled
                ? Text("Enable Light Mode")
                : Text("Enable Dark Mode")
          ],
        ),
      ),
    );
  }
}
