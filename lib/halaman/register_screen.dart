import 'package:flutter/material.dart';
import 'package:ta_tpm/hive/hive_database.dart';
import 'package:ta_tpm/model_hive/datauser_model.dart';

const accessoriesColor = Color(0xffeab56f);
const backgroundColor = Color(0xff254252);

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _password1Controller = TextEditingController();
  final TextEditingController _password2Controller = TextEditingController();
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: accessoriesColor,
        title: const Text("Register"),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: "Username",
                  ),
                ),
                TextFormField(
                  controller: _password1Controller,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: "Password",
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                  obscureText: !_passwordVisible, // Toggle password visibility
                ),
                TextFormField(
                  controller: _password2Controller,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: "Ulangi Password",
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                  obscureText: !_passwordVisible,
                ),
                SizedBox(height: 20.0),
                _buildRegisterButton(),
                SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _commonSubmitButton({
    required String labelButton,
    required Function(String) submitCallback,
  }) {
    return Container(
      child: ElevatedButton(
        child: Text(labelButton),
        onPressed: () {
          submitCallback(labelButton);
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 22),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          primary: accessoriesColor
        ),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return _commonSubmitButton(
      labelButton: "Register",
      submitCallback: (value) {
        String currentUsername = _usernameController.value.text;
        String currentPassword1 = _password1Controller.value.text;
        String currentPassword2 = _password2Controller.value.text;

        _processRegister(currentUsername, currentPassword1, currentPassword2);
      },
    );
  }

  void _processRegister(String username, String password1, String password2) async {
    final HiveDatabase _hive = HiveDatabase();
    String message = "";

    if (_usernameController.text.isNotEmpty &&
        _password1Controller.text.isNotEmpty &&
        _password2Controller.text.isNotEmpty) {
      if (_password1Controller.text == _password2Controller.text){
        _hive.addData(DataUserModel(
            username: _usernameController.text,
            password: _password2Controller.text)
        );
        _usernameController.clear();
        _password1Controller.clear();
        _password2Controller.clear();
        setState(() {});

        message = "Berhasil mendaftarkan akun.";

        final snackBar = SnackBar(
          content: Text(
            message,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        Navigator.pop(context);
      }
      else{
        message = "Password harus sama.";

        final snackBar = SnackBar(
          content: Text(
            message,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
    else{
      message = "Lengkapi data terlebih dahulu.";

      final snackBar = SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

}