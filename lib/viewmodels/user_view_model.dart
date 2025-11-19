import 'package:flutter/material.dart';
import '../models/user.dart';

// Provider que maneja el estado del CRUD de usuarios.
class UserViewModel extends ChangeNotifier {
  // Lista interna de usuarios.
  final List<User> _users = [];

  // Getter para exponer la lista sin permitir modificación directa.
  List<User> get users => _users;

  // Agregar usuario nuevo.
  void addUser(User user) {
    _users.add(user);
    notifyListeners(); // Notifica a la UI que hay cambios.
  }

  // Editar usuario según índice.
  void updateUser(int index, User newUser) {
    _users[index] = newUser;
    notifyListeners();
  }

  // Eliminar usuario.
  void deleteUser(int index) {
    _users.removeAt(index);
    notifyListeners();
  }
}
