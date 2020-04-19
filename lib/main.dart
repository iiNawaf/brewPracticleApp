import 'package:flutter/material.dart';
import 'package:flutterbrewapp/models/user.dart';
import 'package:flutterbrewapp/screens/wrapper.dart';
import 'package:flutterbrewapp/services/auth.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.red,
          appBarTheme: AppBarTheme(
            color: Colors.brown[400],
            elevation: 0.0,
          )
        ),
        home: WrapperScreen(),
      ),
    );
  }
}
