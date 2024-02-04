/* 
Fitxer lib/comarques.dart
Conté la pantalla de listado de comarques
*/

import 'package:flutter/material.dart';
import 'package:tasca4/data/comarques.dart';
import 'package:tasca4/data/peticions_http.dart';
import 'package:tasca4/screens/infocomarca.dart';

class Comarques extends StatefulWidget {
  final int indice_provincia;
  final String
      provincia; // Por como funciona la http debemos pasar el nombre de la provincia

  //const Comarques(String nom, {super.key, required this.indice_provincia});

  const Comarques(
      {super.key, required this.indice_provincia, required this.provincia});

  @override
  State<Comarques> createState() => _ComarquesState();
}

class ComarcaCard extends StatelessWidget {
  final String nombre;
  final String imagen;
  final int indice_provincia;
  final int indice_comarca;

  const ComarcaCard({
    super.key,
    required this.nombre,
    required this.imagen,
    required this.indice_provincia,
    required this.indice_comarca,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Infocomarca(comarca: nombre),
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
    // Añadido futurebuilder

    PeticionsHttp peticionsHttp = PeticionsHttp();

    return FutureBuilder<List<dynamic>>(
        future: peticionsHttp
            .obtenirComarques(widget.provincia), // Metodo peticion HTTP
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            List<Widget> llistaComarques = [];
            for (int i = 0; i < snapshot.data!.length; i++) {
              llistaComarques.add(ComarcaCard(
                  nombre: snapshot.data![i]["nom"], // Nombre comarca
                  imagen: snapshot.data![i]["img"], // Imagen comarca
                  indice_provincia: widget.indice_provincia,
                  indice_comarca: i));
            }

            return MaterialApp(
              title: 'Comarques',
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                appBar: AppBar(
                  title: Text('Comarques de ${widget.provincia}'),
                ),
                body: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/img/bg.webp"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: ListView(children: llistaComarques),
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
