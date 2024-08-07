import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_grocery/features/cart/ui/cart.dart';
import 'package:flutter_grocery/features/home/bloc/home_bloc.dart';
import 'package:flutter_grocery/features/home/ui/product_tile_widget.dart';
import 'package:flutter_grocery/features/wishlist/ui/wishlist.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    super.initState();
    homeBloc.add(HomeInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Cart()));
        } else if (state is HomeNavigateToWishlistPageActionState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Wishlist()));
        } else if (state is HomeProductCartedItemActionState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Items Carted')));
        } else if (state is HomeProductItemWishlistedActionState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Items Wishlisted')));
        }
      },
      builder: (context, state) {
        if (state is HomeLoadingState) {
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is HomeLoadedSuccessState) {
          final successState = state as HomeLoadedSuccessState;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey.shade300,
              title: const Text("Grocery App"),
              actions: [
                IconButton(
                    onPressed: () {
                      homeBloc.add(HomeWishlistButtonNavigateEvent());
                    },
                    icon: const Icon(Icons.favorite_border)),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                    onPressed: () {
                      homeBloc.add(HomeCartButtonNavigateEvent());
                    },
                    icon: const Icon(Icons.shopping_cart_checkout_sharp)),
              ],
            ),
            body: ListView.builder(
                itemCount: successState.products.length,
                itemBuilder: (context, index) {
                  return ProductTileWidget(
                    productDataModel: successState.products[index],
                    homeBloc: homeBloc,
                  );
                }),
          );
        } else if (state is HomeErrorState) {
          return const Scaffold(
              body: Center(
                  child: Text('Error', style: TextStyle(color: Colors.white))));
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
