import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/user_view_model.dart';
import '../models/user.dart';

class UserListScreen extends StatelessWidget {
  final String email;  // Email recibido desde Login.

  const UserListScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    // Obtiene el provider para acceder a users[].
    final userVM = Provider.of<UserViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        // Muestra el email recibido.
        title: Text('Bienvenido: $email'),
      ),

      // Lista dinámica de usuarios
      body: ListView.builder(
        itemCount: userVM.users.length,
        itemBuilder: (context, index) {
          final u = userVM.users[index];

          return ListTile(
            title: Text(u.name),
            subtitle: Text("Edad: ${u.age}"),

            // Acciones de editar/eliminar
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // EDITAR
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    _showUserForm(context, userVM, index, u);
                  },
                ),

                // ELIMINAR
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    userVM.deleteUser(index);
                  },
                ),
              ],
            ),
          );
        },
      ),

      // BOTÓN flotante para agregar nuevo usuario
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showUserForm(context, userVM, null, null);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // ===========================================
  // FORMULARIO EMERGENTE (AGREGAR/EDITAR USUARIO)
  // ===========================================
  void _showUserForm(
      BuildContext context, UserViewModel userVM, int? index, User? user) {
    
    // Si es edición, cargamos los datos existentes.
    final nameController = TextEditingController(text: user?.name ?? '');
    final ageController =
        TextEditingController(text: user != null ? user.age.toString() : '');

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(index == null ? "Agregar usuario" : "Editar usuario"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Campo nombre
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Nombre"),
            ),

            // Campo edad
            TextField(
              controller: ageController,
              decoration: const InputDecoration(labelText: "Edad"),
              keyboardType: TextInputType.number,
            ),
          ],
        ),

        // Botones de acción
        actions: [
          TextButton(
            child: const Text("Cancelar"),
            onPressed: () => Navigator.pop(context),
          ),

          ElevatedButton(
            child: Text(index == null ? "Agregar" : "Guardar"),
            onPressed: () {
              final n = nameController.text;
              final a = int.tryParse(ageController.text) ?? 0;

              // Nuevo usuario o actualización
              if (index == null) {
                userVM.addUser(User(name: n, age: a));
              } else {
                userVM.updateUser(index, User(name: n, age: a));
              }

              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
