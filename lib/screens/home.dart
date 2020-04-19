import 'package:flutter/material.dart';
import 'package:flutterbrewapp/models/brew.dart';
import 'package:flutterbrewapp/screens/brew_list.dart';
import 'package:flutterbrewapp/services/auth.dart';
import 'package:flutterbrewapp/services/database.dart';
import 'package:flutterbrewapp/widgets/settings_form.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel(){
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context){
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: SettingsForm()
            );
          }
      );
    }
    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        appBar: AppBar(
            title: Text('Home'),
            leading: FlatButton(
              child: Icon(Icons.exit_to_app),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () => _showSettingsPanel(),
                icon: Icon(Icons.settings),
                label: Text('Settings')
            )
          ],
        ),
        body: BrewList()
      ),
    );
  }
}
