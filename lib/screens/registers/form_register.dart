import 'package:cadastro_de_alunos/DAO/studentDAO.dart';
import 'package:cadastro_de_alunos/model/student.dart';
import 'package:cadastro_de_alunos/shared/menu.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class FormRegister extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cadastrar Aluno")),
      drawer: Menu(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16),
          child: Column(children: [
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
                  saveRegister(context);
                },
                child: Text("Cadastrar Aluno"))
          ]),
        ),
      ),
    );
  }

  void saveRegister(BuildContext mainContext) async {
    String name = nameController.text;
    String email = emailController.text;
    String message;

    if (!EmailValidator.validate(email)) {
      showDialog(
        context: mainContext,
        builder: (context) => AlertDialog(
          title: Text("Mensagem do Sistema"),
          content: Text("Email Inválido!"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Ok"))
          ],
        ),
      );
    } else {
      Student student = Student(name: name, email: email);
      int result = await StudentDAO.insertRecord("students", student.toMap());

      if (result != 0) {
        message = "O(a) aluno(a) $name foi cadastrado(a) com sucesso!";
      } else {
        message = "O(a) aluno(a) $name não pode ser cadastrado(a)!";
      }

      showDialog(
        context: mainContext,
        builder: (context) => AlertDialog(
          title: Text("Mensagem do Sistema"),
          content: Text(message),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("OK"))
          ],
        ),
      );
    }
  }
}
