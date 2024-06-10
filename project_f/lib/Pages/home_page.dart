import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_f/Widgets/product_card.dart';
import 'package:project_f/product_manager.dart';
import 'package:provider/provider.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = 'All';
  String searchText = '';
  final TextEditingController _searchController = TextEditingController();

  void _selectCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  List<Product> _getFilteredProducts(List<Product> products) {
    List<Product> filteredProducts = products;

    if (selectedCategory != 'All') {
      filteredProducts = filteredProducts
          .where((Product product) => product.category == selectedCategory)
          .toList();
    }

    if (searchText.isNotEmpty) {
      filteredProducts = filteredProducts
          .where((Product product) =>
              product.title.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    }

    return filteredProducts;
  }

  @override
  Widget build(BuildContext context) {
    final productManager = Provider.of<ProductManager>(context);
    final products = _getFilteredProducts(productManager.products);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: const Color.fromARGB(255, 239, 239, 238),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                child: Text(
                  "Discover",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w800,
                    fontSize: 35,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 5, 0),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      double searchBoxWidth = constraints.maxWidth * 0.8;
                      if (searchBoxWidth > 300) {
                        searchBoxWidth = 300;
                      }

                      return SearchBarAnimation(
                        textEditingController: _searchController,
                        isOriginalAnimation: true,
                        enableKeyboardFocus: true,
                        enableButtonBorder: false,
                        isSearchBoxOnRightSide: true,
                        enableButtonShadow: false,
                        enableBoxShadow: false,
                        searchBoxWidth: searchBoxWidth,
                        durationInMilliSeconds: 300,
                        hintText: "Search",
                        buttonBorderColour:
                            const Color.fromARGB(255, 239, 239, 238),
                        searchBoxColour:
                            const Color.fromARGB(255, 201, 201, 201),
                        buttonColour: const Color.fromARGB(255, 239, 239, 238),
                        trailingWidget: const Icon(
                          Icons.search_rounded,
                          size: 25,
                          color: Colors.black,
                        ),
                        secondaryButtonWidget: const Icon(
                          Icons.close,
                          size: 25,
                          color: Colors.black,
                        ),
                        buttonWidget: const Icon(
                          Icons.search_rounded,
                          size: 25,
                          color: Colors.black,
                        ),
                        onChanged: (text) {
                          setState(() {
                            searchText = text;
                          });
                        },
                      );
                    },
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                buildCategoryButton("All"),
                buildCategoryButton("Computers"),
                buildCategoryButton("Phones"),
                buildCategoryButton("Components"),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(23.0),
              color: Colors.transparent,
              child: ProductGridPage(products: products),
            ),
          ),
          const SizedBox(
            height: 60,
          )
        ],
      ),
    );
  }

  Widget buildCategoryButton(String category) {
    bool isSelected = selectedCategory == category;

    return GestureDetector(
      onTap: () {
        _selectCategory(category);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 21.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              category,
              style: GoogleFonts.inter(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(top: 4.0),
              height: isSelected ? 2.0 : 0.0,
              width: isSelected ? getTextWidth(category) : 0.0,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  double getTextWidth(String text) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size.width;
  }
}

//!Product List
class ProductGridPage extends StatelessWidget {
  final List<Product> products;

  ProductGridPage({required this.products});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(1.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 3 / 4,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCard(product: products[index]);
      },
    );
  }
}
