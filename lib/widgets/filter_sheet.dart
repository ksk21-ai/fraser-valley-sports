import 'package:flutter/material.dart';


class FilterSheet extends StatefulWidget {


  final Function(Map<String,String>) onApply;


  const FilterSheet({

    super.key,

    required this.onApply,

  });



  @override
  State<FilterSheet> createState() =>
      _FilterSheetState();

}



class _FilterSheetState extends State<FilterSheet>{


  String sport = "";
  String city = "";
  String type = "";



  @override
  Widget build(BuildContext context){


    return Padding(

      padding:
      const EdgeInsets.all(20),


      child: Column(

        mainAxisSize:
        MainAxisSize.min,


        crossAxisAlignment:
        CrossAxisAlignment.start,


        children:[



          const Text(

            "Filters",

            style:
            TextStyle(

              fontSize:24,

              fontWeight:
              FontWeight.bold,

            ),

          ),



          const SizedBox(height:20),



          DropdownButtonFormField<String>(

            decoration:
            const InputDecoration(

              labelText:"Sport",

            ),


            items:[

              "Basketball",
              "Soccer",
              "Badminton",
              "Volleyball"

            ]

                .map(

                  (e)=>DropdownMenuItem(

                value:e,

                child:Text(e),

              ),

            )

                .toList(),



            onChanged:(value){

              sport=value ?? "";

            },


          ),



          const SizedBox(height:15),



          DropdownButtonFormField<String>(

            decoration:
            const InputDecoration(

              labelText:"City",

            ),



            items:[

              "Langley",
              "Surrey",
              "Abbotsford",
              "Mission"

            ]

                .map(

                  (e)=>DropdownMenuItem(

                value:e,

                child:Text(e),

              ),

            )

                .toList(),



            onChanged:(value){

              city=value ?? "";

            },


          ),




          const SizedBox(height:15),




          DropdownButtonFormField<String>(

            decoration:
            const InputDecoration(

              labelText:"Program Type",

            ),



            items:[

              "League",
              "Camp",
              "Drop-In",
              "Training"

            ]

                .map(

                  (e)=>DropdownMenuItem(

                value:e,

                child:Text(e),

              ),

            )

                .toList(),



            onChanged:(value){

              type=value ?? "";

            },


          ),




          const SizedBox(height:20),




          SizedBox(

            width:
            double.infinity,


            child:
            ElevatedButton(

              child:
              const Text("Apply"),


              onPressed:(){


                widget.onApply({

                  "sport":sport,

                  "city":city,

                  "type":type,

                });


                Navigator.pop(context);


              },

            ),

          )


        ],


      ),


    );


  }


}