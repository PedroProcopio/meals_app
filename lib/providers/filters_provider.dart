import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/meals_provider.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegan,
  vegetarian,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegan: false,
          Filter.vegetarian: false,
        });

  void toggleFilter(Filter filter, bool newVal) {
    state = {...state, filter: newVal};
  }

  void toggleFilters(Map<Filter, bool> filters) {
    state = filters;
  }
}

final filterProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>((ref) {
  return FiltersNotifier();
});

final availableMealsProvider = Provider(
  (ref) {
    final meals = ref.watch(mealsProvider);
    final selectedFilters = ref.watch(filterProvider);

    return meals.where((meal) {
      if (selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();
  },
);
