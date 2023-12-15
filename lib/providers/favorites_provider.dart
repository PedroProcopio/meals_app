import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals/models/meal.dart';

class FavoriteProviderNotifier extends StateNotifier<List<Meal>> {
  FavoriteProviderNotifier() : super([]);

  bool toggleFavorite(Meal meal) {
    final isExisting = state.contains(meal);

    if (isExisting) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteProvider =
    StateNotifierProvider<FavoriteProviderNotifier, List<Meal>>((ref) {
  return FavoriteProviderNotifier();
});
