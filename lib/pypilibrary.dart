import 'package:http/http.dart' as http;
import 'dart:convert';

class PyPiLibrary {
  static String apiBaseUrl = "https://pypiretrieverapi.herokuapp.com/libs/get/";

  PyPiLibrary({
    this.counter,
    this.name,
    this.versions,
  });

  int counter;
  String name;
  List<String> versions;

  factory PyPiLibrary.fromJson(Map<String, dynamic> json) => PyPiLibrary(
    counter: json["counter"],
    name: json["name"],
    versions: List<String>.from(json["versions"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "counter": counter,
    "name": name,
    "versions": List<dynamic>.from(versions.map((x) => x)),
  };

  static Future<PyPiLibrary> getLibFromPypi(libName) async{
    final response = await http.get(apiBaseUrl + libName);
    print(response.statusCode);
    print(response.body);
    return PyPiLibrary.fromJson(json.decode(response.body));
  }

  @override
  String toString() {
    return counter.toString() + " versions trouvées pour la librairie " + name;
  }
}