import 'package:flutter/material.dart';
import 'package:flutter_grocery/features/cart/bloc/cart_bloc.dart';
import 'package:flutter_grocery/features/home/models/home_product_data_model.dart';

class CartTileWidget extends StatelessWidget {
  const CartTileWidget(
      {super.key, required this.productDataModel, required this.cartBloc});
  final ProductDataModel productDataModel;
  final CartBloc cartBloc;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.maxFinite,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(productDataModel.imageUrl),
                    fit: BoxFit.cover)),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            productDataModel.name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(productDataModel.description),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$ " + productDataModel.price.toString(),
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        // cartBloc.add(HomeProductWishlistButtonClickedEvent(
                        //     clickedProduct: productDataModel));
                      },
                      icon: const Icon(Icons.favorite_border)),
                  IconButton(
                      onPressed: () {
                        cartBloc.add(CartRemoveFromCartEvent(
                          productDataModel: productDataModel,
                        ));
                      },
                      icon: const Icon(Icons.shopping_bag)),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
