import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(
    MaterialApp(home: HomePage()),
  );
}

class Employee {
  final int empleadoId;
  final String nombre;
  final String apellido;
  final DateTime fechaNacimiento;
  final int salario;
  final String nombreDepartamento;

  Employee({
    required this.empleadoId,
    required this.nombre,
    required this.apellido,
    required this.fechaNacimiento,
    required this.salario,
    required this.nombreDepartamento,
  });
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> usersData = [];

  Future<void> getUsers() async {
    final url = 'http://localhost:3002/obtenerEmpleado';

    var response = await http.get(Uri.parse(url),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      setState(() {
        usersData = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User list'),
        backgroundColor: Color.fromARGB(255, 49, 150, 197),
      ),
      body: ListView.builder(
        itemCount: usersData.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: Text("${usersData[index]["NOMBRE"]} ${usersData[index]["APELLIDO"]}"),
            ),
          );
        },
      ),
    );
  }
}
