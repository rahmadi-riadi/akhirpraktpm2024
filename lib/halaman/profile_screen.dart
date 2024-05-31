import 'package:flutter/material.dart';
import 'list_chara_screen.dart';
import 'login_screen.dart';
import 'main_screen.dart';

const accessoriesColor = Color(0xffeab56f);
const backgroundColor = Color(0xff254252);

class ProfileScreen extends StatefulWidget {

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  // BOTTOM NAVBAR CONDITION
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (_selectedIndex == 0) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (BuildContext context) => MainScreen())
      );
    }
    if (_selectedIndex == 1) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (BuildContext context) => ProfileScreen())
      );
    }
  }
  // END OF BOTTOM NAVBAR CONDITION

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: accessoriesColor,
        title: Text(
            "Profil",
            style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Halo User, Selamat Datang!",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 450,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Logout'),
                        content: Text('Apakah anda yakin ingin keluar?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Close the dialog
                            },
                            child: Text('Tidak'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Close the dialog
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
                              );

                              String message = "Anda telah keluar.";
                              final snackBar = SnackBar(
                                content: Text(
                                  message,
                                  style: TextStyle(color: Colors.white),
                                ),
                                backgroundColor: Colors.red,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            },
                            child: Text('Ya'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text("Logout", style: TextStyle(fontSize: 17)),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 22),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  primary: Color(0xFFF3093B),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: accessoriesColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
            backgroundColor: accessoriesColor,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: accessoriesColor,
        onTap: _onItemTapped,
      ),
    );
  }
}