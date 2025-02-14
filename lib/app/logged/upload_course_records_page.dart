import 'package:flutter/material.dart';
import 'package:mini_vera/app/logged/upload_course_records.dart';
import 'package:operation_cubit/operation_page.dart';

class UploadCourseRecordsPage extends OperationPage<UploadCourseRecords> {
  UploadCourseRecordsPage({
    super.key,
    required super.operation,
  }) : super(
            baseBuilder: (buildContext, state) {
              // print(operation.lastMainMenuBaseState.ctUnits[2].name);
              return SafeArea(
                  child: Scaffold(
                      body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SizedBox(
                      height: 70,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            GestureDetector(
                                onTap: () => operation.goHome(),
                                child: Image.asset('assets/icons/home.png')),
                            const Spacer(),
                            Image.asset('assets/icons/logo.png'),
                            const SizedBox(width: 12),
                            Text(
                              'Scripting tiles',
                              style:
                                  Theme.of(buildContext).textTheme.titleLarge,
                            ),
                            const Spacer(),
                            Image.asset('assets/icons/language.png'),
                            const SizedBox(width: 10),
                            Image.asset('assets/icons/user.png'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                        width: double.infinity,
                        child: Center(child: Container(color: Colors.lime))),
                  )),
                ],
              )));
            },
            notificationListener: (context, state) {});
}
