// import 'package:flutter/material.dart';
// import 'package:operation_cubit/operation_page.dart';

// class RegisteringPage extends OperationPage<Registering> {
//   RegisteringPage({
//     super.key,
//     required super.operation,
//   }) : super(
//             baseBuilder: (context, state) {
//               return Scaffold(
//                   appBar: AppBar(
//                     automaticallyImplyLeading: false,
//                     title: Text(
//                       'Registro',
//                       style: Theme.of(context).textTheme.displayLarge,
//                     ),
//                     centerTitle: true,
//                     backgroundColor: const Color.fromARGB(255, 198, 198, 198),
//                   ),
//                   body: const Column(
//                     children: [
//                       Row(children: [Text('Nombre de usuario:'), TextField()]),
//                       Row(children: [Text('Nombre:'), TextField()]),
//                       Row(children: [Text('email:'), TextField()]),
//                       Row(children: [Text('Contraseña:'), TextField()]),
//                       Row(children: [Text('Nombre de usuario:'), TextField()]),
//                     ],
//                   ),
//                   bottomNavigationBar: Row(
//                     children: [
//                       ElevatedButton(
//                           onPressed: () => {}, child: const Text('Cancelar')),
//                       ElevatedButton(
//                           onPressed: () => {}, child: const Text('Guardar'))
//                     ],
//                   ));
//             },
//             notificationListener: (context, state) {});
// }
