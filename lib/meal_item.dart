import 'package:flutter/cupertino.dart';

import './models/meals.dart';
import 'package:flutter/material.dart';

import './screens/meal_detailsScreen.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;


  MealItem(
      {@required this.id,
      @required this.affordability,
      @required this.complexity,
      @required this.title,
      @required this.duration,
      @required this.imageUrl,
      });

   String get complexityText {
     switch (complexity){
       case Complexity.simple:
         return 'Simple';
         break;
       case Complexity.hard:
         return 'Hard';
         break;
       case Complexity.challenging:
         return 'Challenging ';
         break;
         default:
           return 'Unknown';
     }
   }

  String get affordabilityText {
    switch (affordability){
      case Affordability.pricey :
        return 'Pricey';
        break;
      case Affordability.Luxury:
        return 'Luxurious';
        break;
      case Affordability.Affordable:
        return 'Affordable ';
        break;
      default:
        return 'Unknown';
    }
  }

  void selectMeal(BuildContext context){
    Navigator.of(context).pushNamed(MealDetailsScreen.routeName, arguments: id).then((result){
      if(result != null){
        // removeItem(result);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                  ),
                  child: Image.network(
                    imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                // fpr positioning widget
                Positioned(
                  bottom: 20,
                  right: 10,
                  child: Container(
                    width: 220,
                    color: Colors.black54,
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                    child: Text(
                      title,
                      style: TextStyle(fontSize: 26, color: Colors.white),
                      overflow: TextOverflow.fade,
                      softWrap: true,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.schedule),
                      SizedBox(height: 6,),
                      Text('$duration Min')
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.work),
                      SizedBox(height: 6,),
                      Text(complexityText)
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.attach_money),
                      SizedBox(height: 6,),
                      Text(affordabilityText)
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
