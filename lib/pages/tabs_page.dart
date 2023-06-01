import 'package:flutter/material.dart';
import 'package:mealapp/models/meal.dart';
import 'package:mealapp/pages/home_page.dart';
import 'package:mealapp/pages/meals_page.dart';
import 'package:mealapp/widgets/main_drawer.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({super.key});

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  var activePageTitle = 'Pick your category';
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];

  void _showInfoMessage(String text) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);
    if (isExisting == true) {
      setState(() {
        _favoriteMeals.remove(meal);
      });
      _showInfoMessage('Meal is no longer favorite.');
    } else {
      setState(() {
        _favoriteMeals.add(meal);
      });
      _showInfoMessage('Meal is marked as favorite.');
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    String activePageTitle = 'Pick your category';
    Widget activePage = HomePage(
      onToggleFavorite: _toggleMealFavoriteStatus,
    );

    if (_selectedPageIndex == 1) {
      activePageTitle = 'Your favorites';
      activePage = MealsPage(
        meals: _favoriteMeals,
        onToggleFavorite: _toggleMealFavoriteStatus,
      );
    }
    return Scaffold(
      drawer: const MainDrawer(),
      appBar: AppBar(title: Text(activePageTitle)),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.set_meal), label: 'Categories'),
        BottomNavigationBarItem(icon: Icon(Icons.stars), label: 'Favorites')
      ], onTap: _selectPage, currentIndex: _selectedPageIndex),
    );
  }
}
