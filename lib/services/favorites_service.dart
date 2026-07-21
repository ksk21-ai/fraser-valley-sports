import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class FavoritesService {


  static const String key = "favorites";


  static Future<List<Map<String,dynamic>>> getFavorites() async {

    final prefs = await SharedPreferences.getInstance();


    final data = prefs.getStringList(key) ?? [];


    return data
        .map((item)=>jsonDecode(item) as Map<String,dynamic>)
        .toList();

  }



  static Future<void> addFavorite(
      Map<String,dynamic> location
      ) async {


    final prefs = await SharedPreferences.getInstance();


    final favorites =
        await getFavorites();



    final exists =
        favorites.any(
          (item)=>item["id"] == location["id"],
        );


    if(!exists){

      favorites.add(location);

    }



    await prefs.setStringList(
      key,

      favorites
          .map(
            (item)=>jsonEncode(item),
      )
          .toList(),

    );

  }




  static Future<void> removeFavorite(
      String id
      ) async {


    final prefs =
        await SharedPreferences.getInstance();



    final favorites =
        await getFavorites();



    favorites.removeWhere(
            (item)=>item["id"] == id
    );



    await prefs.setStringList(
      key,

      favorites
          .map(
              (item)=>jsonEncode(item)
          )
          .toList(),

    );


  }



  static Future<bool> isFavorite(
      String id
      ) async {


    final favorites =
        await getFavorites();



    return favorites.any(
            (item)=>item["id"] == id
    );


  }

}