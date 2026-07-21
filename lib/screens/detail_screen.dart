import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/location.dart';
import '../services/favorites_service.dart';



class DetailScreen extends StatefulWidget {


  final Location location;



  const DetailScreen({

    super.key,

    required this.location,

  });



  @override
  State<DetailScreen> createState() =>
      _DetailScreenState();


}







class _DetailScreenState extends State<DetailScreen> {



  bool favorite = false;





  @override
  void initState(){

    super.initState();

    loadFavorite();

  }





  Future<void> loadFavorite() async{


    favorite = await FavoritesService.isFavorite(

      widget.location.id,

    );



    if(mounted){

      setState((){});

    }


  }







  Map<String,dynamic> locationMap(){


    return {


      "id":
      widget.location.id,


      "name":
      widget.location.name,


      "city":
      widget.location.city,


      "address":
      widget.location.address,


      "sport":
      widget.location.sport,


      "programName":
      widget.location.programName,


      "category":
      widget.location.category,


      "skillLevel":
      widget.location.skillLevel,


      "programType":
      widget.location.programType,


      "days":
      widget.location.days,


      "time":
      widget.location.time,


      "pricing":
      widget.location.pricing,


      "membershipRequired":
      widget.location.membershipRequired,


      "dropInAvailable":
      widget.location.dropInAvailable,


      "contact":
      widget.location.contact,


      "website":
      widget.location.website,


      "mapsAddress":
      widget.location.mapsAddress,


      "indoorOutdoor":
      widget.location.indoorOutdoor,


      "popularity":
      widget.location.popularity,


      "notes":
      widget.location.notes,


      "lastVerifiedDate":
      widget.location.lastVerifiedDate,


    };


  }







  Future<void> toggleFavorite() async{


    if(favorite){


      await FavoritesService.removeFavorite(

        widget.location.id,

      );


    }

    else{


      await FavoritesService.addFavorite(

        locationMap(),

      );


    }




    setState((){


      favorite = !favorite;


    });


  }









  @override
  Widget build(BuildContext context) {


    return Scaffold(


      backgroundColor:
      const Color(0xffF7F7F7),





      appBar: AppBar(


        backgroundColor:
        Colors.orange,


        title:


        Text(


          widget.location.name,


          style:

          const TextStyle(

            fontWeight:
            FontWeight.bold,

          ),


        ),



        actions:[



          IconButton(


            onPressed:
            toggleFavorite,


            icon:


            AnimatedSwitcher(


              duration:

              const Duration(
                  milliseconds:250
              ),



              child:


              Icon(


                favorite

                    ?

                Icons.favorite

                    :

                Icons.favorite_border,


                key:
                ValueKey(favorite),


                color:
                Colors.red,


              ),


            ),



          ),


        ],


      ),









      body:


      SingleChildScrollView(


        padding:
        const EdgeInsets.all(16),



        child:

        Column(


          crossAxisAlignment:
          CrossAxisAlignment.start,



          children:[





            Card(


              elevation:
              2,


              shape:

              RoundedRectangleBorder(

                borderRadius:
                BorderRadius.circular(20),

              ),



              child:


              Padding(


                padding:
                const EdgeInsets.all(20),



                child:


                Column(


                  crossAxisAlignment:
                  CrossAxisAlignment.start,



                  children:[



                    Text(


                      widget.location.name,


                      style:


                      const TextStyle(


                        fontSize:
                        26,


                        fontWeight:
                        FontWeight.bold,


                      ),


                    ),






                    const SizedBox(height:8),





                    Text(


                      "📍 ${widget.location.city}",



                      style:


                      TextStyle(


                        color:
                        Colors.grey[700],


                        fontSize:
                        16,


                      ),


                    ),





                    const SizedBox(height:18),





                    Wrap(


                      spacing:
                      8,


                      runSpacing:
                      8,



                      children:[



                        chip(

                          widget.location.sport,

                        ),



                        chip(

                          widget.location.category,

                        ),



                        chip(

                          widget.location.programType,

                        ),



                      ],


                    ),


                  ],


                ),


              ),


            ),






            const SizedBox(height:16),







            sectionCard(


              title:
              "Program Details",



              children:[



                info(


                  Icons.calendar_month,


                  "Schedule",


                  "${widget.location.days}\n${widget.location.time}",


                ),




                info(


                  Icons.attach_money,


                  "Pricing",


                  widget.location.pricing,


                ),





                info(


                  Icons.fitness_center,


                  "Skill Level",


                  widget.location.skillLevel,


                ),




                info(


                  Icons.groups,


                  "Category",


                  widget.location.category,


                ),




                info(


                  Icons.event,


                  "Program Type",


                  widget.location.programType,


                ),



              ],


            ),



            const SizedBox(height:16),
                        sectionCard(

              title:
              "Facility Information",


              children:[



                info(

                  Icons.business,

                  "Facility",

                  widget.location.facilityType,

                ),




                info(

                  Icons.location_on,

                  "Address",

                  widget.location.address,

                ),





                info(

                  Icons.phone,

                  "Contact",

                  widget.location.contact,

                ),





                info(

                  Icons.home,

                  "Environment",

                  widget.location.indoorOutdoor,

                ),





                info(

                  Icons.star,

                  "Popularity",

                  widget.location.popularity,

                ),



              ],

            ),





            const SizedBox(height:16),







            sectionCard(



              title:

              "Notes",





              children:[




                Text(



                  widget.location.notes.isEmpty

                      ?

                  "No notes available."

                      :

                  widget.location.notes,




                  style:

                  const TextStyle(

                    fontSize:

                    16,

                  ),




                ),



              ],



            ),






            const SizedBox(height:20),









            SizedBox(



              width:

              double.infinity,




              child:


              ElevatedButton.icon(



                icon:

                const Icon(Icons.map),




                label:


                const Text(

                  "Open in Google Maps",

                ),





                onPressed:() async{



                  final address =



                  Uri.encodeComponent(



                    widget.location.mapsAddress.isNotEmpty

                        ?

                    widget.location.mapsAddress

                        :

                    widget.location.address,



                  );





                  final url = Uri.parse(



                    "https://www.google.com/maps?q=$address"



                  );





                  if(await canLaunchUrl(url)){


                    await launchUrl(url);


                  }



                },





                style:


                ElevatedButton.styleFrom(



                  backgroundColor:

                  Colors.orange,



                  foregroundColor:

                  Colors.white,



                  padding:

                  const EdgeInsets.all(16),



                  shape:

                  RoundedRectangleBorder(



                    borderRadius:

                    BorderRadius.circular(16),



                  ),



                ),




              ),




            ),








            const SizedBox(height:12),







            SizedBox(



              width:

              double.infinity,




              child:


              OutlinedButton.icon(



                icon:

                const Icon(Icons.language),





                label:


                const Text(

                  "Visit Website",

                ),





                onPressed:() async{



                  if(widget.location.website.isEmpty){

                    return;

                  }




                  final url = Uri.parse(

                    widget.location.website,

                  );





                  if(await canLaunchUrl(url)){


                    await launchUrl(url);


                  }



                },






                style:


                OutlinedButton.styleFrom(



                  foregroundColor:

                  Colors.orange,



                  padding:

                  const EdgeInsets.all(16),




                  shape:

                  RoundedRectangleBorder(



                    borderRadius:

                    BorderRadius.circular(16),



                  ),




                ),





              ),



            ),




          ],



        ),



      ),



    );


  }









  Widget chip(String text){



    return Container(



      padding:

      const EdgeInsets.symmetric(



        horizontal:

        12,



        vertical:

        8,



      ),





      decoration:


      BoxDecoration(



        color:

        Colors.orange.withOpacity(.15),




        borderRadius:

        BorderRadius.circular(30),




      ),





      child:


      Text(



        text,




        style:


        const TextStyle(



          fontWeight:

          FontWeight.w600,



        ),




      ),




    );



  }









  Widget sectionCard({



    required String title,



    required List<Widget> children,



  }){



    return Card(



      elevation:

      2,




      shape:


      RoundedRectangleBorder(



        borderRadius:

        BorderRadius.circular(20),



      ),





      child:


      Padding(



        padding:

        const EdgeInsets.all(20),




        child:


        Column(



          crossAxisAlignment:

          CrossAxisAlignment.start,




          children:[




            Text(



              title,




              style:


              const TextStyle(



                fontSize:

                21,



                fontWeight:

                FontWeight.bold,



              ),




            ),





            const SizedBox(height:16),





            ...children,




          ],



        ),



      ),



    );



  }









  Widget info(



      IconData icon,



      String title,



      String value,



      ){



    return Padding(



      padding:


      const EdgeInsets.only(



        bottom:

        14,



      ),





      child:


      Row(



        crossAxisAlignment:

        CrossAxisAlignment.start,





        children:[




          Icon(



            icon,



            color:

            Colors.orange,



          ),





          const SizedBox(width:12),





          Expanded(



            child:


            Column(



              crossAxisAlignment:

              CrossAxisAlignment.start,




              children:[




                Text(



                  title,



                  style:


                  const TextStyle(



                    fontWeight:

                    FontWeight.bold,



                  ),



                ),





                Text(value),




              ],



            ),



          ),




        ],



      ),



    );



  }



}