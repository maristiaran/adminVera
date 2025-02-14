import 'package:flutter/material.dart';
import 'package:mini_vera/app/logged/load_master_ledger.dart';
import 'package:mini_vera/domain/entities/students.dart';
import 'package:mini_vera/presentation/widgets/special_widgets/ledger_record_entry.dart';
import 'package:mini_vera/presentation/widgets/special_widgets/student_edit_form.dart';
import 'package:operation_cubit/operation.dart';

import 'package:operation_cubit/operation_page.dart';

class LoadMasterLedgerPage extends OperationPage<LoadMasterLedger> {
  LoadMasterLedgerPage({
    super.key,
    required super.operation,
  }) : super(baseBuilder: (buildContext, state) {
          IESStudentUser? currentStudentIfAny =
              operation.lastLoadMasterLedgerBaseState.selectedStudentIfAny;
          submitEditStudentForm(Map<String, dynamic> formData) {
            operation.addStudent(
                firstNameWithoutFormat: formData['firstName'],
                lastNameWithoutFormat: formData['lastName'],
                dni: formData['dni'],
                book: formData['book'],
                page: formData['page']);
          }

          return SafeArea(
              child: Scaffold(
            appBar: AppBar(
              title: Text(
                'Cargar trayectoria estudiantil',
                style: Theme.of(buildContext).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
            ),
            body: Center(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 150.0),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Plan de estudios actual: ${operation.adminUserLogged.currentSyllabusID}',
                      style: Theme.of(buildContext).textTheme.titleMedium,
                    ),
                    DropdownButton<String>(
                      value: operation.adminUserLogged.currentSyllabusID,
                      items: operation.adminUserLogged.syllabusIDs
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          operation.changeCurrentSyllabusID(newValue);
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(64, 236, 217, 5)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Buscar estudiante ...',
                                      hintStyle: const TextStyle(fontSize: 12),
                                      suffixIcon: const Icon(Icons.search),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        borderSide: BorderSide.none,
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 16),
                                    ),
                                    onSubmitted: (value) {
                                      operation.searchStudent(value);
                                    },
                                  ),
                                ),
                                const SizedBox(width: 10),
                                SizedBox(
                                  width: 64,
                                  child: IconButton(
                                      onPressed: () {
                                        operation.editStudent();
                                      },
                                      icon: const Icon(Icons.person_add)),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        if (currentStudentIfAny != null)
                          Container(
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(64, 236, 217, 5)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 30.0),
                              child: Row(
                                children: [
                                  Text(
                                    "${currentStudentIfAny.lastName}, ${currentStudentIfAny.firstName},DNI: ${currentStudentIfAny.dni}, Libro: ${currentStudentIfAny.book}, Folio: ${currentStudentIfAny.page}",
                                    style: Theme.of(buildContext)
                                        .textTheme
                                        .titleMedium,
                                  ),
                                  const Spacer(),
                                  Row(children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        operation.selectYear(1);
                                      },
                                      child: Text(
                                        '1',
                                        style: TextStyle(
                                            color: operation
                                                        .lastLoadMasterLedgerBaseState
                                                        .selectedYear ==
                                                    1
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        operation.selectYear(2);
                                      },
                                      child: Text(
                                        '2',
                                        style: TextStyle(
                                            color: operation
                                                        .lastLoadMasterLedgerBaseState
                                                        .selectedYear ==
                                                    2
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        operation.selectYear(3);
                                      },
                                      child: Text(
                                        '3',
                                        style: TextStyle(
                                            color: operation
                                                        .lastLoadMasterLedgerBaseState
                                                        .selectedYear ==
                                                    3
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                    ),
                                  ]),
                                ],
                              ),
                            ),
                          )
                        else if (operation.lastLoadMasterLedgerBaseState
                            .searchedStudents.isNotEmpty)
                          Column(
                            children: [
                              const SizedBox(height: 10),
                              Container(
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(64, 236, 217, 5)),
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(buildContext).size.height -
                                          400,
                                  child: ListView.builder(
                                      itemCount: operation
                                          .lastLoadMasterLedgerBaseState
                                          .searchedStudents
                                          .length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        var selectedStudent = operation
                                            .lastLoadMasterLedgerBaseState
                                            .searchedStudents[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            height: 50,
                                            child: ListTile(
                                              title: Text(
                                                  selectedStudent.toString()),
                                              onTap: () {
                                                operation.selectStudent(
                                                    selectedStudent);
                                              },
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ),
                            ],
                          ),
                        const SizedBox(height: 10),
                        if (operation.lastLoadMasterLedgerBaseState
                            .addingOrEditingStudent)
                          Column(
                            children: [
                              const SizedBox(height: 10),
                              Container(
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(64, 236, 217, 5)),
                                child: StudentEditingForm(
                                  studentBeingEdited: null,
                                  onSubmit: (formData) =>
                                      submitEditStudentForm(formData),
                                  onCancel: operation.cancelEditingStudent,
                                ),
                              ),
                            ],
                          )
                        else if (currentStudentIfAny != null)
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(buildContext).size.width -
                                    350,
                                // width: double.infinity,
                                height:
                                    MediaQuery.of(buildContext).size.height -
                                        350,
                                child: ListView.builder(
                                    itemCount: operation
                                        .lastLoadMasterLedgerBaseState
                                        .currentSubjectRecords
                                        .length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      var currentStudentRecord = operation
                                          .lastLoadMasterLedgerBaseState
                                          .currentSubjectRecords[index];
                                      return GestureDetector(
                                        onTap: () {
                                          operation.selectSubjectRecordID(
                                              operation
                                                  .lastLoadMasterLedgerBaseState
                                                  .currentSubjectRecords[index]
                                                  .subjectId);
                                        },
                                        child: Container(
                                          color: currentStudentRecord
                                                      .subjectId ==
                                                  operation
                                                      .lastLoadMasterLedgerBaseState
                                                      .selectedSubjectRecordIDIfAny
                                              ? Colors.orangeAccent
                                              : Colors.white,
                                          child: SizedBox(
                                            width: double.infinity,
                                            child: LedgerRecordEntry(
                                              key: ValueKey(currentStudentRecord
                                                  .subjectId),
                                              subjectID: currentStudentRecord
                                                  .subjectId,
                                              subjectName: currentStudentRecord
                                                  .subjectName,
                                              onChangeCourseGradeAndDate:
                                                  operation
                                                      .saveSubjectRecordEntry,
                                              canEdit: true,
                                              initialEndCourseDate:
                                                  currentStudentRecord
                                                      .courseDateIfAny,
                                              initialFinalExamDate:
                                                  currentStudentRecord
                                                      .finalExamDateIfAny,
                                              initialCourseGrade:
                                                  currentStudentRecord
                                                      .courseGrade,
                                              initialFinalExamGrade:
                                                  currentStudentRecord
                                                      .finalExamGrade,
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                        if (operation.lastLoadMasterLedgerBaseState
                            .selectedSubjectAdvice.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                                height: 100,
                                width: double.infinity,
                                child: Card(
                                  child: Text(operation
                                      .lastLoadMasterLedgerBaseState
                                      .selectedSubjectAdvice),
                                )),
                          )
                      ],
                    ),
                  ),
                ),
              ]),
            )),
          ));
        }, notificationListener: (context, state) {
          if (state is OperationNotificationState) {
            Color backGroundColor;
            switch (state.notificationType) {
              case NotificationStateType.confirmation:
                backGroundColor = Colors.green;
                break;
              case NotificationStateType.error:
                backGroundColor = Colors.red;
                break;

              default:
                backGroundColor = Colors.yellow;
                break;
            }

            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: backGroundColor,
                content: Text(
                  state.message,
                  style: Theme.of(context).textTheme.titleSmall,
                )));
          }
        });
}
