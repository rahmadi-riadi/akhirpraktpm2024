import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ta_tpm/halaman/list_chara_screen.dart';
import 'halaman/login_screen.dart';
import 'model_hive/datauser_model.dart';

void main() async {
  initiateLocalDB();
  runApp(const MyApp());
}

void initiateLocalDB() async {
  await Hive.initFlutter();
  Hive.registerAdapter(DataUserModelAdapter());
  await Hive.openBox<DataUserModel>('data_user');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Proyek Akhir Prak TPM',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
