import 'dart:convert';
import 'package:http/http.dart' as http;

class ReporteService {
  static const String baseUrl = 'https://opticcomperu.com/api';

  static Future<Map<String, dynamic>> enviarReporte(
    Map<String, dynamic> datos,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/guardar_reporte.php'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(datos),
    );
    return json.decode(response.body);
  }
}
