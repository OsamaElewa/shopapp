import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/favorites_model/favorites_model.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/cubit/cubit.dart';
import 'package:shopapp/shared/cubit/states.dart';

import '../../shared/styles/colors.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoritesState,
          builder: (context) => ShopCubit.get(context)
                  .favoritesModel!
                  .data!
                  .data!
                  .isNotEmpty
              ? ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => buildFavItem(
                      ShopCubit.get(context).favoritesModel!.data!.data![index],
                      context),
                  separatorBuilder: (context, index) => myDivider(),
                  itemCount:
                      ShopCubit.get(context).favoritesModel!.data!.data!.length,
                )
              : Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.favorite_border,
                      size: 100,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'favorite list is empty, add some items',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
          fallback: (context) => const CircularProgressIndicator(),
        );
      },
    );
  }
}

Widget buildFavItem(FavoritesData model, context) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120,
      child: Row(
        children: [
          Stack(
            children: [
              Image(
                image: NetworkImage(model.product!.image!),
                width: 120,
                height: 120,
              ),
              if (model.product!.discount! != 0 ||
                  model.product!.discount! != 0)
                Container(
                  color: Colors.red,
                  child: const Text(
                    'Discount',
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.white,
                    ),
                  ),
                )
            ],
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.product!.name!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(fontSize: 14, height: 1.3),
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    Text(
                      model.product!.price!.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        color: defaultColor,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    if (model.product!.oldPrice != 0 ||
                        model.product!.oldPrice != model.product!.price)
                        Text(
                          model.product!.oldPrice!.toString(),
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        ShopCubit.get(context)
                            .changeFavorites(model.product!.id!);
                      },
                      icon: CircleAvatar(
                        backgroundColor: ShopCubit.get(context)
                                .favorites[model.product!.id!]!
                            ? defaultColor
                            : Colors.grey,
                        radius: 25,
                        child: const Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
