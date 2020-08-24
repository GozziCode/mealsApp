import 'package:bim/models/meals.dart';

import '../meal_item.dart';
import 'package:flutter/material.dart';

class CategoryMeal extends StatefulWidget {
  static const routeName = '/category_meals';
  final List<Meal> availableMeal;

  CategoryMeal(this.availableMeal);

  @override
  _CategoryMealState createState() => _CategoryMealState();
}

class _CategoryMealState extends State<CategoryMeal> {

  String categoryTitle;
  List<Meal> displayedMeal;

  @override
  void didChangeDependencies() {
     final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
     final categoryId = routeArgs['id'];
    categoryTitle = routeArgs['title'];
    displayedMeal = widget.availableMeal
        .where((meal) => meal.categoryId.contains(categoryId))
        .toList();
    super.didChangeDependencies();
  }
  

  // void _removeMeal(String mealId){
  //   setState(() {
  //     displayedMeal.removeWhere((meal) => meal.id == mealId);
  //   });
  // }
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
          itemBuilder: (context, index) {
            return MealItem(
                // removeItem: _removeMeal ,
                id: displayedMeal[index].id,
                affordability: displayedMeal[index].affordability,
                complexity: displayedMeal[index].complexity,
                title: displayedMeal[index].title,
                duration: displayedMeal[index].duration,
                imageUrl: displayedMeal[index].imageUrl,);
          },
          itemCount: displayedMeal.length,
        ),
    );
  }
}
