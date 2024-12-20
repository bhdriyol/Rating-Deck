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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //!Title
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: Text(
                    "Your Favorites",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w800,
                      fontSize: 35,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(
              color: Colors.black,
              thickness: 3,
              height: 25,
            ),
            const SizedBox(height: 10),
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
