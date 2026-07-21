import 'package:flutter/material.dart';

import '../services/favorites_service.dart';



class FavoriteButton extends StatefulWidget {


  final Map<String,dynamic> location;



  const FavoriteButton({

    super.key,

    required this.location,

  });



  @override
  State<FavoriteButton> createState() =>
      _FavoriteButtonState();



}







class _FavoriteButtonState extends State<FavoriteButton>
    with SingleTickerProviderStateMixin {



  bool isFavorite = false;


  late AnimationController animationController;


  late Animation<double> scaleAnimation;







  @override
  void initState(){

    super.initState();


    checkFavorite();



    animationController = AnimationController(

      vsync: this,

      duration:
      const Duration(milliseconds:200),

    );



    scaleAnimation = Tween<double>(

      begin:1,

      end:1.3,

    ).animate(

      CurvedAnimation(

        parent: animationController,

        curve: Curves.easeOut,

      ),

    );



  }








  Future<void> checkFavorite() async {


    final result = await FavoritesService.isFavorite(

      widget.location["id"],

    );



    setState((){


      isFavorite = result;



    });


  }








  Future<void> toggleFavorite() async {



    if(isFavorite){



      await FavoritesService.removeFavorite(

        widget.location["id"],

      );



    }

    else{



      await FavoritesService.addFavorite(

        widget.location,

      );



    }




    setState((){


      isFavorite = !isFavorite;



    });




    animationController.forward().then((_){

      animationController.reverse();

    });



  }









  @override
  Widget build(BuildContext context){



    return ScaleTransition(



      scale:

      scaleAnimation,



      child:

      IconButton(



        onPressed:

        toggleFavorite,



        icon:


        Icon(



          isFavorite

              ?

          Icons.favorite

              :

          Icons.favorite_border,



        ),



        color:


        isFavorite

            ?

        Colors.red

            :

        Colors.grey,



        iconSize:

        28,



      ),



    );



  }









  @override
  void dispose(){


    animationController.dispose();


    super.dispose();


  }



}