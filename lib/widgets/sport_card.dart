import 'package:flutter/material.dart';


class SportCard extends StatelessWidget {

  final String sport;
  final int count;
  final IconData icon;
  final VoidCallback onTap;


  const SportCard({

    super.key,

    required this.sport,

    required this.count,

    required this.icon,

    required this.onTap,

  });



  @override
  Widget build(BuildContext context) {


    return InkWell(

      borderRadius:
      BorderRadius.circular(20),


      onTap: onTap,


      child: Container(

        width: 125,


        padding:
        const EdgeInsets.all(16),


        decoration: BoxDecoration(

          color: Colors.white,


          borderRadius:
          BorderRadius.circular(20),


          boxShadow: [

            BoxShadow(

              color:
              Colors.black.withOpacity(.08),

              blurRadius: 10,

              offset:
              const Offset(0,5),

            )

          ],

        ),



        child: Column(

          crossAxisAlignment:
          CrossAxisAlignment.start,


          children: [


            Container(

              padding:
              const EdgeInsets.all(12),


              decoration: BoxDecoration(

                color:
                Colors.orange.withOpacity(.15),


                borderRadius:
                BorderRadius.circular(14),

              ),



              child: Icon(

                icon,

                color:
                Colors.orange,

              ),

            ),



            const SizedBox(height:12),



            Text(

              sport,

              maxLines:1,

              overflow:
              TextOverflow.ellipsis,


              style:
              const TextStyle(

                fontWeight:
                FontWeight.bold,

                fontSize:16,

              ),

            ),



            const SizedBox(height:4),



            Text(

              "$count Programs",


              style:
              TextStyle(

                color:
                Colors.grey[600],

                fontSize:13,

              ),

            ),


          ],

        ),

      ),

    );

  }

}