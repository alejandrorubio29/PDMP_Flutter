import 'package:flutter/material.dart';
import 'package:tasca4/bloc/comarques_bloc.dart';
import 'package:tasca4/screens/infocomarca.dart';

class SelectorComarca extends StatelessWidget {
  SelectorComarca({required this.provincia, super.key});

  final String provincia;
  // Definim una referència al BLoC
  final ComarquesBloc comarquesBloc = ComarquesBloc();

  @override
  Widget build(BuildContext context) {
    // Utilitzem el Setter per establir la provincia
    comarquesBloc.provinciaActual = provincia;

    return StreamBuilder(
        stream: comarquesBloc.obtenirComarquesStream,
        initialData: const [],
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.active &&
              snapshot.hasData) {
            List<Widget> llistaComarques = [];
            for (int i = 0; i < snapshot.data!.length; i++) {
              llistaComarques.add(ComarcaCard(
                nombre: snapshot.data![i]["nom"], // Nombre comarca
                imagen: snapshot.data![i]["img"], // Imagen comarca
              ));
            }

            return MaterialApp(
              title: 'Comarques',
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                appBar: AppBar(
                  title: Text('Comarques de ${provincia}'),
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

class ComarcaCard extends StatelessWidget {
  final String nombre;
  final String imagen;

  const ComarcaCard({
    super.key,
    required this.nombre,
    required this.imagen,
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
