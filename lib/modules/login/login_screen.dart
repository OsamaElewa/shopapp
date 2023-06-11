import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layouts/shop_layout.dart';
import 'package:shopapp/modules/login/cubit/login_cubit.dart';
import 'package:shopapp/modules/login/cubit/login_state.dart';
import 'package:shopapp/modules/register/register_screen.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/constants/constants.dart';
import 'package:shopapp/shared/network/local/cache_helper.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginState>(
        listener: (context, state) {
          if(state is ShopLoginSuccessState)
          {
            if(state.shopLoginModel.status==true){
              print(state.shopLoginModel.message);
              print(state.shopLoginModel.data?.token);
              CacheHelper.saveData(key: 'token', value: state.shopLoginModel.data?.token).then((value){
                token= state.shopLoginModel.data!.token!;
                navigateAndFinish(context, ShopLayout());
                showToast(text: '${state.shopLoginModel.message}', state: ToastState.SUCCESS);
              });
            }

            else{
              print(state.shopLoginModel.message);
              showToast(text: '${state.shopLoginModel.message}', state: ToastState.ERROR);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 40.0,
                        ),
                        const Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        const Text(
                          'login now to browse out hot offers',
                          style: TextStyle(fontSize: 20.0, color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          onFieldSubmitted: (value) {
                            print(value);
                          },
                          onChanged: (value) {
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
                            prefixIcon: Icon(
                              Icons.email,
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: ShopLoginCubit.get(context).isPasswordShown,
                          onFieldSubmitted: (value) {
                            print(value);
                          },
                          onChanged: (value) {
                            print(value);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'password must not be empty';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: const Icon(
                              Icons.lock,
                            ),
                            suffixIcon: IconButton(
                              icon:Icon(ShopLoginCubit.get(context).suffix),
                              onPressed: () {
                                ShopLoginCubit.get(context).changeVisibility();
                                // setState(() {
                                //   ispassword=! ispassword;
                                // });
                              },
                            ),
                            border: const OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        ConditionalBuilder(
                          condition: state is!ShopLoginLoadingState,
                          builder:(context)=> Container(
                            width: double.infinity,
                            color: Colors.blue,
                            child: MaterialButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  ShopLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                  print(emailController.text);
                                  print(passwordController.text);
                                }

                              },
                              child: const Text(
                                'LOGIN',
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
                          fallback: (context)=> const Center(child: CircularProgressIndicator(),),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account',
                            ),
                            TextButton(
                              onPressed: () {
                                navigateTo(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
                              },
                              child: const Text(
                                'REGISTER NOW',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
