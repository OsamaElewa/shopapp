
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/categories_model/categories_model.dart';
import 'package:shopapp/models/home_model/home_model.dart';
import 'package:shopapp/modules/product_details/product_details.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/cubit/cubit.dart';
import 'package:shopapp/shared/cubit/states.dart';
import 'package:shopapp/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

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
        var cubit = ShopCubit.get(context).homeModel;
        var cubit1=ShopCubit.get(context).categoriesModel;
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoriesModel!=null,
          builder: (context) => buildProducts(cubit!, cubit1!,context),
          fallback: (context) =>
          const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

Widget buildProducts(HomeModel model, CategoriesModel categoriesModel,context) =>
    SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: model.data?.banners
                .map((e) =>
                Image(
                  image: NetworkImage('${e.image}'),
                  width: double.infinity,
                  fit: BoxFit.cover,
                ))
                .toList(),
            options: CarouselOptions(
              height: 250.0,
              initialPage: 0,
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
          ),
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Categories',
                  style: TextStyle(fontSize: 24,
                      fontWeight: FontWeight.w800),),
                //listview Categories
                Container(
                  height: 100,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index)=>buildCategory(categoriesModel.data!.data[index]),
                      separatorBuilder: (context,index)=>const SizedBox(width: 10,),
                      itemCount: categoriesModel.data!.data.length),
                ),
                const SizedBox(height: 25,),
                const Text('New Product',
                  style: TextStyle(fontSize: 24,
                      fontWeight: FontWeight.w800),),
              ],
            ),
          ),
          const SizedBox(height: 20,),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 1.0,
              mainAxisSpacing: 1.0,
              childAspectRatio: 1 / 1.62,
              children: List.generate(model.data!.products.length,
                      (index) =>
                      buildProductItem(model.data!.products[index],context)
              ),
            ),
          ),

        ],
      ),
    );

Widget buildCategory(DataModel model) =>
    Stack(
      alignment: Alignment.bottomCenter,
      children: [
         Image(image: NetworkImage(model.image!),
          height: 100,
          width: 100,),
        Container(
          color: Colors.black.withOpacity(.8),
          width: 100,
          child:  Text(model.name!,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(color: Colors.white),),
        ),
      ],
    );

Widget buildProductItem(ProductsModel model,context) =>
    GestureDetector(
      onTap: (){
        //ShopCubit.get(context).getProductDetails(id: model.id!);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetails(model)));
      },
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image(
                  image: NetworkImage(model.image!),
                  width: double.infinity,
                  height: 200.0,
                ),
                if(model.discount != 0 || model.discount != model.discount)
                  Container(
                    color: Colors.red,
                    child: const Text('Discount',
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.white,
                      ),),
                  )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(fontSize: 14, height: 1.3),
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.price}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: defaultColor,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      if(model.oldPrice != 0 || model.oldPrice != model.oldPrice)
                        Text(
                          '${model.oldPrice}',
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(model.id!);
                        },
                        icon:  CircleAvatar(
                          backgroundColor:ShopCubit.get(context).favorites[model.id]! ? defaultColor : Colors.grey,
                          radius: 25,
                          child: const Icon(
                            Icons.favorite_border,color: Colors.white,
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
