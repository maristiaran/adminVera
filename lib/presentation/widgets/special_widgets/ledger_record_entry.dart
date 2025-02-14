import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LedgerRecordEntry extends StatefulWidget {
  final int subjectID;
  final String subjectName;
  final ValueChanged<Map<String, dynamic>> onChangeCourseGradeAndDate;
  final bool canEdit;
  final String initialCourseGrade;
  final String initialFinalExamGrade;
  final DateTime? initialEndCourseDate;
  final DateTime? initialFinalExamDate;

  const LedgerRecordEntry({
    super.key,
    required this.subjectID,
    required this.subjectName,
    required this.onChangeCourseGradeAndDate,
    required this.canEdit,
    required this.initialEndCourseDate,
    required this.initialFinalExamDate,
    required this.initialCourseGrade,
    required this.initialFinalExamGrade,
  });

  @override
  LedgerRecordEntryState createState() => LedgerRecordEntryState();
}

class LedgerRecordEntryState extends State<LedgerRecordEntry> {
  late DateTime? selectedCourseDate;
  late DateTime? selectedFinalExamDate;
  late String courseGrade = '-';
  late String finalExamGrade = '-';
  final TextEditingController courseDropMenuController =
      TextEditingController();
  final TextEditingController finalExamDropMenuController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedCourseDate = widget.initialEndCourseDate;
    selectedFinalExamDate = widget.initialFinalExamDate;
    courseGrade = widget.initialCourseGrade;
    finalExamGrade = widget.initialFinalExamGrade;
  }

  void _submitCourseGradeAndDate() {
    // if (_formKey.currentState!.validate()) {
    widget.onChangeCourseGradeAndDate({
      'id': widget.subjectID,
      'courseDate': selectedCourseDate,
      'courseGrade': courseDropMenuController.text,
      'finalExamDate': selectedFinalExamDate,
      'finalExamGrade': finalExamDropMenuController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Form(
        child: SingleChildScrollView(
          child: Row(
            children: [
              SizedBox(
                width: 40,
                child: Text(widget.subjectID.toString()),
              ),
              Expanded(
                flex: 3,
                child: Text(widget.subjectName),
              ),
              SizedBox(
                width: 150,
                child: DropdownMenu(
                  initialSelection: widget.initialCourseGrade,
                  controller: courseDropMenuController,
                  textStyle: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 12),
                  textAlign: TextAlign.center,
                  dropdownMenuEntries: [
                    '-',
                    'Regular',
                    'Libre',
                    '6',
                    '7',
                    '8',
                    '9',
                    '10'
                  ].map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(
                      value: value,
                      label: value,
                    );
                  }).toList(),
                  onSelected: (String? value) {
                    setState(() {
                      courseGrade = value ?? '-';
                      selectedCourseDate =
                          value == null || value == '-' ? null : DateTime.now();
                    });
                  },
                ),
              ),
              SizedBox(
                  width: 80,
                  child: Text(selectedCourseDate == null
                      ? '-'
                      : DateFormat("dd-MM-yyyy").format(selectedCourseDate!))),
              SizedBox(
                width: 50,
                child: IconButton(
                  onPressed: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: selectedCourseDate ?? DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      helpText:
                          'Selecciona una fecha', // Texto de ayuda (opcional)
                      cancelText:
                          'Cancelar', // Texto del botón de cancelar (opcional)
                      confirmText:
                          'Aceptar', // Texto del botón de aceptar (opcional)
                    );
                    if (pickedDate != null &&
                        pickedDate != selectedCourseDate) {
                      setState(() {
                        selectedCourseDate = pickedDate;
                      });
                    }
                  },
                  icon: const Icon(Icons.calendar_month),
                ),
              ),
              SizedBox(
                width: 150,
                child: DropdownMenu(
                  menuStyle: const MenuStyle(alignment: Alignment.topCenter),
                  initialSelection: widget.initialFinalExamGrade,
                  controller: finalExamDropMenuController,
                  textStyle: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 12),
                  textAlign: TextAlign.center,
                  dropdownMenuEntries: ['-', '6', '7', '8', '9', '10']
                      .map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(
                      value: value,
                      label: value,
                    );
                  }).toList(),
                  onSelected: (String? value) {
                    setState(() {
                      if (value != null) {
                        finalExamDropMenuController.text = value;
                      }

                      finalExamGrade = value ?? '-';
                      selectedFinalExamDate =
                          value == null || value == '-' ? null : DateTime.now();
                    });
                  },
                ),
              ),
              SizedBox(
                  width: 80,
                  child: Text(selectedFinalExamDate == null
                      ? '-'
                      : DateFormat("dd-MM-yyyy")
                          .format(selectedFinalExamDate!))),
              SizedBox(
                width: 50,
                child: IconButton(
                  onPressed: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: selectedFinalExamDate ?? DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      helpText:
                          'Selecciona una fecha', // Texto de ayuda (opcional)
                      cancelText:
                          'Cancelar', // Texto del botón de cancelar (opcional)
                      confirmText:
                          'Aceptar', // Texto del botón de aceptar (opcional)
                    );
                    if (pickedDate != null &&
                        pickedDate != selectedFinalExamDate) {
                      setState(() {
                        selectedFinalExamDate = pickedDate;
                      });
                    }
                  },
                  icon: const Icon(Icons.calendar_month),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 100,
                child: IconButton(
                  onPressed: () {
                    _submitCourseGradeAndDate();
                  },
                  icon: const Icon(Icons.save),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
