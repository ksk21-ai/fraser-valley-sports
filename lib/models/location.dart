class Location {


  final String id;


  final String name;
  final String facilityType;
  final String city;
  final String address;


  final String sport;
  final String programName;


  final String category;
  final String skillLevel;
  final String programType;


  final String days;
  final String time;


  final String pricing;


  final String membershipRequired;
  final String dropInAvailable;


  final String contact;


  final String website;


  final String mapsAddress;


  final String indoorOutdoor;


  final String popularity;


  final String notes;


  final String lastVerifiedDate;



  Location({

    required this.id,

    required this.name,

    required this.facilityType,

    required this.city,

    required this.address,


    required this.sport,

    required this.programName,


    required this.category,

    required this.skillLevel,

    required this.programType,


    required this.days,

    required this.time,


    required this.pricing,


    required this.membershipRequired,

    required this.dropInAvailable,


    required this.contact,


    required this.website,


    required this.mapsAddress,


    required this.indoorOutdoor,


    required this.popularity,


    required this.notes,


    required this.lastVerifiedDate,


  });





  factory Location.fromFirestore(

      Map<String,dynamic> data,

      String id,

      ){


    return Location(


      id:id,


      name:data["name"] ?? "",


      facilityType:
      data["facilityType"] ?? "",


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


    );


  }


}