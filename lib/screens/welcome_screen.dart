import 'package:flutter/material.dart';

import 'home_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50],

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const Spacer(),

              // APP ICON
              Container(
                height: 120,
                width: 120,

                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),

                child: const Icon(
                  Icons.sports_basketball,
                  size: 70,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 30),

              // TITLE
              const Text(
                "Fraser Valley Sports Access",

                textAlign: TextAlign.center,

                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              // SUBTITLE
              Text(
                "Find drop-in sports, leagues, community centres, and open gyms across the Fraser Valley.",

                textAlign: TextAlign.center,

                style: TextStyle(
                  fontSize: 17,
                  color: Colors.grey[700],
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 40),

              // FEATURES
              featureTile(
                Icons.search,
                "Search by sport or location",
              ),

              featureTile(
                Icons.map,
                "Open locations directly in Google Maps",
              ),

              featureTile(
                Icons.people,
                "Adult and youth programs",
              ),

              featureTile(
                Icons.schedule,
                "Schedules, pricing, and details",
              ),

              const Spacer(),

              // BUTTON
              SizedBox(
                width: double.infinity,
                height: 58,

                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),

                  onPressed: () {
                    Navigator.pushReplacement(
                      context,

                      MaterialPageRoute(
                        builder: (_) => HomeScreen(),
                      ),
                    );
                  },

                  child: const Text(
                    "Explore Sports",

                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget featureTile(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),

      child: Row(
        children: [

          Container(
            padding: const EdgeInsets.all(10),

            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),

            child: Icon(
              icon,
              color: Colors.orange,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Text(
              text,

              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}