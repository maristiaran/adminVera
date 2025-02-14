import 'package:flutter/material.dart';
import 'package:mini_vera/app/logged/logged_menu.dart';
import 'package:operation_cubit/operation_page.dart';

class LoggedMenuPage extends OperationPage<LoggedMenu> {
  LoggedMenuPage({
    super.key,
    required super.operation,
  }) : super(
            baseBuilder: (context, state) {
              state as LoggedMenuBaseState;
              return Scaffold(
                appBar: AppBar(
                    title: Text(
                        "${operation.userLogged.lastName}, ${operation.userLogged.firstName}")),
                body: Padding(
                  padding: const EdgeInsets.all(60.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                            onPressed: operation.loadMasterLedger,
                            child: SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: Text(
                                "Cargar trayectoria estudiantil",
                                style: Theme.of(context).textTheme.titleMedium,
                                textAlign: TextAlign.center,
                              ),
                            )),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
                floatingActionButton: ElevatedButton(
                    onPressed: operation.logOut,
                    child: Text(
                      'Salir',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    )),
              );

              // Scaffold(
              //   appBar: AppBar(
              //     title: Text(operation.lastBaseState.userLogged.firstName),
              //   ),
              //   body: Container(
              //     color: Colors.blueGrey,
              //   ),
              // );
            },
            notificationListener: (context, state) {});
}
