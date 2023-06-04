import 'package:flutter/material.dart';
import 'package:mealapp/data/dummy_data.dart';
import 'package:mealapp/models/meal.dart';
import 'package:mealapp/pages/filters.dart';
import 'package:mealapp/pages/home_page.dart';
import 'package:mealapp/pages/meals_page.dart';
import 'package:mealapp/widgets/main_drawer.dart';

// default initial filters
const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.latoseFree: false,
  Filter.vegan: false,
  Filter.vegetables: false
};

class TabsPage extends StatefulWidget {
  const TabsPage({super.key});

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];
  // we will change this selectedFilter based on user input
  Map<Filter, bool> _selectedFilter = {
    Filter.glutenFree: false,
    Filter.latoseFree: false,
    Filter.vegan: false,
    Filter.vegetables: false
  };

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

  void _selectTab(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      // only when user navigate back, we can recieve data.
      final result =
          await Navigator.of(context).push<Map<Filter, bool>>(MaterialPageRoute(
              builder: (ctx) => FiltersPage(
                    currentFilters: _selectedFilter,
                  )));
      setState(() {
        _selectedFilter = result ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where((meal) {
      if (_selectedFilter[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilter[Filter.latoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilter[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      if (_selectedFilter[Filter.vegetables]! && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();
    String activePageTitle = 'Pick your category';
    Widget activePage = HomePage(
        onToggleFavorite: _toggleMealFavoriteStatus,
        availableMeals: availableMeals);

    if (_selectedPageIndex == 1) {
      activePageTitle = 'Your favorites';
      activePage = MealsPage(
        meals: _favoriteMeals,
        onToggleFavorite: _toggleMealFavoriteStatus,
      );
    }
    return Scaffold(
      drawer: MainDrawer(onSelect: _selectTab),
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
