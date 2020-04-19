import 'package:flutter/material.dart';
import 'package:flutterbrewapp/screens/loading.dart';
import 'package:flutterbrewapp/screens/sign_up.dart';
import 'package:flutterbrewapp/services/auth.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return isLoading ? Loading() : Scaffold(
      appBar: AppBar(title: Text('Sign in')),
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
                        child: Text('Sign in'),
                      ),
                    ),
                  ),
                  onTap: () async{
                    if(_formKey.currentState.validate()){
                      setState(() {
                        isLoading = true;
                      });
                      dynamic result = _auth.signInWithEmailAndPassword(email, password);
                      if(result == null){
                        setState(() {
                          isLoading = false;
                        });
                        print('ERROR');
                      }
                    }
                  },
                ),









                RaisedButton(
                  child: Text('Sign in Anonymously'),
                  onPressed: () async {
                    dynamic result = await _auth.signInAnon();
                    if (result == null) {
                      print('Cannot sign in');
                    } else {
                      print('Signed in successfully');
                      print(result.uid);
                    }
                  },
                ),

                FlatButton(
                  child: Text('Sign Up'),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                  },
                )
              ],
            ),
          )),
    );
  }
}
