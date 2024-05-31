import 'package:flutter/material.dart';

import 'main_screen.dart';
import 'profile_screen.dart';

const accessoriesColor = Color(0xffeab56f);
const backgroundColor = Color(0xff254252);

class Sinopsis extends StatefulWidget {
  const Sinopsis({Key? key}) : super(key: key);

  @override
  _SinopsisState createState() => _SinopsisState();
}

class _SinopsisState extends State<Sinopsis> {

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
          "Sinopsis",
          style: TextStyle(
            color: Colors.white
          ),
        ),
        backgroundColor: accessoriesColor,
        centerTitle: true
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              "https://m.media-amazon.com/images/M/MV5BZjRjOTFkOTktZWUzMi00YzMyLThkMmYtMjEwNmQyNzliYTNmXkEyXkFqcGdeQXVyNzQ1ODk3MTQ@._V1_.jpg",
              height: 400,
            ),
            SizedBox(height: 30),
            Text(
              "Ricky & Morty",
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 15),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                "Serial ini berkisah tentang sosok ilmuwan jenius sosiopat yang mengajak cucu pemalunya dalam petualangan sangat berbahaya mengelilingi alam semesta. Rick Sanchez tinggal bersama keluarga Beth, puterinya dan terus-menerus mengajak dia, menantunya Jerry, cucunya Summer, dan Morty dalam petualangan antar galaksi.",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Pembuat : Justin Rolland, Dan Harmon",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Penulis Naskah : Justin Rollan, Dan Harmon, Jessica Gao",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Episode Pertama : 2 Desember 2013",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Jumlah Musim : 6",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Jumlah Episode : 61",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ],
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
