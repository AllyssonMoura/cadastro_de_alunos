import 'package:cadastro_de_alunos/DAO/studentDAO.dart';
import 'package:cadastro_de_alunos/model/student.dart';
import 'package:cadastro_de_alunos/shared/menu.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class FormEdit extends StatelessWidget {
  final TextEditingController registrationController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

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
              SizedBox(height: 10),
              TextField(
                  decoration: InputDecoration(labelText: "Nome do Aluno"),
                  keyboardType: TextInputType.name,
                  controller: nameController),
              SizedBox(height: 10),
              TextField(
                  decoration: InputDecoration(labelText: "Email do Aluno"),
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    saveRecord(context);
                  },
                  child: Text("Editar Aluno"))
            ],
          ),
        ),
      ),
    );
  }

  void saveRecord(BuildContext mainContext) async {
    int _registration = int.parse(registrationController.text);
    String _name = nameController.text;
    String _email = emailController.text;
    late String message;

    if (EmailValidator.validate(_email)) {
      Student student =
          Student(registration: _registration, name: _name, email: _email);
      int _result = await StudentDAO.updateRecord("students", student.toMap());

      if (_result != 0) {
        message = "O(a) aluno(a) $_name foi atualizado(a) com sucesso!";
      } else {
        message = "Não foi possível atualizar o(a) aluno(a) $_name!";
      }
    } else {
      message = "Email inválido!";
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
