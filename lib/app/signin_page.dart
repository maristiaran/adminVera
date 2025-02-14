import 'package:flutter/material.dart';
import 'package:mini_vera/app/signin.dart';
import 'package:operation_cubit/operation_page.dart';

class SignInPage extends OperationPage<SignIn> {
  SignInPage({
    super.key,
    required super.operation,
  }) : super(
            baseBuilder: (context, state) {
              final formKey = GlobalKey<FormState>();
              final TextEditingController emailController =
                  TextEditingController();
              final TextEditingController passwordController =
                  TextEditingController();
              // signIn() {
              //   operation.signIn(emailController.text, passwordController.text);
              // }
              loginAndVerifyAdmin() {
                operation.adminSignIn(
                    emailController.text, passwordController.text);
              }

              return Scaffold(
                body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: formKey,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 150.0),
                        child: ListView(
                          children: [
                            const SizedBox(height: 80.0),
                            Text(
                              'Iniciar sesión IES 9-010',
                              style: Theme.of(context).textTheme.titleMedium,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 80.0),

                            // Campo de correo electrónico
                            TextFormField(
                              controller: emailController,
                              decoration: const InputDecoration(
                                  labelText: 'Correo electrónico'),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please insert your email';
                                }
                                return null;
                              },
                            ),

                            // Campo de contraseña
                            TextFormField(
                              controller: passwordController,
                              decoration: const InputDecoration(
                                  labelText: 'Contraseña'),
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, ingrese su contraseña';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 50.0),
                            SizedBox(
                              width: 200,
                              child: ElevatedButton.icon(
                                onPressed: loginAndVerifyAdmin,
                                icon: const Icon(Icons.account_circle),
                                label: const Text(
                                  'Iniciar sesión',
                                  textScaler: TextScaler.linear(0.8),
                                  // style: Theme.of(context).textTheme.titleSmall,
                                ),
                                // style: ElevatedButton.styleFrom(
                                //     foregroundColor: Colors.red),
                              ),
                            ),

                            const SizedBox(height: 10.0),

                            // Botón de inicio de sesión con Facebook
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
              // }
            }

            // String emailText = '';
            // String passwordText = '';
            // return LayoutBuilder(builder: (context, constrains) {
            //   return Scaffold(
            //       resizeToAvoidBottomInset: false,
            //       body: SafeArea(
            //         child: SingleChildScrollView(
            //             physics: const NeverScrollableScrollPhysics(),
            //             child: Padding(
            //               padding: const EdgeInsets.symmetric(
            //                   horizontal: 40, vertical: 150),
            //               child: Column(
            //                 children: [
            //                   Padding(
            //                     padding: const EdgeInsets.all(8.0),
            //                     child: TextField(
            //                       onChanged: ((value) => emailText = value),
            //                     ),
            //                   ),
            //                   Padding(
            //                     padding: const EdgeInsets.all(8.0),
            //                     child: TextField(
            //                       obscureText: true,
            //                       onChanged: ((value) =>
            //                           passwordText = value),
            //                     ),
            //                   ),
            //                   ElevatedButton(
            //                     onPressed: () async {
            //                       operation.signInWithUsernameOrEmail(
            //                           userNameOrEmail: emailText,
            //                           password: passwordText);
            //                     },
            //                     child: const Text(
            //                       'Iniciar Sesión',
            //                     ),
            //                   ),
            //                   Row(
            //                     mainAxisAlignment: MainAxisAlignment.center,
            //                     children: [
            //                       const Text("¿No tienes cuenta?"),
            //                       TextButton(
            //                         onPressed: () async {
            //                           operation.register();
            //                         },
            //                         child: Text(
            //                           'Registrate',
            //                           style: TextStyle(
            //                               color: Theme.of(context)
            //                                   .colorScheme
            //                                   .primary),
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                   TextButton(
            //                     onPressed: () async {
            //                       // IESSystem().startRecoveryPass();
            //                     },
            //                     child: Text(
            //                       '¿Olvidaste la contraseña?',
            //                       style: TextStyle(
            //                           color: Theme.of(context)
            //                               .colorScheme
            //                               .secondary),
            //                     ),
            //                   ),
            //                   ElevatedButton(
            //                     onPressed: () async {
            //                       operation.signInWithGoogle();
            //                     },
            //                     child: const Text(
            //                       'Acceder con Google',
            //                     ),
            //                   ),
            //                   ElevatedButton(
            //                     onPressed: () async {
            //                       operation.signInWithFacebook();
            //                     },
            //                     child: const Text(
            //                       'Acceder con Facebook',
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             )),
            //       ));
            // });

            ,
            notificationListener: (context, state) {});
}

// class SignInPage extends StatefulWidget {
//   const SignInPage({super.key});

//   // final _formKey = GlobalKey<FormState>();

//   @override
//   State<SignInPage> createState() => _SignInPageState();
// }

// class _SignInPageState extends State<SignInPage> {
//   String _emailText = '';
//   String _passwordText = '';
//   @override
//   Widget build(BuildContext context) {
//     // print('SignIn22-------');
//     return LayoutBuilder(builder: (context, constrains) {
//       return Scaffold(
//           resizeToAvoidBottomInset: false,
//           body: BlocBuilder<SignIn, OperationState>(builder: (context, state) {
//             return SafeArea(
//               child: SingleChildScrollView(
//                   physics: const NeverScrollableScrollPhysics(),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 40, vertical: 150),
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: TextField(
//                             onChanged: ((value) => _emailText = value),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: TextField(
//                             obscureText: true,
//                             onChanged: ((value) => _passwordText = value),
//                           ),
//                         ),
//                         ElevatedButton(
//                           onPressed: () async {
//                             Frutality().auth.SignIn.add(SignInWithUsernameOrEmail(
//                                 usernameOrEmail: _emailText,
//                                 password: _passwordText));
//                           },
//                           child: const Text(
//                             'Iniciar Sesión',
//                           ),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const Text("¿No tienes cuenta?"),
//                             TextButton(
//                               onPressed: () async {
//                                 Frutality().add(FERegistering());
//                               },
//                               child: Text(
//                                 'Registrate',
//                                 style: TextStyle(
//                                     color:
//                                         Theme.of(context).colorScheme.primary),
//                               ),
//                             ),
//                           ],
//                         ),
//                         TextButton(
//                           onPressed: () async {
//                             // IESSystem().startRecoveryPass();
//                           },
//                           child: Text(
//                             '¿Olvidaste la contraseña?',
//                             style: TextStyle(
//                                 color: Theme.of(context).colorScheme.secondary),
//                           ),
//                         ),
//                         ElevatedButton(
//                           onPressed: () async {
//                             Frutality().auth.SignIn.add(SignInWithGoogle());
//                           },
//                           child: const Text(
//                             'Acceder con Google',
//                           ),
//                         ),
//                         ElevatedButton(
//                           onPressed: () async {
//                             Frutality().auth.SignIn.add(SignInWithFacebook());
//                           },
//                           child: const Text(
//                             'Acceder con Facebook',
//                           ),
//                         ),
//                       ],
//                     ),
//                   )),
//             );
//           }));
//     });
//   }
// }
