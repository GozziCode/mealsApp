import '../dummy_data.dart';
import 'package:flutter/material.dart';

class MealDetailsScreen extends StatelessWidget {
  static const routeName = '/meal-details';
  final Function toggleFavorite;
   final Function isFavorite;

  MealDetailsScreen(this.toggleFavorite, this.isFavorite);


  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scrWidth = MediaQuery.of(context).size.width;
    final scrHeight = MediaQuery.of(context).size.height;
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text("${selectedMeal.title}"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, 'Ingredient'),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              height: scrHeight * .15,
              width: scrWidth * .7,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20)),
              child: ListView.builder(
                itemCount: selectedMeal.ingredients.length,
                itemBuilder: (ctx, index) => Card(
                  color: Theme.of(context).accentColor,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Text(selectedMeal.ingredients[index]),
                  ),
                ),
              ),
            ),
            buildSectionTitle(context, 'Steps'),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              height: scrHeight * .30,
              width: scrWidth * .90,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20)),
              child: ListView.builder(
                itemCount: selectedMeal.steps.length,
                itemBuilder: (cxt, index) => Column(
                  children: <Widget>[
                    ListTile(
                      leading: CircleAvatar(
                        child: Text('# ${index + 1}'),
                      ),
                      title: Text(selectedMeal.steps[index]),
                    ),
                    Divider()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>toggleFavorite(mealId),            //(){Navigator.of(context).pop(mealId);},
        child:Icon(isFavorite(mealId)? Icons.favorite : Icons.favorite_border)          //Icon(Icons.delete),
      ),
    );
  }
}
