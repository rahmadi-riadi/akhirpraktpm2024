import 'package:flutter/material.dart';
import 'package:ta_tpm/http_request/character_model.dart';
import 'package:ta_tpm/http_request/api_data_source.dart';

import 'detail_chara_screen.dart';
import 'main_screen.dart';
import 'profile_screen.dart';

const accessoriesColor = Color(0xffeab56f);
const backgroundColor = Color(0xff254252);

class ListChara extends StatefulWidget {
  const ListChara({Key? key}) : super(key: key);

  @override
  _ListCharaState createState() => _ListCharaState();
}

class _ListCharaState extends State<ListChara> {
  String _searchQuery = '';

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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          backgroundColor: accessoriesColor,
          title: TextField(
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Search...',
              hintStyle: TextStyle(color: Colors.black54),
            ),
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
      ),
      body: _buildListCharaBody(),
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
    );
  }

  Widget _buildListCharaBody() {
    return Container(
      color: backgroundColor,
      child: FutureBuilder(
        future: ApiDataSource.instance.loadCharacter(),
        builder: (
            BuildContext context,
            AsyncSnapshot<dynamic> snapshot,
            ) {
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            ListCharacterModel listCharacterModel =
            ListCharacterModel.fromJson(snapshot.data);
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
    List<Results> filteredList = data.results!
        .where((charaResults) =>
        charaResults.name!.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filteredList.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildItemChara(filteredList[index], context);
      },
    );
  }

  Widget _buildItemChara(Results charaResults, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: InkWell(
        child: Card(
          color: accessoriesColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                width: 90,
                height: 90,
                child: Image.network(charaResults.image!),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    charaResults.name!,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Text(
                    charaResults.species!,
                    style: TextStyle(color: Colors.white),
                  )
                ],
              )
            ],
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailChara(id: charaResults.id!),
            ),
          );
        },
      ),
    );
  }
}
