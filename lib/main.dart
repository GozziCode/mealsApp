import './dummy_data.dart';
import 'package:flutter/material.dart';

import './screens/filters_screen.dart';
import './screens/tab_screen.dart';
import './screens/category_screen.dart';
import './widgets/category_meals.dart';
import './screens/meal_detailsScreen.dart';
import './models/meals.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'vegetarian': false,
    'vegan': false,
    'lactose': false
  };
  List<Meal> availableMeal = DUMMY_MEALS;
  List<Meal> _favoriteMeal = [];

//adding or removing from a list of items
  void _toggleFavorite(String mealId) {
    //checks wether an element is part of the favorite list, if its not part the index will be equals to minus 1
    final existingIndex = _favoriteMeal.indexWhere((meal) => meal.id == mealId);
    if(existingIndex > 0){
      // removing an element
      setState(() {
        _favoriteMeal.removeAt(existingIndex);
      });
    }
    else{
      setState(() {
        _favoriteMeal.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      availableMeal = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        if (_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  bool _isMealFavorite(String id){
    return _favoriteMeal.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(225, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline6: TextStyle(
                  fontSize: 24.0,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold),
            ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: TabsScreen(),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabsScreen(_favoriteMeal),
        CategoryMeal.routeName: (ctx) => CategoryMeal(availableMeal),
        MealDetailsScreen.routeName: (ctx) => MealDetailsScreen(_toggleFavorite,_isMealFavorite ),
        FiltersScreen.routeName: (ctx) => FiltersScreen(
              _filters,
              _setFilters,
            )
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}

