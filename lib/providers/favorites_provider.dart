import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/model/meal.dart';

class FavoriteMealNotifes extends StateNotifier<List<Meal>> {
  FavoriteMealNotifes() : super([]);
  bool toggleMealFavoriteStatus(Meal meal) {
    final mealsIsFavorite = state.contains(meal);
    if (mealsIsFavorite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteProvider =
    StateNotifierProvider<FavoriteMealNotifes, List<Meal>>((ref) {
  return FavoriteMealNotifes();
});
