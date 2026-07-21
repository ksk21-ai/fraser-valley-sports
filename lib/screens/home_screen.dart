import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/location.dart';
import '../widgets/sport_card.dart';
import '../widgets/program_card.dart';
import '../widgets/filter_sheet.dart';
import 'detail_screen.dart';


class HomeScreen extends StatefulWidget {

  const HomeScreen({
    super.key,
  });


  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();

}



class _HomeScreenState extends State<HomeScreen> {


  final TextEditingController searchController =
      TextEditingController();


  Timer? searchTimer;


  String searchText = "";


  Map<String,String> filters = {};


  String sortOption = "Popular";





  @override
  void dispose(){

    searchController.dispose();

    searchTimer?.cancel();

    super.dispose();

  }






  Map<String,dynamic> locationMap(Location location){

    return {

      "id": location.id,

      "name": location.name,

      "city": location.city,

      "address": location.address,

      "sport": location.sport,

      "programName": location.programName,

      "category": location.category,

      "skillLevel": location.skillLevel,

      "programType": location.programType,

      "days": location.days,

      "time": location.time,

      "pricing": location.pricing,

      "membershipRequired":
      location.membershipRequired,

      "dropInAvailable":
      location.dropInAvailable,

      "contact":
      location.contact,

      "website":
      location.website,

      "mapsAddress":
      location.mapsAddress,

      "indoorOutdoor":
      location.indoorOutdoor,

      "popularity":
      location.popularity,

      "notes":
      location.notes,

      "lastVerifiedDate":
      location.lastVerifiedDate,

    };

  }







  void updateSearch(String value){


    searchTimer?.cancel();


    searchTimer = Timer(

      const Duration(milliseconds:300),

      (){

        if(!mounted) return;


        setState((){

          searchText =
              value.toLowerCase();

        });

      },

    );


  }







  bool matchesSearch(Location location){


    if(searchText.isEmpty){

      return true;

    }



    final searchable = [

      location.name,

      location.sport,

      location.city,

      location.programName,

      location.category,

      location.skillLevel,

      location.facilityType,

      location.programType,

      location.indoorOutdoor,

      location.notes,

    ]

        .join(" ")

        .toLowerCase();




    return searchable.contains(searchText);


  }








  bool matchesFilters(Location location){



    if(filters["sport"] != null &&
        filters["sport"]!.isNotEmpty){


      if(!location.sport
          .toLowerCase()
          .contains(
          filters["sport"]!
              .toLowerCase()
      )){

        return false;

      }

    }







    if(filters["city"] != null &&
        filters["city"]!.isNotEmpty){


      if(!location.city
          .toLowerCase()
          .contains(
          filters["city"]!
              .toLowerCase()
      )){

        return false;

      }

    }







    if(filters["type"] != null &&
        filters["type"]!.isNotEmpty){


      if(!location.programType
          .toLowerCase()
          .contains(
          filters["type"]!
              .toLowerCase()
      )){

        return false;

      }

    }





    return true;


  }







  @override
  Widget build(BuildContext context) {


    return Scaffold(

      backgroundColor:
      const Color(0xffF7F7F7),



      appBar: AppBar(


        backgroundColor:
        Colors.orange,


        elevation:0,


        title:
        const Text(

          "Fraser Valley Sports",

          style:

          TextStyle(

            fontWeight:
            FontWeight.bold,

          ),

        ),

      ),







      body:

      StreamBuilder<QuerySnapshot>(


        stream:

        FirebaseFirestore.instance

            .collection("locations")

            .snapshots(),



        builder:
            (context,snapshot){



          if(snapshot.connectionState ==
              ConnectionState.waiting){


            return const Center(

              child:
              CircularProgressIndicator(),

            );


          }






          if(snapshot.hasError){


            return Center(

              child:

              Text(

                "Error loading programs",

                style:
                TextStyle(

                  color:
                  Colors.red,

                ),

              ),

            );


          }






          final locations =

          snapshot.data!.docs.map((doc){


            return Location.fromFirestore(

              doc.data()
              as Map<String,dynamic>,

              doc.id,

            );


          }).toList();






          List<Location> filtered =

          locations.where((location){


            return matchesSearch(location)

                &&

                matchesFilters(location);


          }).toList();





          if(sortOption=="Alphabetical"){


            filtered.sort(

                  (a,b)=>

                  a.name.compareTo(b.name),

            );


          }






          return Column(

            children:[


              Container(

                padding:
                const EdgeInsets.all(16),


                decoration:

                const BoxDecoration(

                  color:
                  Colors.orange,

                  borderRadius:

                  BorderRadius.only(

                    bottomLeft:
                    Radius.circular(25),

                    bottomRight:
                    Radius.circular(25),

                  ),

                ),



                child:

                Column(

                  crossAxisAlignment:
                  CrossAxisAlignment.start,


                  children:[



                    const Text(

                      "Find programs near you",

                      style:

                      TextStyle(

                        color:
                        Colors.white,

                        fontSize:
                        22,

                        fontWeight:
                        FontWeight.bold,

                      ),

                    ),



                    const SizedBox(height:15),




                    TextField(


                      controller:
                      searchController,


                      onChanged:
                      updateSearch,



                      decoration:

                      InputDecoration(


                        hintText:

                        "Search sports, cities, programs...",


                        filled:true,


                        fillColor:
                        Colors.white,


                        prefixIcon:

                        const Icon(
                            Icons.search
                        ),



                        suffixIcon:

                        searchText.isNotEmpty

                            ?

                        IconButton(

                          icon:

                          const Icon(
                              Icons.clear
                          ),


                          onPressed:(){

                            searchController.clear();


                            setState((){

                              searchText="";

                            });


                          },


                        )

                            :

                        null,



                        border:

                        OutlineInputBorder(

                          borderRadius:
                          BorderRadius.circular(18),

                          borderSide:
                          BorderSide.none,

                        ),


                      ),

                    ),



                    const SizedBox(height:12),



                    ElevatedButton.icon(

                      onPressed:(){


                        showModalBottomSheet(

                          context:
                          context,


                          builder:(context){


                            return FilterSheet(

                              onApply:(value){


                                setState((){

                                  filters=value;

                                });


                              },

                            );


                          },

                        );


                      },


                      icon:

                      const Icon(Icons.tune),


                      label:

                      const Text(
                          "Filters"
                      ),


                    ),


                  ],

                ),

              ),


              Expanded(

                child:

                ListView(

                  padding:
                  const EdgeInsets.all(16),


                  children:[


                    const Text(

                      "Popular Sports",

                      style:

                      TextStyle(

                        fontSize:
                        22,

                        fontWeight:
                        FontWeight.bold,

                      ),

                    ),



                    const SizedBox(height:15),
                    SizedBox(

                      height:145,


                      child:

                      ListView(

                        scrollDirection:
                        Axis.horizontal,


                        children:[


                          SportCard(

                            sport:
                            "Basketball",


                            count:

                            locations
                                .where(
                                  (e)=>
                                  e.sport
                                      .toLowerCase()
                                      .contains(
                                      "basketball"
                                  ),
                            )
                                .length,


                            icon:

                            Icons
                                .sports_basketball,


                            onTap:(){

                              setState((){

                                filters["sport"]
                                =
                                "Basketball";

                              });

                            },


                          ),



                          const SizedBox(width:12),




                          SportCard(

                            sport:
                            "Soccer",


                            count:

                            locations
                                .where(
                                  (e)=>
                                  e.sport
                                      .toLowerCase()
                                      .contains(
                                      "soccer"
                                  ),
                            )
                                .length,


                            icon:

                            Icons.sports_soccer,


                            onTap:(){


                              setState((){


                                filters["sport"]
                                =
                                "Soccer";


                              });


                            },


                          ),




                          const SizedBox(width:12),




                          SportCard(

                            sport:
                            "Badminton",


                            count:

                            locations
                                .where(
                                  (e)=>
                                  e.sport
                                      .toLowerCase()
                                      .contains(
                                      "badminton"
                                  ),
                            )
                                .length,


                            icon:

                            Icons.sports_tennis,


                            onTap:(){


                              setState((){


                                filters["sport"]
                                =
                                "Badminton";


                              });


                            },


                          ),



                        ],


                      ),


                    ),





                    const SizedBox(height:25),





                    Row(

                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,


                      children:[



                        Text(

                          "Programs (${filtered.length})",

                          style:

                          const TextStyle(

                            fontSize:
                            22,

                            fontWeight:
                            FontWeight.bold,

                          ),

                        ),




                        PopupMenuButton<String>(


                          icon:

                          const Icon(
                              Icons.sort
                          ),



                          onSelected:(value){


                            setState((){


                              sortOption=value;


                            });


                          },



                          itemBuilder:(context)=>[


                            const PopupMenuItem(

                              value:
                              "Popular",

                              child:
                              Text(
                                  "Popular"
                              ),

                            ),



                            const PopupMenuItem(

                              value:
                              "Alphabetical",

                              child:
                              Text(
                                  "Alphabetical"
                              ),

                            ),


                          ],


                        ),


                      ],


                    ),





                    const SizedBox(height:15),






                    if(filtered.isEmpty)


                      Card(

                        child:

                        Padding(

                          padding:
                          const EdgeInsets.all(25),


                          child:

                          Column(

                            children:[


                              const Icon(

                                Icons.search_off,

                                size:
                                50,

                              ),



                              const SizedBox(height:10),



                              const Text(

                                "No programs found",

                                style:

                                TextStyle(

                                  fontSize:
                                  18,

                                  fontWeight:
                                  FontWeight.bold,

                                ),

                              ),



                              const SizedBox(height:5),



                              Text(

                                "Try another search or filter",

                                style:

                                TextStyle(

                                  color:
                                  Colors.grey[600],

                                ),

                              ),



                            ],


                          ),


                        ),


                      ),







                    ...filtered.map((location){



                      return AnimatedContainer(

                        duration:

                        const Duration(
                            milliseconds:250
                        ),



                        child:

                        ProgramCard(

                          location:

                          locationMap(location),



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


                            );



                          },


                        ),


                      );


                    }),



                  ],


                ),


              ),



            ],


          );


        },


      ),


    );


  }


}