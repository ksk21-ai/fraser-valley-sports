import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

import 'screens/home_screen.dart';
import 'screens/favorites_screen.dart';



void main() async {


  WidgetsFlutterBinding.ensureInitialized();



  await Firebase.initializeApp(

    options:
    DefaultFirebaseOptions.currentPlatform,

  );



  runApp(

    const MyApp(),

  );


}







class MyApp extends StatelessWidget {


  const MyApp({super.key});



  @override
  Widget build(BuildContext context){


    return MaterialApp(



      debugShowCheckedModeBanner:false,



      title:
      "Fraser Valley Sports",




      theme:

      ThemeData(



        useMaterial3:true,



        colorScheme:

        ColorScheme.fromSeed(

          seedColor:
          Colors.orange,

        ),



        scaffoldBackgroundColor:

        const Color(0xffF7F7F7),



      ),




      home:

      const MainNavigation(),



    );


  }


}









class MainNavigation extends StatefulWidget {


  const MainNavigation({super.key});



  @override
  State<MainNavigation> createState() =>
      _MainNavigationState();



}








class _MainNavigationState
    extends State<MainNavigation>{



  int currentIndex = 0;



  final GlobalKey<FavoritesScreenState> favoritesKey =
  GlobalKey<FavoritesScreenState>();







  @override
  Widget build(BuildContext context){



    return Scaffold(




      body:


      IndexedStack(



        index:

        currentIndex,



        children:[



          const HomeScreen(),




          FavoritesScreen(

            key:

            favoritesKey,

          ),



        ],



      ),







      bottomNavigationBar:


      NavigationBar(



        selectedIndex:

        currentIndex,




        onDestinationSelected:

            (index){



          setState((){



            currentIndex = index;



          });






          // Refresh favorites every time tab opens

          if(index == 1){



            favoritesKey.currentState
                ?.loadFavorites();



          }



        },





        destinations:[



          const NavigationDestination(



            icon:

            Icon(

              Icons.home_outlined,

            ),



            selectedIcon:

            Icon(

              Icons.home,

            ),



            label:

            "Home",



          ),





          const NavigationDestination(



            icon:

            Icon(

              Icons.favorite_outline,

            ),



            selectedIcon:

            Icon(

              Icons.favorite,

            ),



            label:

            "Favorites",



          ),




        ],



      ),




    );



  }



}