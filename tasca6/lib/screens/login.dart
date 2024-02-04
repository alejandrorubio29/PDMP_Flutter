/* 
Fitxer lib/login.dart
Conté la pantalla d'inici de l'aplicació.
*/

import 'package:flutter/material.dart';
import 'package:tasca4/screens/provincies.dart';
import 'package:tasca4/screens/selector_provincia.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _controlador = TextEditingController();
  final TextEditingController _controladorPass = TextEditingController();
  TextEditingController controladorLogin = TextEditingController();
  TextEditingController controladorPassLogin = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Incialización del contenido de los controladores
    _controlador.text = "";
    _controladorPass.text = "";
  }

  @override
  void dispose() {
    // Alliberem el controlador quan el giny
    // s'elimine de l'arbre de ginys.
    _controlador.dispose();
    _controladorPass.dispose();
    super.dispose();
  }

  void actualizarControladores() {
    // Procedimiento auxiliar para pasar los valores de uno a otro controlador
    controladorLogin.text = _controlador.text;
    controladorPassLogin.text = _controladorPass.text;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Tasca 3',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/img/bg.webp"),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/img/logo.png",
                          scale: 2.0,
                        ),
                        const Text('Les nostres comarques',
                            style: TextStyle(
                                fontFamily: 'Leckerli One', fontSize: 40)),
                        const SizedBox(height: 10.0), // Separacion
                        TextFormField(
                          controller: controladorLogin,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Usuari',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        TextFormField(
                          controller: controladorPassLogin,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Contrassenya',
                            border: OutlineInputBorder(),
                          ),
                          obscureText: true,
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SelectorProvincia()), // Navegacion a pantalla selector provincia
                                );
                              },
                              child: const Text('Login'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Diálogo registre
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Registre'),
                                      content: Column(
                                        children: <Widget>[
                                          TextField(
                                            controller: _controlador,
                                            decoration: const InputDecoration(
                                              labelText: 'Nom d\'usuari',
                                            ),
                                          ),
                                          TextField(
                                            controller: _controladorPass,
                                            decoration: const InputDecoration(
                                              labelText: 'Password',
                                            ),
                                            obscureText:
                                                true, // Formato contraseña
                                          ),
                                        ],
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Cancel·lar'),
                                          onPressed: () {
                                            Navigator.pop(
                                                context); // Cerramos y no devolvemos nada.
                                          },
                                        ),
                                        TextButton(
                                          child: const Text('Registra\'t'),
                                          onPressed: () {
                                            Navigator.pop(context, {
                                              "username": _controlador.text,
                                              "pass": _controladorPass.text
                                            }); // Devolvemos el JSON con las credenciales
                                            actualizarControladores(); // Actualizamos controladores con los nuevos datos
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: const Text('Register'),
                            ),
                          ],
                        ),
                      ]),
                ),
              ),
            ),
          ),
        ));
  }
}
