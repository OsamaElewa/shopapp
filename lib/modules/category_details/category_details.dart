import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modules/category_details/cubit/category_cubit.dart';
import 'package:shopapp/modules/category_details/cubit/category_state.dart';
import 'package:shopapp/modules/product_details/product_details2.dart';

import '../../models/category_details/category_details_model.dart';
import '../../shared/components/components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/styles/colors.dart';

class CategoryDetailScreen extends StatelessWidget {
  int id;

  CategoryDetailScreen(this.id);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          CategoryCubit()..getCategoryDetails(id: id),
      child: BlocConsumer<CategoryCubit, CategoryStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = CategoryCubit.get(context).categoryDetailModel;
          return Scaffold(
            appBar: AppBar(),
            body: ConditionalBuilder(
              condition: CategoryCubit.get(context).categoryDetailModel != null,
              builder: (context) => ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      buildCatItem(cubit!.data!.data![index], context),
                  separatorBuilder: (context, index) => myDivider(),
                  itemCount: cubit!.data!.data!.length),
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
            ),
          );
        },
      ),
    );
  }
}

// Widget buildCatList(CategoryDetailsModel model)=>ListView.separated(
//     physics: const BouncingScrollPhysics(),
//     itemBuilder:(context,index)=> buildCatItem(model.data!.data![index]),
//     separatorBuilder:(context, index) => myDivider(),
//     itemCount: model.data!.data!.length);

Widget buildCatItem(CategoryDataModel model, context) => GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ProductDetails2(model)));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: 120,
          child: Row(
            children: [
              Stack(
                children: [
                  Image(
                    image: NetworkImage(model.image!),
                    width: 120,
                    height: 120,
                  ),
                  Container(
                    color: Colors.red,
                    child: Text(
                      '${model.discount!}',
                      style: const TextStyle(
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
                      model.name!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(fontSize: 14, height: 1.3),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Text(
                          '${model.price!}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: defaultColor,
                          ),
                        ),

                        const SizedBox(
                          width: 5,
                        ),

                        Text(
                          '${model.oldPrice!}',
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),

                        const Spacer(),

                        // IconButton(

                        //   onPressed: () {

                        //     //ShopCubit.get(context).changeFavorites(model.id!);

                        //   },

                        //   icon:  const CircleAvatar(

                        //     //ShopCubit.get(context).favorites[model.id]! ? defaultColor : Colors.grey

                        //     backgroundColor:defaultColor,

                        //     radius: 25,

                        //     child: Icon(

                        //       Icons.favorite_border,

                        //       color: Colors.white,

                        //     ),

                        //   ),

                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
