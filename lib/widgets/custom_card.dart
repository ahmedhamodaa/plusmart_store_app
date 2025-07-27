import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:store_app/constants.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/views/update_product_view.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          () => Navigator.pushNamed(
            context,
            UpdateProductView.id,
            arguments: product,
          ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,

        children: [
          // Card (bottom layer)
          Positioned(
            bottom: 0,
            child: SizedBox(
              height: 120,
              width: MediaQuery.sizeOf(context).width / 2 - 24,
              child: Card(
                // elevation: 16,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 132,
                            height: 24,
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              product.title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: kColor900,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${product.price}\$',
                            style: TextStyle(fontSize: 16, color: kColor500),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Container (top layer, positioned above the card)
          Positioned(
            bottom: 68,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                product.image,
                height: 120,
                width: 120,
                errorBuilder:
                    (context, error, stackTrace) => Image.asset(
                      'assets/logo_icon.png',
                      height: 120,
                      width: 120,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
