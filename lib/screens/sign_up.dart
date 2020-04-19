import 'package:flutter/material.dart';
import 'package:flutterbrewapp/services/auth.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();


  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign up')),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Email',
                  ),
                  validator: (value) => value.isEmpty ? "Field is empty!" : null,
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Password'),
                  obscureText: true,
                  validator: (value) => value.isEmpty ? "Field is empty!" : null,
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                ),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.redAccent,
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text('Sign Up'),
                      ),
                    ),
                  ),
                  onTap: () async{
                    if(_formKey.currentState.validate()){
                     dynamic result = await _auth.signUpWithEmailAndPassword(email, password);
                     Navigator.pop(context);
                     if(result == null){
                       print('ERROR');
                     }
                    }
                  },
                ),
              ],
            ),
          )),
    );
  }
}
