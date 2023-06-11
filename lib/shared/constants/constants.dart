//CacheHelper.clearData(key: 'token').then((value){
//                   navigateAndFinish(context,LoginScreen());

import '../../modules/login/login_screen.dart';
import '../components/components.dart';
import '../network/local/cache_helper.dart';

void signOut(context)
{
  CacheHelper.clearData(key: 'token').then((value){
    navigateAndFinish(context,LoginScreen());
 });
}
var token;