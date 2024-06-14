import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:project_f/Widgets/favorites_card.dart';
import 'package:project_f/product_manager.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

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
              child: Consumer<ProductManager>(
                builder: (context, productManager, child) {
                  final favorites = productManager.favorites;
                  if (favorites.isEmpty) {
                    return Center(
                      child: Text(
                        "No favorites yet",
                        style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 24)),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(1.0),
                      itemCount: favorites.length,
                      itemBuilder: (context, index) {
                        return FavoritesCard(product: favorites[index]);
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
