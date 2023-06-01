import 'package:flutter/material.dart';
import 'package:mealapp/data/dummy_data.dart';
import 'package:mealapp/models/meal.dart';
import 'package:mealapp/pages/meals_page.dart';
import 'package:mealapp/widgets/category_grid_item.dart';
import 'package:mealapp/models/category.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.onToggleFavorite});
  final void Function(Meal meal) onToggleFavorite;
  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = dummyMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => MealsPage(
        title: category.title,
        meals: filteredMeals,
        onToggleFavorite: onToggleFavorite,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(24),
      crossAxisCount: 2,
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      childAspectRatio: 1.1,
      children: [
        for (final availableCategory in availableCategories)
          CategoryGridItem(
              category: availableCategory,
              onSelectCategory: () {
                _selectCategory(context, availableCategory);
              })
      ],
    );
  }
}
