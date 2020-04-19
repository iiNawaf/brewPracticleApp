import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutterbrewapp/models/brew.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>>(context);
    return brews == null
        ? Center(
            child: SpinKitDualRing(
            color: Colors.red,
          ))
        : ListView.builder(
            itemCount: brews.length,
            itemBuilder: (_, int index) {
              return Card(
                child: ListTile(
                  title: Text('${brews[index].name}'),
                  subtitle: Text('${brews[index].email}'),
                  trailing: Text('sugars: ' + '${brews[index].sugars}'),
                ),
              );
            });
  }
}
