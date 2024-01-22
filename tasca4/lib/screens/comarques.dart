/* 
Fitxer lib/comarques.dart
Conté la pantalla de listado de comarques
*/

import 'package:flutter/material.dart';
import 'package:tasca4/data/comarques.dart';
import 'package:tasca4/screens/infocomarca.dart';

class Comarques extends StatefulWidget {
  final int indice_provincia;

  const Comarques({super.key, required this.indice_provincia});

  @override
  State<Comarques> createState() => _ComarquesState();
}

class ComarcaCard extends StatelessWidget {
  final String nombre;
  final String imagen;
  final int indice_provincia;
  final int indice_comarca;

  const ComarcaCard(
      {super.key,
      required this.nombre,
      required this.imagen,
      required this.indice_provincia,
      required this.indice_comarca});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Infocomarca(
                indice_provincia: indice_provincia,
                indice_comarca: indice_comarca),
          ),
        );
      },
      child: Card(
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
      ),
    );
  }
}

class _ComarquesState extends State<Comarques> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Comarques',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
              'Comarques de ${provincies[widget.indice_provincia]["provincia"]}'),
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
              children: [
                for (var i = 0;
                    i < provincies[widget.indice_provincia]["comarques"].length;
                    i++)
                  ComarcaCard(
                    nombre: provincies[widget.indice_provincia]["comarques"][i]
                        ["comarca"],
                    imagen: provincies[widget.indice_provincia]["comarques"][i]
                        ["img"],
                    indice_provincia: widget.indice_provincia,
                    indice_comarca: i,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
