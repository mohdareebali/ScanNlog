import 'package:flutter/material.dart';
import 'edit_profile_screen.dart';
import 'approved_forms_page.dart';
import 'forms_to_review_page.dart';

class ManagerDashboard extends StatefulWidget {
  const ManagerDashboard({super.key}); // ✅ Fixed warning with super parameter

  @override
  State<ManagerDashboard> createState() => _ManagerDashboardState();
}

class _ManagerDashboardState extends State<ManagerDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> notifications = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1c3a63),
        title: const Text(
          "Manager Dashboard",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications,
              color: Color(0xFFFFD700), // Golden color
            ),
            onPressed: () {
              if (notifications.isNotEmpty) {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Notifications'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: notifications.map((note) => Text(note)).toList(),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("No new notifications")),
                );
              }
            },
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF1c3a63)),
              child: Text(
                "Manager Profile",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Color(0xFF1c3a63)),
              title: const Text('Edit Profile'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EditProfileScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.check_circle, color: Color(0xFF1c3a63)),
              title: const Text('Approved Forms'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ApprovedFormsPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.assignment_late, color: Color(0xFF1c3a63)),
              title: const Text('Forms to Review'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FormsToReviewPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20).copyWith(top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome, Manager!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1c3a63),
              ),
            ),
            const SizedBox(height: 20),
            buildCardTile(
              icon: Icons.check_circle,
              title: 'Approved Forms',
              subtitle: 'View all finalized and accepted forms.',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ApprovedFormsPage()),
              ),
            ),
            buildCardTile(
              icon: Icons.assignment_late,
              title: 'Forms to Review',
              subtitle: 'Review forms submitted for approval.',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FormsToReviewPage()),
              ),
            ),
            buildCardTile(
              icon: Icons.person,
              title: 'Edit Profile',
              subtitle: 'Update manager account details.',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditProfileScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCardTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        leading: Icon(icon, color: const Color(0xFF1c3a63), size: 28),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}
