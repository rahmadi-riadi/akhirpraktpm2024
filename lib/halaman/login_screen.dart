import 'package:flutter/material.dart';
import 'package:ta_tpm/halaman/register_screen.dart';
import 'package:ta_tpm/hive/hive_database.dart';
import 'main_screen.dart';

const accessoriesColor = Color(0xffeab56f);
const backgroundColor = Color(0xff254252);

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: accessoriesColor,
        title: const Text("Login"),
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
                  validator: (value) =>
                  value!.isEmpty ? 'Username tidak boleh kosong.' : null,
                ),
                TextFormField(
                  controller: _passwordController,
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
                  obscureText: !_passwordVisible,
                ),
                SizedBox(height: 20.0),
                _buildLoginButton(),
                SizedBox(height: 20.0),
                const Text('Belum memiliki akun?'),
                TextButton(
                  onPressed: () {
                    _usernameController.clear();
                    _passwordController.clear();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  child: Text(
                      'Register',
                      style: TextStyle(
                      color: accessoriesColor,
                    ),
                  ),
                ),
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
          primary: accessoriesColor,
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return _commonSubmitButton(
      labelButton: "Login",
      submitCallback: (value) {
        String currentUsername = _usernameController.value.text;
        String currentPassword = _passwordController.value.text;

        _processLogin(currentUsername, currentPassword);
      },
    );
  }

  void _processLogin(String username, String password) async {
    final HiveDatabase _hive = HiveDatabase();
    bool found = false;

    found = _hive.checkLogin(username, password);
    String message = "";

    if (_usernameController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      if (found){
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => MainScreen(),
          ),
        );
      }
      else{
        message = "Username atau Password salah.";

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
      message = "Username atau Password tidak boleh kosong.";

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