import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/home_model/home_model.dart';
import 'package:shopapp/shared/cubit/cubit.dart';
import 'package:shopapp/shared/cubit/states.dart';

import '../../shared/components/components.dart';

class ProductDetails extends StatelessWidget {
  ProductsModel model;

  ProductDetails(this.model);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if(state is ShopSuccessChangeFavoritesState){
          if(state.model.status==false){
            showToast(text: state.model.message!, state: ToastState.ERROR);
          }
          else{
            showToast(text: state.model.message!, state: ToastState.SUCCESS);
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                CarouselSlider(
                  items: model.images!
                      .map((e) => Image(
                            image: NetworkImage(e),
                            width: double.infinity,
                          ))
                      .toList(),
                  options: CarouselOptions(),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(model.name!),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(model.description!,style: const TextStyle(color: Colors.white),)),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            ShopCubit.get(context).addDeleteCarts(model.id!);
                          },
                          child: Row(
                            children: const [
                              Icon(
                                Icons.shopping_cart,
                                color: Colors.white,
                              ),
                              Text(
                                'ADD TO CART',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      MaterialButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(model.id!);
                        },
                        child: Row(
                          children: const [
                            Icon(
                              Icons.favorite,
                              color: Colors.blue,
                            ),
                            Text(
                              'ADD TO FAV',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          //  Center(child: Text(model.name!,style: const TextStyle(fontSize: 20),)),
        );
      },
    );
  }
}
