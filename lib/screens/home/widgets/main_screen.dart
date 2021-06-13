import 'package:cadastro_de_alunos/model/student.dart';
import 'package:cadastro_de_alunos/shared/menu.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  final dynamic _data;
  late final List<Student> _students;

  MainScreen(this._data);

  @override
  Widget build(BuildContext context) {
    _students = prepareStudents(_data);
    return Scaffold(
      appBar: AppBar(title: Text("Meus Alunos")),
      drawer: Menu(),
      body: ListView.builder(itemBuilder: builder, itemCount: _students.length),
    );
  }

  Widget builder(BuildContext context, int index) {
    return ListTile(
        leading: Icon(Icons.account_box, size: 50),
        title: Text(_students.elementAt(index).name!),
        subtitle: Text(_students.elementAt(index).email!));
  }

  List<Student> prepareStudents(dynamic data) {
    List<Student> students = [];
    for (int index = 0; index < data.length; index++) {
      students.add(Student.toObject(data[index]));
    }
    return students;
  }
}
