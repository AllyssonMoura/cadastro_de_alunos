import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            TextButton.icon(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/", (route) => false);
                },
                icon: Icon(Icons.group),
                label: Text("Listar Alunos")),
            TextButton.icon(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/register", (route) => false);
                },
                icon: Icon(Icons.add),
                label: Text("Cadastrar Aluno")),
            TextButton.icon(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/edit", (route) => false);
                },
                icon: Icon(Icons.edit),
                label: Text("Editar Aluno")),
            TextButton.icon(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/remove", (route) => false);
                },
                icon: Icon(Icons.delete),
                label: Text("Remover Aluno")),
          ],
        ),
      ),
    );
  }
}
