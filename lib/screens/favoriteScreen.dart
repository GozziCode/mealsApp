import '../meal_item.dart';
import '../models/meals.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  final List<Meal> favorite;

  FavoriteScreen(this.favorite);
  @override
  Widget build(BuildContext context) {
    if(favorite.isEmpty){
       return Center(
      child: Text('You have no favorite yet try adding some!'),   
    );
    }
   else{
     return
     ListView.builder(
          itemBuilder: (context, index) {
            return MealItem(
                // removeItem: _removeMeal ,
                id: favorite[index].id,
                affordability: favorite[index].affordability,
                complexity: favorite[index].complexity,
                title: favorite[index].title,
                duration: favorite[index].duration,
                imageUrl: favorite[index].imageUrl,);
          },
          itemCount: favorite.length,
        );
   }
  }
}