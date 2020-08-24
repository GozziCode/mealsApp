import 'package:bim/screens/filters_screen.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
 
  Widget buildListTile(String title, IconData icon, Function onTapHandler) =>
      ListTile(
        leading: Icon(
          icon,
          size: 20,
        ),
        title: Text(
          title,
          style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              fontFamily: 'RobotoCondensed'),
        ),
        onTap: onTapHandler,
      );

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            color: Theme.of(context).accentColor,
            alignment: Alignment.centerLeft,
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            child: Text(
              'Cooking Up',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildListTile('Meals', Icons.restaurant,
           () {
             //homepage nevigation
             Navigator.of(context).pushReplacementNamed('/');
          }),
          buildListTile('Filters',
           Icons.settings,
           (){
             Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
           }),
        ],
      ),
    );
  }
}
