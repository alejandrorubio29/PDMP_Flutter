/* 
Fitxer lib/comarques.dart
Conté la pantalla de listado de comarques
*/

import 'package:flutter/material.dart';
import 'package:tasca3/data/comarques.dart';

class Comarques extends StatefulWidget {
  const Comarques({super.key});

  @override
  State<Comarques> createState() => _ProvinciesState();
}

class ComarcaCard extends StatelessWidget {
  final String nombre;
  final String imagen;

  const ComarcaCard({super.key, required this.nombre, required this.imagen});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: <Widget>[
          Image.network(imagen,
              height: 200, width: double.infinity, fit: BoxFit.cover),
          Positioned(
              left: 5,
              top: 150,
              child: Text(nombre,
                  style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Leckerli One',
                      fontSize: 25,
                      color: Colors.white))),
        ],
      ),
    );
  }
}

class _ProvinciesState extends State<Comarques> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Comarques',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Comarques de València'),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/img/bg.webp"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: ListView(
              children: provincies[0]["comarques"]
                  .map<Widget>((provincies) => ComarcaCard(
                      nombre: provincies["comarca"], imagen: provincies["img"]))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
