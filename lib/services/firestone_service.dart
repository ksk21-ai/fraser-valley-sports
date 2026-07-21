import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/location.dart';



class FirestoreService {


  final FirebaseFirestore db =
      FirebaseFirestore.instance;



  Stream<List<Location>> getLocations(){


    return db

        .collection("locations")

        .snapshots()


        .map((snapshot){


      return snapshot.docs.map((doc){


        return Location.fromFirestore(

          doc.data(),

          doc.id,

        );


      }).toList();


    });


  }


}