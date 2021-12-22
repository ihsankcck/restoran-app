import 'package:flutter/material.dart';
import 'package:restoran/api.dart';
import 'package:restoran/entities/products.dart';
import 'package:restoran/widgets/product_item.dart';

class ProductsView extends StatelessWidget {
  final int categoryId;

  // ignore: use_key_in_widget_constructors
  const ProductsView({required this.categoryId}) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<ProductModel>>(
        builder: (context, productSnap) {
          if (productSnap.connectionState == ConnectionState.none &&
              productSnap.hasData) {
            //print('project snapshot data is: ${productSnap.data}');
            return Container();
          }

          if (productSnap.hasData) {
            return ListView.builder(
              itemCount: productSnap.hasData ? productSnap.data?.length : 0,
              itemBuilder: (context, index) {
                ProductModel? product = productSnap.data![index];
                return Column(
                  children: <Widget>[
                    ProductItem(
                      img:
                          "https://raw.githubusercontent.com/ihsankcck/restorant-api/main/img/${product.img}",
                      name: product.name,
                      price: product.price,
                      key: ObjectKey(product),
                    )
                  ],
                );
              },
            );
          }

          return const CircularProgressIndicator();
        },
        future: fetchProducts(categoryId),
      ),
    );
  }
}
