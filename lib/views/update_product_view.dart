import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/services/update_product_service.dart';
import 'package:store_app/widgets/custom_text_field.dart';

class UpdateProductView extends StatefulWidget {
  UpdateProductView({super.key});

  static String id = 'update';

  @override
  State<UpdateProductView> createState() => _UpdateProductViewState();
}

class _UpdateProductViewState extends State<UpdateProductView> {
  String? productName, description, price, image;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    ProductModel product =
        ModalRoute.of(context)!.settings.arguments as ProductModel;
    return ModalProgressHUD(
      progressIndicator: CircularProgressIndicator(),
      inAsyncCall: isLoading,
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              spacing: 10,
              children: [
                CustomTextField(
                  onChanged: (data) {
                    productName = data;
                  },
                  hintText: 'Product Name',
                ),
                CustomTextField(
                  onChanged: (data) {
                    description = data;
                  },
                  hintText: 'Description',
                ),
                CustomTextField(
                  onChanged: (data) {
                    price = data;
                  },
                  hintText: 'Price',
                  type: TextInputType.number,
                ),
                CustomTextField(
                  onChanged: (data) {
                    image = data;
                  },
                  hintText: 'Image',
                ),
                SizedBox(height: 10),
                FilledButton(
                  onPressed: () async {
                    isLoading = true;
                    setState(() {});
                    try {
                      await updateProduct(product);
                      print('success');
                    } on Exception catch (e) {
                      print(e.toString());
                    }
                    isLoading = false;
                    setState(() {});

                    // Navigator.pop(context);
                  },
                  child: Text('Update product'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> updateProduct(ProductModel product) async {
    await UpdateProductService().updateProduct(
      title: productName ?? product.title,
      price: price ?? product.price.toString(),
      description: description ?? product.description,
      image: image ?? product.image,
      category: product.category,
      id: product.id,
    );
  }
}
