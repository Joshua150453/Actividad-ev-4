import 'package:flutter/material.dart';
import 'user_list_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // GlobalKey para manejar el formulario completo.
  final _formKey = GlobalKey<FormState>();

  // Variables donde se guardarán los valores usando onSaved.
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,     // Asocia este formulario con la key.
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              const SizedBox(height: 30),

              // ===============================
              // CAMPO EMAIL
              // ===============================
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Correo',
                  prefixIcon: Icon(Icons.email),
                ),
                // VALIDACIONES del campo.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El correo es obligatorio';
                  }
                  if (!value.contains('@')) {
                    return 'Debe ser un correo válido';
                  }
                  return null;    // Si todo OK, retorna null.
                },
                onSaved: (value) => _email = value!,  // Guarda el valor final.
              ),

              const SizedBox(height: 16),

              // ===============================
              // CAMPO PASSWORD
              // ===============================
              TextFormField(
                obscureText: true,   // Oculta caracteres.
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  prefixIcon: Icon(Icons.lock),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'La contraseña es obligatoria';
                  }
                  // Validación mínima de longitud.
                  if (value.length < 6) {
                    return 'Debe tener al menos 6 caracteres';
                  }
                  // Validación extra: mayúsculas.
                  if (!value.contains(RegExp(r'[A-Z]'))) {
                    return 'Debe tener al menos una mayúscula';
                  }
                  // Validación extra: números.
                  if (!value.contains(RegExp(r'[0-9]'))) {
                    return 'Debe tener al menos un número';
                  }
                  return null;
                },
                onSaved: (value) => _password = value!,
              ),

              const SizedBox(height: 10),

              // Enlace de "olvidaste contraseña"
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text("¿Olvidaste tu contraseña?"),
                ),
              ),

              const SizedBox(height: 20),

              // ===============================
              // BOTÓN INGRESAR
              // ===============================
              ElevatedButton(
                onPressed: () {
                  // Valida todos los campos del formulario.
                  if (_formKey.currentState!.validate()) {
                    // Ejecuta todos los onSaved().
                    _formKey.currentState!.save();

                    // Navegar y enviar el email.
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => UserListScreen(email: _email),
                      ),
                    );
                  }
                },
                child: const Text('Ingresar'),
              ),

              const SizedBox(height: 10),

              // Botón crear cuenta
              OutlinedButton(
                onPressed: () {},
                child: const Text("Crear cuenta"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
