import 'package:flutter/material.dart';
import 'package:rate_in_stars/rate_in_stars.dart';

class Reviews {
  final double rating;
  final String description;

  Reviews({
    required this.rating,
    required this.description,
  });
}

class ReviewsCard extends StatefulWidget {
  final Reviews reviews;

  const ReviewsCard({
    super.key,
    required this.reviews,
  });

  @override
  _ReviewsCardState createState() => _ReviewsCardState();
}

class _ReviewsCardState extends State<ReviewsCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        padding: const EdgeInsets.all(30),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //!Rating
            Row(
              children: [
                RatingStars(
                  rating: widget.reviews.rating,
                  editable: false,
                  iconSize: 28,
                  color: Colors.black,
                ),
              ],
            ),
            const SizedBox(height: 10),
            AnimatedCrossFade(
              //!Description
              firstChild: Text(
                widget.reviews.description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              secondChild: Text(
                widget.reviews.description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              crossFadeState: isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 500),
              firstCurve: Curves.easeInOut,
              secondCurve: Curves.easeInOut,
            ),
          ],
        ),
      ),
    );
  }
}
