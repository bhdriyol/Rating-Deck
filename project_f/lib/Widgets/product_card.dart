import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_f/Pages/product_detail_page.dart';
import 'package:project_f/product_manager.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ProductManager.setProductId(product.id);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(product: product),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //!Item Image
          Expanded(
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10.0)),
              child: Image.asset(
                product.imagePaths.first,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
          ),
          //!Item Title
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                product.title,
                style: GoogleFonts.inter(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          //!Item Description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              product.description,
              style: GoogleFonts.inter(
                fontSize: 11.0,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          //!Item Price
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "last ${product.price}₺",
                style: GoogleFonts.inter(
                  fontSize: 13.0,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
