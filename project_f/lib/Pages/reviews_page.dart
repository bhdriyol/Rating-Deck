import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_f/Widgets/reviews_card.dart';
import 'package:project_f/product_manager.dart';

class ReviewsPage extends StatefulWidget {
  const ReviewsPage({super.key});

  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  late Future<void> _futureProducts;
  final ProductManager _productManager = ProductManager();

  @override
  void initState() {
    super.initState();
    _futureProducts = _productManager.loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _futureProducts,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_ios_new_outlined),
              ),
              backgroundColor: const Color.fromARGB(255, 239, 239, 238),
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          final List<Reviews> comments =
              _productManager.getCommentsBySelectedProductId();
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_ios_new_outlined),
              ),
              backgroundColor: const Color.fromARGB(255, 239, 239, 238),
            ),
            body: Center(
              child: Column(
                children: [
                  //!Title
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      "Reviews",
                      style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 32)),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    color: Colors.black,
                    thickness: 3,
                    height: 25,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  //!List Elements
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(1.0),
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        return ReviewsCard(reviews: comments[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
