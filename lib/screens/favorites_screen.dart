import 'package:flutter/material.dart';

import '../services/favorites_service.dart';
import '../models/location.dart';
import '../widgets/program_card.dart';
import 'detail_screen.dart';



class FavoritesScreen extends StatefulWidget {

  const FavoritesScreen({super.key});


  @override
  State<FavoritesScreen> createState() =>
      FavoritesScreenState();

}





class FavoritesScreenState extends State<FavoritesScreen> {


  List<Map<String,dynamic>> favorites = [];


  bool loading = true;




  @override
  void initState(){

    super.initState();

    loadFavorites();

  }






  Future<void> loadFavorites() async {


    final data =
    await FavoritesService.getFavorites();


    setState((){


      favorites = data;

      loading = false;


    });


  }







  Location mapToLocation(
      Map<String,dynamic> data
      ){


    return Location(

      id:
      data["id"] ?? "",


      name:
      data["name"] ?? "",


      city:
      data["city"] ?? "",


      address:
      data["address"] ?? "",


      sport:
      data["sport"] ?? "",


      programName:
      data["programName"] ?? "",


      category:
      data["category"] ?? "",


      skillLevel:
      data["skillLevel"] ?? "",


      programType:
      data["programType"] ?? "",


      days:
      data["days"] ?? "",


      time:
      data["time"] ?? "",


      pricing:
      data["pricing"] ?? "",


      membershipRequired:
      data["membershipRequired"] ?? "",


      dropInAvailable:
      data["dropInAvailable"] ?? "",


      contact:
      data["contact"] ?? "",


      website:
      data["website"] ?? "",


      mapsAddress:
      data["mapsAddress"] ?? "",


      indoorOutdoor:
      data["indoorOutdoor"] ?? "",


      popularity:
      data["popularity"] ?? "",


      notes:
      data["notes"] ?? "",


      lastVerifiedDate:
      data["lastVerifiedDate"] ?? "",


      facilityType:
      data["facilityType"] ?? "",

    );


  }







  @override
  Widget build(BuildContext context){



    return Scaffold(


      backgroundColor:
      const Color(0xffF7F7F7),



      appBar:

      AppBar(

        backgroundColor:
        Colors.orange,


        title:

        const Text(

          "❤️ Favorites",

          style:

          TextStyle(

            fontWeight:
            FontWeight.bold,

          ),

        ),

      ),






      body:


      loading

          ?

      const Center(

        child:

        CircularProgressIndicator(),

      )

          :


      favorites.isEmpty


          ?


      Center(


        child:

        Column(

          mainAxisAlignment:
          MainAxisAlignment.center,


          children:[


            const Icon(

              Icons.favorite_border,

              size:80,

              color:Colors.orange,

            ),



            const SizedBox(height:20),




            const Text(

              "No favorites yet",

              style:

              TextStyle(

                fontSize:22,

                fontWeight:
                FontWeight.bold,

              ),

            ),




            const SizedBox(height:8),





            Text(

              "Save programs you want to revisit",

              style:

              TextStyle(

                color:
                Colors.grey[600],

              ),

            )



          ],


        ),


      )



          :


      RefreshIndicator(


        onRefresh:
        loadFavorites,



        child:

        ListView.builder(



          padding:

          const EdgeInsets.all(16),




          itemCount:

          favorites.length,




          itemBuilder:

              (context,index){



            final item =
            favorites[index];



            final location =
            mapToLocation(item);




            return Dismissible(



              key:

              Key(location.id),



              direction:

              DismissDirection.endToStart,




              background:

              Container(



                alignment:

                Alignment.centerRight,



                padding:

                const EdgeInsets.only(right:20),




                color:

                Colors.red,



                child:

                const Icon(

                  Icons.delete,

                  color:

                  Colors.white,

                ),



              ),





              onDismissed:

                  (direction) async{



                await FavoritesService
                    .removeFavorite(location.id);



                loadFavorites();



              },





              child:

              ProgramCard(



                location:item,



                onTap:(){



                  Navigator.push(



                    context,



                    MaterialPageRoute(



                      builder:(context)=>

                          DetailScreen(

                            location:

                            location,

                          ),



                    ),



                  ).then((_){

                    loadFavorites();

                  });



                },


              ),



            );



          },



        ),


      ),


    );


  }


}