import 'package:flutter/material.dart';
import 'package:flutterbrewapp/models/user.dart';
import 'package:flutterbrewapp/screens/authenticate.dart';
import 'package:flutterbrewapp/screens/home.dart';
import 'package:provider/provider.dart';


class WrapperScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return user == null ? AuthenticateScreen() : HomeScreen();
  }
}
