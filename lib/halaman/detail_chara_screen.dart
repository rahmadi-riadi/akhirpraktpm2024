import 'package:flutter/material.dart';
import 'package:ta_tpm/http_request/character_model.dart';
import 'package:ta_tpm/http_request/api_data_source.dart';

import 'main_screen.dart';
import 'profile_screen.dart';

const accessoriesColor = Color(0xffeab56f);
const backgroundColor = Color(0xff254252);

class DetailChara extends StatefulWidget {
  final id;
  DetailChara({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailChara> createState() => _DetailCharaState();
}

class _DetailCharaState extends State<DetailChara> {

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
          "Detail Karakter",
          style: TextStyle(
              color: Colors.white
          ),
        ),
        backgroundColor: accessoriesColor,
      ),
      body: _buildDetailCharaBody(),
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

  Widget _buildDetailCharaBody() {
    return Container(
      color: backgroundColor,
      height: MediaQuery.of(context).size.height,
      child: FutureBuilder(
        future: ApiDataSource.instance.loadCharacter(),
        builder: (BuildContext context,
            AsyncSnapshot<dynamic> snapshot,) {
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            ListCharacterModel listCharacterModel = ListCharacterModel
                .fromJson(snapshot.data);
            return _buildSuccessSection(listCharacterModel);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(ListCharacterModel data) {
    return _buildCharaDetail (
        data.results![widget.id-1].name,
        data.results![widget.id-1].status,
        data.results![widget.id-1].species,
        data.results![widget.id-1].gender,
        data.results![widget.id-1].image
    );
  }

  Widget _buildCharaDetail(
      String? charaName,
      String? charaStatus,
      String? charaSpecies,
      String? charaGender,
      String? charaImage) {
    return Scaffold(
        body: Center(
            child: Container(
              color: backgroundColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      height: 350,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 320,
                            height: 320,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: accessoriesColor,
                            ),
                            child: Container(
                              width: 300,
                              height: 300,
                              child: Image.network(charaImage!),
                            ),
                          ),
                        ],
                      )
                    ),
                    Text(
                      "Nama: " + charaName!,
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    Text(
                      "Status: " + charaStatus!,
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    Text(
                      "Spesies: " + charaSpecies!,
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    Text(
                      "Gender: " + charaGender!,
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ],
                )
            )
        )
    );
  }
}
