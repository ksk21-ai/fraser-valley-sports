import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget {

  const MapScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Sports Map",
        ),

        backgroundColor: Colors.orange,
      ),


      body: const Center(

        child: Text(
          "Map View Coming Soon",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

      ),

    );

  }

}