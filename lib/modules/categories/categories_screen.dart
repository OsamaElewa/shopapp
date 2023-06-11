import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/categories_model/categories_model.dart';
import 'package:shopapp/models/home_model/home_model.dart';
import 'package:shopapp/modules/category_details/category_details.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/cubit/cubit.dart';
import 'package:shopapp/shared/cubit/states.dart';

class CategoriesScreen extends StatelessWidget {
   const CategoriesScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit=ShopCubit.get(context).categoriesModel;
        return ListView.separated(
          physics: BouncingScrollPhysics(),
            itemBuilder: (context,index)=>buildCategory(cubit!.data!.data[index],context),
            separatorBuilder: (context,index)=> myDivider(),
            itemCount: cubit!.data!.data.length,
        );
      },
    );
  }
}

Widget buildCategory(DataModel model,context)=>
    Padding(
  padding: const EdgeInsets.all(20.0),
  child:
          GestureDetector(
            onTap: (){
              //ShopCubit.get(context).getCategoryDetails(id: model.id!);
              //ProductsModel catDetail;
              // catDetail=ShopCubit.get(context).categoryDetail!;
              Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryDetailScreen(model.id!)));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
               Image(
                image: NetworkImage(
                  model.image!,
                ), height:80,
                width: 80,
              ),
              const SizedBox(width: 20,),
               Expanded(
                 child: Text(model.name!,style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
              ),
                   maxLines: 2,

                 ),
               ),
              //const Spacer(),
              IconButton(
                onPressed: (){},
                icon: const Icon(Icons.arrow_forward_ios),
              ),
            ],
    ),
          ),
     );
