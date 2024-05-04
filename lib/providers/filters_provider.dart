import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/providers/meals_provider.dart';
import 'package:meal_app/screens/filter.dart';

enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

class FilterNotifers extends StateNotifier<Map<Filter, bool>> {
  FilterNotifers()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false
        });

  void setFilters(Map<Filter, bool> choosenFilter) {
    state = choosenFilter;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }
}

final filterprovider = StateNotifierProvider<FilterNotifers, Map<Filter, bool>>(
    (ref) => FilterNotifers());

final FilteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealProvider);
  final activeFilter = ref.watch(filterprovider);
  return meals.where((meal) {
    if (activeFilter[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activeFilter[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilter[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (activeFilter[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    return true;
  }).toList();
});
