import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../model/info_oratge.dart'; // Per realitzar peticions HTTP

class OratgeRepository {
  // Añadido API tiempo
  Future<dynamic> obteClima(
      {required double longitud, required double latitud}) async {
    String url =
        'https://api.open-meteo.com/v1/forecast?latitude=$latitud&longitude=$longitud&current_weather=true';

    // Llancem una petició GET mitjançant el mètode http.get, i ens esperem a la resposta
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == HttpStatus.ok) {
      // Descodifiquem la resposta
      String body = utf8.decode(response.bodyBytes);
      final resultado = jsonDecode(body);

      // Creamos una instancia de InfoOratge con los datos obtenidos
      return InfoOratge(
        temperatura: resultado['current_weather']['temperature'].toString(),
        velocitatVent: resultado['current_weather']['wind_speed'].toString(),
        direccioVent: resultado['current_weather']['wind_direction'].toString(),
        codiOratge: resultado['current_weather']['condition'].toString(),
      );
    } else {
      // Si no carrega, llancem una excepció
      throw Exception('No s\'ha pogut connectar');
    }
  }
}
