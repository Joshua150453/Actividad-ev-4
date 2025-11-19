# Descripción General del Proyecto – Login + CRUD + Provider en Flutter
# Alumno: Joshua David Ortiz Rosas
Este proyecto implementa una pantalla de Login con validaciones profesionales utilizando Form, GlobalKey<FormState>, validator, onSaved, navegación con Navigator.push y envío de datos entre pantallas. Después del Login, el usuario accede a una pantalla CRUD gestionada con Provider, que además recibe y muestra el correo ingresado durante el login como parte de la integración entre ambas pantallas. Las actividades extra están completamente implementadas: validación avanzada de contraseña, elementos adicionales de UI ("Crear cuenta" y "¿Olvidaste tu contraseña?"), y el AppBar personalizado con el email del usuario.

[Archico_principal](https://github.com/Joshua150453/Actividad-ev-4/tree/main/lib)

## 📂 1. main.dart
El archivo main.dart es el punto de entrada de la aplicación. Aquí se inicializa el UserViewModel mediante ChangeNotifierProvider, permitiendo manejar el estado global del CRUD. También se configura el widget principal MyApp, donde se define el tema, el título de la aplicación y la pantalla inicial, que en este caso es LoginScreen. Este archivo establece la base de todo el flujo, conectando la lógica del Provider con la interfaz y habilitando la navegación posterior.

## 📂 2. models/user.dart
El archivo user.dart define el modelo de datos User, que representa cada usuario utilizado en el CRUD. Este modelo contiene atributos simples como nombre y edad, permitiendo manipular instancias de usuarios dentro del Provider. Aunque es un archivo pequeño, estandariza la estructura de los datos y facilita que el CRUD opere sobre objetos bien definidos, lo cual es esencial para mantener orden y escalabilidad en el proyecto.

## 📂 3. viewmodels/user_view_model.dart
user_view_model.dart contiene la lógica de negocio del CRUD utilizando ChangeNotifier. Aquí se almacenan los usuarios en una lista privada y se implementan métodos para agregar, actualizar y eliminar usuarios. Cada operación llama a notifyListeners(), lo que actualiza automáticamente cualquier vista que esté escuchando el estado. Es la pieza central del patrón Provider dentro del proyecto, ya que separa la lógica del backend de la interfaz gráfica.

## 📂 4. views/login_screen.dart
En login_screen.dart se construye la pantalla de Login aplicando correctamente Form, validaciones con validator, y captura de datos con onSaved. El formulario verifica que el correo sea válido, que la contraseña tenga una longitud mínima, una mayúscula y al menos un número (actividad extra). Además, incluye mejoras visuales como el botón “Crear cuenta”, el texto “¿Olvidaste tu contraseña?”, espaciados uniformes y un diseño más claro. Al validar correctamente, el formulario ejecuta save() y se navega hacia UserListScreen, enviando el email ingresado sin usar rutas nombradas.

## 📂 5. views/user_list_screen.dart
El archivo user_list_screen.dart implementa la pantalla del CRUD conectada al Provider. Recibe el email desde el Login (actividad extra 3) y lo muestra en el AppBar para personalizar la experiencia del usuario. En esta pantalla se listan todos los usuarios, permitiendo agregarlos, editarlos o eliminarlos mediante un diálogo emergente. Utiliza Provider.of<UserViewModel> para acceder en tiempo real a la lista de usuarios y actualizar la interfaz automáticamente. Esta pantalla completa la integración entre el Login y el CRUD, demostrando un flujo funcional de autenticación + administración de datos.

### RESPUESTAS CORTAS A LAS PREGUNTAS IMPLÍCITAS
#### 1. ¿Cómo permiten Form y GlobalKey<FormState> validar de manera centralizada?
Porque agrupan todos los TextFormField en un solo contenedor y permiten ejecutar validate() y save() sobre todos al mismo tiempo.

#### 2. ¿Cuál es la función de validate() y onSaved() en el ciclo del formulario?
- validate() revisa todos los campos y muestra errores;
- onSaved() guarda los valores finales cuando todo es válido.

#### 3. ¿Cuál es la diferencia práctica entre TextEditingController y onSaved?
- controller sirve para leer/modificar texto en tiempo real;
- onSaved solo captura el valor final cuando envías el formulario.

#### 4. ¿Cuándo conviene usar cada uno?
Formulario simple como Login → onSaved.
Campos dinámicos o búsqueda en tiempo real → controller.

#### 5. ¿Qué integración se logró con el CRUD previo?
Se creó un flujo real: primero Login, luego se envía el correo a la pantalla CRUD y se muestra en el AppBar.
