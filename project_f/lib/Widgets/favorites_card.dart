import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class Favorites {
  final String imageUrl;
  final String title;
  final String description;

  Favorites({
    required this.imageUrl,
    required this.title,
    required this.description,
  });
}

class FavoritesCard extends StatelessWidget {
  final Favorites favorites;

  const FavoritesCard({super.key, required this.favorites});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      padding: const EdgeInsets.all(10),
      height: 150,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 239, 239, 238),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 201, 201, 201),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Row(
            children: [
              //! Image
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  favorites.imageUrl,
                  width: 100,
                  height: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 10),
              //! Title and Description
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      favorites.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      favorites.description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          //! Like Button in bottom right corner
          Positioned(
            bottom: 5,
            right: -2,
            child: LikeButton(
              size: 25,
              circleColor: const CircleColor(
                start: Colors.deepPurpleAccent,
                end: Colors.deepPurpleAccent,
              ),
              bubblesColor: const BubblesColor(
                dotPrimaryColor: Color.fromARGB(255, 0, 0, 0),
                dotSecondaryColor: Color.fromARGB(255, 0, 0, 0),
              ),
              likeBuilder: (bool isLiked) {
                return Icon(
                  Icons.favorite,
                  color: isLiked ? Colors.deepPurpleAccent : Colors.grey,
                  size: 25,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
