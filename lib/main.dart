import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'firebase_options.dart';
import 'screens/home_screen.dart';
import 'screens/favorites_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await FirebaseAnalytics.instance.logEvent(
    name: 'app_opened',
    parameters: {'app_name': 'fraser_valley_sports'},
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  static final FirebaseAnalyticsObserver analyticsObserver =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fraser Valley Sports',

      navigatorObservers: [analyticsObserver],

      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        scaffoldBackgroundColor: const Color(0xffF7F7F7),
      ),

      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int currentIndex = 0;

  final GlobalKey<FavoritesScreenState> favoritesKey =
      GlobalKey<FavoritesScreenState>();

  Future<void> changeTab(int index) async {
    setState(() {
      currentIndex = index;
    });

    final String screenName = index == 0 ? 'home_screen' : 'favorites_screen';

    await FirebaseAnalytics.instance.logScreenView(
      screenName: screenName,
      screenClass: 'MainNavigation',
    );

    await FirebaseAnalytics.instance.logEvent(
      name: 'navigation_tab_selected',
      parameters: {'tab_name': index == 0 ? 'home' : 'favorites'},
    );

    if (index == 1) {
      favoritesKey.currentState?.loadFavorites();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: [
          const HomeScreen(),
          FavoritesScreen(key: favoritesKey),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: changeTab,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_outline),
            selectedIcon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
