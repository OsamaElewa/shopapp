import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modules/cart_screen/cart_screen.dart';
import 'package:shopapp/modules/search/search_screen.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/constants/constants.dart';
import 'package:shopapp/shared/cubit/cubit.dart';
import 'package:shopapp/shared/cubit/states.dart';

class ShopLayout extends StatelessWidget {
   const ShopLayout({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return
      BlocConsumer<ShopCubit,ShopStates>(
        listener:(context,state){},
        builder: (context,state){
          var cubit=ShopCubit.get(context);
          return
            Scaffold(
            appBar: AppBar(
              title: const Text('Matgar'),
              actions: [
                IconButton(
                    onPressed: (){
                      //signOut(context);
                    },
                    icon: const Icon(Icons.search),
                ),
                IconButton(
                    onPressed: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>CartScreen()));
                    },
                    icon: const Icon(Icons.shopping_cart),
                )
              ],
            ),
            body : cubit.bottomScreen[cubit.currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.currentIndex,
                onTap: (index){
                  cubit.changeIndex(index);
                },
                items: const [
                  BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
                  BottomNavigationBarItem(icon: Icon(Icons.apps),label: 'Category'),
                  BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Favorites'),
                  BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings'),
                ],
                
              ),
          );
        },
      );
  }
}
