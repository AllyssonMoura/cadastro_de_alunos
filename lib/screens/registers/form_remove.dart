import 'package:cadastro_de_alunos/DAO/studentDAO.dart';
import 'package:cadastro_de_alunos/model/student.dart';
import 'package:cadastro_de_alunos/shared/menu.dart';
import 'package:flutter/material.dart';

class FormRemove extends StatelessWidget {
  final TextEditingController registrationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Editar Aluno")),
      drawer: Menu(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                  decoration: InputDecoration(labelText: "Matrícula do Aluno"),
                  keyboardType: TextInputType.number,
                  controller: registrationController),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    removeRecord(context);
                  },
                  child: Text("Remover Aluno"),
                  style: ElevatedButton.styleFrom(primary: Colors.red))
            ],
          ),
        ),
      ),
    );
  }

  void removeRecord(BuildContext mainContext) async {
    int _registration = int.parse(registrationController.text);
    late String message;

    Student student = Student(registration: _registration);
    int _result =
        await StudentDAO.removeRecord("students", student.registration!);

    if (_result != 0) {
      message = "O(a) aluno(a) foi removido(a) com sucesso!";
    } else {
      message = "Não foi possível remover o(a) aluno(a)!";
    }

    showDialog(
        context: mainContext,
        builder: (BuildContext context) => AlertDialog(
              title: Text("Mensagem do Sistema"),
              content: Text(message),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("OK"))
              ],
            ));
  }
}
