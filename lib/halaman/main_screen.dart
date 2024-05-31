import 'package:flutter/material.dart';
import 'package:ta_tpm/halaman/list_chara_screen.dart';
import 'package:ta_tpm/halaman/synopsis_screen.dart';

import 'profile_screen.dart';

const accessoriesColor = Color(0xffeab56f);
const backgroundColor = Color(0xff254252);

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  // BOTTOM NAVBAR CONDITION
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (_selectedIndex == 0) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (BuildContext context) => MainScreen()));
    }
    if (_selectedIndex == 1) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (BuildContext context) => ProfileScreen()));
    }
  }
  // END OF BOTTOM NAVBAR CONDITION

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Rick & Morty",
          style: TextStyle(
            color: Colors.white
          ),
        ),
        backgroundColor: accessoriesColor,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Image.network(
            "https://m.media-amazon.com/images/M/MV5BZjRjOTFkOTktZWUzMi00YzMyLThkMmYtMjEwNmQyNzliYTNmXkEyXkFqcGdeQXVyNzQ1ODk3MTQ@._V1_.jpg",
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Container(
            color: Colors.black.withOpacity(0.6), // Ubah nilai opacity sesuai keinginan
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: accessoriesColor,
                    width: MediaQuery.of(context).size.width / 4,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Sinopsis()),
                        );
                      },
                      child: Text(
                        "Sinopsis",
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: accessoriesColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: accessoriesColor,
                    width: MediaQuery.of(context).size.width / 4,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ListChara()),
                        );
                      },
                      child: Text(
                        "List Karakter",
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: accessoriesColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
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
            label: 'Profile',
            backgroundColor: accessoriesColor,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: accessoriesColor,
        onTap: _onItemTapped,
      ),
      backgroundColor: backgroundColor,
    );
  }
}