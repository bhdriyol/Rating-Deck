import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_f/Widgets/favorites_card.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<Favorites> favorites = [
    Favorites(
      imageUrl: 'assets/images/mbp24.png',
      title: 'Macbook Pro',
      description: '14" M3 8CPU 10GPU 16 GB 512 GB Space Gray',
    ),
    Favorites(
      imageUrl: 'assets/images/iph15.png',
      title: 'IPhone 15',
      description: '6.1" iPhone 15 128 GB Black',
    ),
    Favorites(
      imageUrl: 'assets/images/airpro.png',
      title: 'AirPods Pro (2nd Gen)',
      description: 'AirPods Pro 2nd Gen USB-C',
    ),
    Favorites(
      imageUrl: 'assets/images/mbp24.png',
      title: 'Macbook Pro',
      description: '14" M3 8CPU 10GPU 16 GB 512 GB Space Gray',
    ),
    Favorites(
      imageUrl: 'assets/images/iph15.png',
      title: 'IPhone 15',
      description: '6.1" iPhone 15 128 GB Black',
    ),
    Favorites(
      imageUrl: 'assets/images/airpro.png',
      title: 'AirPods Pro (2nd Gen)',
      description: 'AirPods Pro 2nd Gen USB-C',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: const Color.fromARGB(255, 239, 239, 238),
      ),
      body: Center(
        child: Column(
          children: [
            //!Title
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                "Your Favorites",
                style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w800, fontSize: 32)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            //!List Elements
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(1.0),
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  return FavoritesCard(favorites: favorites[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
