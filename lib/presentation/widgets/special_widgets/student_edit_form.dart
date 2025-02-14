import 'package:flutter/material.dart';
import 'package:mini_vera/domain/entities/students.dart';

class StudentEditingForm extends StatefulWidget {
  final IESStudentUser? studentBeingEdited;
  final Function(Map<String, dynamic>) onSubmit;
  final Function() onCancel;
  const StudentEditingForm(
      {super.key,
      required this.studentBeingEdited,
      required this.onSubmit,
      required this.onCancel});

  @override
  StudentEditingFormState createState() => StudentEditingFormState();
}

class StudentEditingFormState extends State<StudentEditingForm> {
  // Claves para el formulario y los campos
  final _formKey = GlobalKey<FormState>();

  // Controladores para capturar los valores de los campos
  final _nombresController = TextEditingController();
  final _apellidosController = TextEditingController();
  final _dniController = TextEditingController();
  final _libroController = TextEditingController();
  final _folioController = TextEditingController();

  @override
  void dispose() {
    // Liberar los controladores
    _nombresController.dispose();
    _apellidosController.dispose();
    _dniController.dispose();
    _libroController.dispose();
    _folioController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      widget.onSubmit({
        'firstName': _nombresController.text,
        'lastName': _apellidosController.text,
        'dni': int.parse(_dniController.text),
        'book': int.parse(_libroController.text),
        'page': int.parse(_folioController.text)
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _nombresController,
                      decoration: const InputDecoration(labelText: "Nombres"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Por favor, ingrese su nombre";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextFormField(
                      controller: _apellidosController,
                      decoration: const InputDecoration(labelText: "Apellidos"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Por favor, ingrese su apellido";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      controller: _dniController,
                      decoration: const InputDecoration(labelText: "DNI"),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Por favor, ingrese su DNI";
                        }
                        if (int.tryParse(value) == null) {
                          return "El DNI debe ser un número";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextFormField(
                      controller: _libroController,
                      decoration: const InputDecoration(labelText: "Libro"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Por favor, ingrese el libro";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextFormField(
                      controller: _folioController,
                      decoration: const InputDecoration(labelText: "Folio"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Por favor, ingrese el folio";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 250,
                    child: ElevatedButton(
                      onPressed: widget.onCancel,
                      child: const Text("Cancelar"),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: 250,
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text("Guardar"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
