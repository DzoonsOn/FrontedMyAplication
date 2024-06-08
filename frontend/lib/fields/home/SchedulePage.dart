import 'package:flutter/material.dart';
import 'home_page.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plan zajęć', style: TextStyle(fontFamily: 'Montserrat')),
        backgroundColor: Color(0xFF49D3F2),
      ),
      body: ListView(
        children: [
          buildEventTile(context, 'Dni Wydziału EEIA', '8:15 - 21:00 WEEIA', 'Detailed information about Dni Wydziału EEIA.'),
          buildEventTile(context, 'Webinar jak stworzyć profesjonalne CV', '16:15 - 19:00 Biuro Karier', 'Learn to create a professional CV in this comprehensive webinar.'),
          buildEventTile(context, 'Akademickie Targi Pracy', '10:00 - 16:00 Hala Expo', 'Join us at the Academic Job Fair to explore career opportunities.'),
        ],
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
        currentIndex: 1, // Set the current index to 1 for SchedulePage
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          } else if (index == 1) {
            // Do nothing because we're already on the SchedulePage
          }
        },
      ),
    );
  }

  Widget buildEventTile(BuildContext context, String title, String time, String description) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Color(0xFF49D3F2),
        child: ListTile(
          contentPadding: EdgeInsets.all(12.0),
          title: Text(
            title,
            style: TextStyle(
              fontFamily: 'Montserrat',
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20, // Increased font size
            ),
          ),
          subtitle: Text(
            time,
            style: TextStyle(
              fontFamily: 'Montserrat',
              color: Colors.grey[300],
              fontSize: 18,
            ),
          ),
          onTap: () => showEventDetailDialog(context, title, description),
        ),
      ),
    );
  }

  void showEventDetailDialog(BuildContext context, String title, String description) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Text(
              description,
              style: TextStyle(fontSize: 20),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Close',
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
