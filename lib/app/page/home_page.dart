import 'package:app_crud/app/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Lista de usuarios',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                children: [
                  const Spacer(),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.blue),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          TextEditingController _textController =
                              TextEditingController();

                          return AlertDialog(
                            title: const Text(
                              'Ingrese el nombre',
                              textAlign: TextAlign.center,
                            ),
                            content: TextField(
                              controller: _textController,
                              decoration:
                                  const InputDecoration(hintText: 'Nombre'),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancelar'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  String userName = _textController.text;
                                  if (userName.isNotEmpty) {
                                    controller.createUser(userName);
                                    Navigator.of(context).pop();
                                  }
                                },
                                child: const Text('Crear usuario'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text(
                      'CREAR',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                ],
              ),
              Obx(() => Expanded(
                    child: ListView.builder(
                      itemCount: controller.users.length,
                      itemBuilder: (BuildContext context, int index) {
                        final String userName = controller.users[index].name;
                        return Card(
                          child: ListTile(
                            title: Text(userName),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.green,
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        TextEditingController _textController =
                                            TextEditingController(
                                                text: controller
                                                    .users[index].name);

                                        return AlertDialog(
                                          title: const Text(
                                            'Editar usuario',
                                            textAlign: TextAlign.center,
                                          ),
                                          content: TextField(
                                            controller: _textController,
                                            decoration: const InputDecoration(
                                                hintText: 'Nombre'),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Cancelar'),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                String updatedName =
                                                    _textController.text;
                                                if (updatedName.isNotEmpty) {
                                                  controller.updateUser(
                                                      controller.users[index],
                                                      updatedName);
                                                  Navigator.of(context).pop();
                                                }
                                              },
                                              child: const Text('Guardar'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text(
                                              "Confirmar eliminación"),
                                          content: const Text(
                                              "¿Estás seguro de que deseas eliminar este usuario?"),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text("Cancelar"),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                controller.deleteUser(
                                                    controller.users[index]);
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text("Eliminar"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
