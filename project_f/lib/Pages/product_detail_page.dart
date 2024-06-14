import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:project_f/Pages/reviews_page.dart';
import 'package:project_f/product_manager.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      //!Top Part
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
        actions: [
          Consumer<ProductManager>(
            builder: (context, productManager, child) {
              return LikeButton(
                padding: const EdgeInsets.only(right: 10),
                size: 30,
                circleColor: const CircleColor(
                  start: Colors.deepPurpleAccent,
                  end: Colors.deepPurpleAccent,
                ),
                bubblesColor: const BubblesColor(
                  dotPrimaryColor: Color.fromARGB(255, 0, 0, 0),
                  dotSecondaryColor: Color.fromARGB(255, 0, 0, 0),
                ),
                isLiked: productManager.isFavorite(widget.product),
                likeBuilder: (bool isLiked) {
                  return Icon(
                    Icons.favorite,
                    color: isLiked ? Colors.deepPurpleAccent : Colors.grey,
                    size: 30,
                  );
                },
                onTap: (bool isLiked) async {
                  productManager.toggleFavorite(widget.product);
                  return !isLiked;
                },
              );
            },
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 239, 239, 238),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //!Images
                    SizedBox(
                      height: screenSize.height * 0.3,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: widget.product.imagePaths.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => PhotoViewPage(
                                    imagePaths: widget.product.imagePaths,
                                    initialIndex: index,
                                  ),
                                ),
                              );
                            },
                            child: Image.asset(
                              widget.product.imagePaths[index],
                              fit: BoxFit.contain,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 5),
                    //!Dots
                    Center(
                      child: SmoothPageIndicator(
                        controller: _pageController,
                        count: widget.product.imagePaths.length,
                        effect: const ScrollingDotsEffect(
                          dotWidth: 6.0,
                          dotHeight: 6.0,
                          activeDotColor: Colors.black,
                          dotColor: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    //!Title Text
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      child: Text(
                        widget.product.title,
                        style: GoogleFonts.inter(
                          fontSize: screenSize.width * 0.06,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    //!Details Part
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.star_rate_rounded,
                                  color: Colors.black),
                              const SizedBox(width: 2),
                              Text(
                                widget.product.rating.toString(),
                                style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: screenSize.width * 0.035)),
                              ),
                              const SizedBox(width: 20),
                              Text(
                                "${widget.product.comments.length} Reviews",
                                style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: screenSize.width * 0.035)),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.thumb_up_alt_rounded,
                                color: Colors.green,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                "%80",
                                style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: screenSize.width * 0.03)),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                "(60%) of users suggested",
                                style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: screenSize.width * 0.03)),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "Product Info",
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: screenSize.width * 0.05)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    //!Info Text
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        widget.product.description,
                        style: GoogleFonts.inter(
                            fontSize: screenSize.width * 0.04),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: const Divider(
                        color: Colors.black,
                        thickness: 1,
                        height: 25,
                      ),
                    ),
                    //!Reviews
                    ListTile(
                      leading: const Icon(Icons.rate_review_outlined),
                      title: Text(
                        "Review",
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: screenSize.width * 0.05)),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "${widget.product.comments.length} Reviews",
                            style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: screenSize.width * 0.0375)),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          const Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ReviewsPage(),
                          ),
                        );
                      },
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: const Divider(
                        color: Colors.black,
                        thickness: 1,
                        height: 25,
                      ),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      //!Bottom Part
      bottomSheet: Container(
        color: const Color.fromARGB(255, 239, 239, 238),
        padding: const EdgeInsets.all(25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${widget.product.price}₺",
              style: GoogleFonts.inter(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: screenSize.width * 0.06)),
            ),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                shape: const StadiumBorder(),
              ),
              child: Text(
                'Amazon',
                style: GoogleFonts.inter(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: screenSize.width * 0.045)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//!Zoomed Page Part
class PhotoViewPage extends StatefulWidget {
  final List<String> imagePaths;
  final int initialIndex;

  const PhotoViewPage({
    Key? key,
    required this.imagePaths,
    required this.initialIndex,
  }) : super(key: key);

  @override
  _PhotoViewPageState createState() => _PhotoViewPageState();
}

class _PhotoViewPageState extends State<PhotoViewPage> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
    _currentIndex = widget.initialIndex;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToPrevious() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
    }
  }

  void _goToNext() {
    if (_currentIndex < widget.imagePaths.length - 1) {
      setState(() {
        _currentIndex++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 239, 238),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 239, 239, 238),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
      ),
      body: Stack(
        children: [
          PhotoView(
            backgroundDecoration:
                const BoxDecoration(color: Colors.transparent),
            imageProvider: AssetImage(widget.imagePaths[_currentIndex]),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2.0,
          ),
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: IconButton(
              onPressed: _goToPrevious,
              icon: const Icon(Icons.arrow_back_ios),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: IconButton(
              onPressed: _goToNext,
              icon: const Icon(Icons.arrow_forward_ios),
            ),
          ),
        ],
      ),
    );
  }
}
