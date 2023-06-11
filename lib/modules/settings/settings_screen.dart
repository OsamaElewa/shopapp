import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/shared/constants/constants.dart';
import 'package:shopapp/shared/cubit/cubit.dart';
import 'package:shopapp/shared/cubit/states.dart';
import 'package:shopapp/shared/styles/colors.dart';

import '../../shared/components/components.dart';

class SettingsScreen extends StatelessWidget {
   SettingsScreen({Key? key}) : super(key: key);
   var formKey = GlobalKey<FormState>();
  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var phoneController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){
        if(state is ShopSuccessGetProfileState){
          nameController.text=state.profileModel.data!.name!;
          emailController.text=state.profileModel.data!.email!;
          phoneController.text=state.profileModel.data!.phone!;
        }
      },
      builder: (context,state){
        var model=ShopCubit.get(context).profileModel;
        nameController.text=model!.data!.name!;
        emailController.text=model.data!.email!;
        phoneController.text=model.data!.phone!;
       // nameController.text=;
        return Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    onFieldSubmitted: (value) {
                      print(value);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email must not be empty';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 15,),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    onFieldSubmitted: (value) {
                      print(value);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email must not be empty';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 15,),
                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    onFieldSubmitted: (value) {
                      print(value);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email must not be empty';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Phone',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Container(
                    width: double.infinity,
                    color: Colors.blue,
                    child: MaterialButton(
                      onPressed: () {
                        signOut(context);
                        showToast(text: 'LOGOUT successfully Done', state: ToastState.SUCCESS);
                      },
                      child: const Text(
                        'LOGOUT',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    // MaterialButton(
                    //   onPressed:(){
                    //     if(formKey.currentState!.validate()) {
                    //       print(emailController.text);
                    //       print(passwordController.text);
                    //     }
                    //   },
                    //   child:const Text(
                    //     'LOGIN',
                    //     style: TextStyle(
                    //       color: Colors.white,
                    //     ),
                    //   ) ,
                    // ),
                  ),
                  const SizedBox(height: 15,),
                  Container(
                    width: double.infinity,
                    color: Colors.blue,
                    child: MaterialButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          ShopCubit.get(context).updateProfile(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                          );
                        }
                        showToast(text: 'UPDATE successfully Done', state: ToastState.SUCCESS);
                      },
                      child: const Text(
                        'UPDATE',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    // MaterialButton(
                    //   onPressed:(){
                    //     if(formKey.currentState!.validate()) {
                    //       print(emailController.text);
                    //       print(passwordController.text);
                    //     }
                    //   },
                    //   child:const Text(
                    //     'LOGIN',
                    //     style: TextStyle(
                    //       color: Colors.white,
                    //     ),
                    //   ) ,
                    // ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
