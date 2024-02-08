import 'package:app_crud/app/database/user_dao.dart';
import 'package:app_crud/app/models/user_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxList<UserModel> users = RxList([]);
  final daoUser = UserDao();

  @override
  void onInit() {
    refreshdata();
    super.onInit();
  }

  refreshdata() {
    daoUser.readAll().then((value) {
      print(value);
      users.value = value;
    });
  }

  deleteUser(UserModel user) {
    daoUser.delete(user);
    refreshdata();
  }

  createUser(String name) {
    daoUser.insert(UserModel(name: name));
    refreshdata();
  }

  updateUser(UserModel user, String newName){
     daoUser.update(UserModel(id: user.id, name: newName));
    refreshdata();
  }
}
