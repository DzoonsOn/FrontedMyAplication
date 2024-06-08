import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/user_cubid.dart';
import '../../models/user_model.dart';
import 'SchedulePage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    User user = context.read<UserCubit>().state;

    return Scaffold(
      appBar: AppBar(
        title: Text("Home of ${user.username}"),
      ),
      body: Container(
        padding: EdgeInsets.all(10), // Reduced padding
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              color: Colors.blue[100], // Changed color for better readability
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12), // Reduced content padding
                title: Text("KCK", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)), // Font size slightly adjusted
                subtitle: Text("10:15 - 11:45", style: TextStyle(color: Colors.black87, fontSize: 16)), // Font size slightly adjusted
              ),
            ),
            SizedBox(height: 8), // Reduced spacing
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              color: Colors.blue[100], // Changed color for better readability
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12), // Reduced content padding
                title: Text("Kolokwium z baz", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)), // Font size slightly adjusted
                subtitle: Text("12:15 - 13:45", style: TextStyle(color: Colors.black87, fontSize: 16)), // Font size slightly adjusted
              ),
            ),
            SizedBox(height: 8), // Reduced spacing
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              color: Colors.blue[100], // Changed color for better readability
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12), // Reduced content padding
                title: Text("SW", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)), // Font size slightly adjusted
                subtitle: Text("16:15 - 19:00", style: TextStyle(color: Colors.black87, fontSize: 16)), // Font size slightly adjusted
              ),
            ),
            SizedBox(height: 8), // Reduced spacing
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              color: Colors.blue[100], // Changed color for better readability
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12), // Reduced content padding
                title: Text("Trenning", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)), // Font size slightly adjusted
                subtitle: Text("19:30 - 20:00", style: TextStyle(color: Colors.black87, fontSize: 16)), // Font size slightly adjusted
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.event_note),
            label: 'Wydarzenia',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Plan zajęć',
          ),
        ],
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SchedulePage()),
            );
          }
        },
      ),
    );
  }
}
