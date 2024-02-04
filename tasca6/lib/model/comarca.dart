class Comarca {
  late String
      comarca; // tipo late Recomendado por VSCode, sino el método fromJSON da un error de inicialización necesaria de comarca
  String? capital;
  String? poblacio;
  String? img;
  String? desc;
  double? latitud;
  double? longitud;

  // Constructor por defecto
  Comarca({
    required this.comarca,
    this.capital,
    this.poblacio,
    this.img,
    this.desc,
    this.latitud,
    this.longitud,
  });

  // Constructor de diccionario

  Comarca.fromJSON(Map<String, dynamic> objecteJSON) {
    comarca = objecteJSON['comarca'];
    capital = objecteJSON['capital'];
    poblacio = objecteJSON['poblacio'];
    img = objecteJSON['img'];
    desc = objecteJSON['desc'];
    latitud = objecteJSON['latitud'];
    longitud = objecteJSON['longitud'];
  }

  // Override del toString

  @override
  String toString() {
    return '\x1B[34mnom\x1B[0m: \x1B[36m$comarca\x1B[0m\n'
        '\x1B[34mcapital\x1B[0m: \x1B[36m${capital ?? 'N/A'}\x1B[0m\n'
        '\x1B[34mpoblacio\x1B[0m: \x1B[36m${poblacio ?? 'N/A'}\x1B[0m\n'
        '\x1B[34mImatge\x1B[0m: \x1B[36m${img ?? 'N/A'}\x1B[0m\n'
        '\x1B[34mdescripció\x1B[0m: \x1B[36m${desc ?? 'N/A'}\x1B[0m\n'
        '\x1B[34mCoordenades\x1B[0m: \x1B[36m(${latitud ?? 'N/A'}, ${longitud ?? 'N/A'})\x1B[0m';
  }
}
