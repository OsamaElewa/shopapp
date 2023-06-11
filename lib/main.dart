import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shopapp/layouts/shop_layout.dart';
import 'package:shopapp/modules/login/login_screen.dart';
import 'package:shopapp/modules/register/cubit/register_cubit.dart';
import 'package:shopapp/shared/bloc_observer.dart';
import 'package:shopapp/shared/constants/constants.dart';
import 'package:shopapp/shared/cubit/cubit.dart';
import 'package:shopapp/shared/network/local/cache_helper.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';
import 'package:shopapp/shared/styles/colors.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer=MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  token=CacheHelper.getData(key: 'token');
  print(token);
  if(token!=null)
  {
    widget=const ShopLayout();
  }
  else{
    widget=LoginScreen();
  }

  runApp(MyApp(widget,));
}

class MyApp extends StatelessWidget {

  final Widget startWidget;
  MyApp(this.startWidget,);
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context)=>ShopCubit()..getHomeData()..getCategories()..getFavorites()..getProfile()..getCarts(),
        ),
        BlocProvider(
          create:(BuildContext context)=>ShopRegisterCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: const TextTheme(
              bodyLarge: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              )
          ),
          primarySwatch: defaultColor,
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            elevation: 20.0,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: defaultColor,
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: defaultColor,
          ),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark
              ),
              color: Colors.white,
              elevation: 0.0,
              iconTheme: IconThemeData(
                  color: Colors.black,size: 30.0
              ),
              titleTextStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              )
          ),

        ),
        darkTheme: ThemeData(
          textTheme: const TextTheme(
              bodyText1: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              )
          ),
          primarySwatch: defaultColor,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            elevation: 20.0,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: defaultColor,
            unselectedItemColor: Colors.grey,
            backgroundColor: HexColor('333739'),
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: defaultColor,
          ),
          scaffoldBackgroundColor: HexColor('333739'),
          appBarTheme: AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor('333739'),
                  statusBarIconBrightness: Brightness.light
              ),
              backgroundColor: HexColor('333739'),
              elevation: 0.0,
              iconTheme: const IconThemeData(
                  color: Colors.white,size: 30.0
              ),
              titleTextStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )
          ),
        ),
        home: startWidget,
      ),
    );
  }
}