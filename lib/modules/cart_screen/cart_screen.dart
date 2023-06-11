import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/cart_model/cart_model.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/cubit/cubit.dart';

import '../../shared/cubit/states.dart';
import '../../shared/styles/colors.dart';

class CartScreen extends StatelessWidget {
   CartScreen({Key? key}) : super(key: key);

  int myQuantity=1;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            title: const Text('Shopping Cart'),
            centerTitle: true,
          ),
          body: Column(
            children: [
              ConditionalBuilder(
                condition: state is! ShopLoadingGetCartsState ,

                builder:(context)=> Expanded(
                  child: ShopCubit.get(context).cartModel!.data!.cartItems!.isNotEmpty? ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context,index)=>buildCartItem(ShopCubit.get(context).cartModel!.data!.cartItems![index],context),
                    separatorBuilder: (context,index)=>myDivider(),
                    itemCount: ShopCubit.get(context).cartModel!.data!.cartItems!.length,
                  ) : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.add_shopping_cart,
                            size: 100,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'shopping cart is empty, add some items',
                            style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                ),
                fallback:(context) => const CircularProgressIndicator(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 25),
                      child: Row(
                        children: [
                          const Text('total price : '),
                          Text(ShopCubit.get(context).cartModel!.data!.total.toString(),style: const TextStyle(color: Colors.blue),),
                        ],
                      ),
                    ),
                    const Spacer(),
                    MaterialButton(
                      color: Colors.blue,
                      height: 60,
                      child: const Text('continue purchase',style: TextStyle(color: Colors.white),),
                        onPressed: (){}
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
         );
  }
}

Widget buildCartItem(CartItemsModel model,context)=>Padding(
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
                  GestureDetector(
                    onTap: (){

                    },
                    child: GestureDetector(
                      onTap: (){
                        print(model.id);
                        ShopCubit.get(context).increaseQuantity();
                        ShopCubit.get(context).updateCart(quantity: ShopCubit.get(context).incQuant, cartProdId: model.id!);
                      },
                      child: Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: Colors.blue),
                        ),
                        child: const Icon(Icons.add,color: Colors.blue,),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Text(model.quantity.toString()),
                  const SizedBox(width: 10,),
                  GestureDetector(
                    onTap: (){
                      ShopCubit.get(context).decreseQuantity();
                      ShopCubit.get(context).updateCart(quantity: ShopCubit.get(context).incQuant, cartProdId: model.id!);
                    },
                    child: Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.blue),
                      ),
                      child: const Icon(Icons.remove,color: Colors.blue,),
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
