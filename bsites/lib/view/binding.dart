import 'package:bsites/controller/user.dart';
import 'package:get/get.dart';

class LoginBinding implements Bindings{
  @override
  void dependencies() {
      Get.lazyPut<Users>(() => Users());
  }


}