import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart'; // Para la Cámara
import 'package:geolocator/geolocator.dart'; // Para el GPS
import 'package:permission_handler/permission_handler.dart'; // Para permisos
import '../models/orden_model.dart';
import '../services/api_service.dart';

class FormularioScreen extends StatefulWidget {
  final OrdenTrabajo orden;
  const FormularioScreen({super.key, required this.orden});
  @override
  State<FormularioScreen> createState() => _FormularioScreenState();
}

class _FormularioScreenState extends State<FormularioScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controladores de texto
  final _serieCtrl = TextEditingController();
  final _napCtrl = TextEditingController();
  final _puertoCtrl = TextEditingController();
  final _potenciaCtrl = TextEditingController();
  final _metrosCtrl = TextEditingController();
  final _obsCtrl = TextEditingController();

  // Variables para Foto y GPS
  File? _fotoEvidencia;
  String? _gpsLat;
  String? _gpsLon;
  bool _enviando = false;
  bool _gpsCargando = false;

  // 📸 FUNCIÓN: TOMAR FOTO
  Future<void> _tomarFoto() async {
    // Pedimos permiso
    var status = await Permission.camera.request();
    if (status.isDenied) {
      if (mounted)
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Permiso de cámara denegado")),
        );
      return;
    }

    final picker = ImagePicker();
    // Tomamos foto (calidad 50 para que suba rápido)
    final XFile? foto = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );

    if (foto != null) {
      setState(() {
        _fotoEvidencia = File(foto.path);
      });
    }
  }

  // 📍 FUNCIÓN: OBTENER GPS
  Future<void> _obtenerGPS() async {
    setState(() => _gpsCargando = true);

    // Verificar si el GPS está prendido
    bool servicioHabilitado = await Geolocator.isLocationServiceEnabled();
    if (!servicioHabilitado) {
      setState(() => _gpsCargando = false);
      if (mounted)
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Prende el GPS del celular")),
        );
      return;
    }

    // Pedir permisos
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() => _gpsCargando = false);
        return;
      }
    }

    try {
      // Obtener posición (High accuracy)
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _gpsLat = position.latitude.toString();
        _gpsLon = position.longitude.toString();
        _gpsCargando = false;
      });
    } catch (e) {
      setState(() => _gpsCargando = false);
      if (mounted)
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error GPS: $e")));
    }
  }

  // 🚀 ENVIAR TODO AL SERVIDOR
  void _finalizar() async {
    if (!_formKey.currentState!.validate()) return;

    // Validamos que haya GPS (Obligatorio en V5)
    if (_gpsLat == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("⚠️ Falta la ubicación GPS"),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() => _enviando = true);

    // Convertir foto a Base64 (Texto largo)
    String? base64Image;
    if (_fotoEvidencia != null) {
      List<int> imageBytes = await _fotoEvidencia!.readAsBytes();
      base64Image = base64Encode(imageBytes);
    }

    final datos = {
      "id_orden": widget.orden.idOrden,
      "serie": _serieCtrl.text,
      "nap": _napCtrl.text,
      "puerto": _puertoCtrl.text,
      "potencia": double.parse(_potenciaCtrl.text),
      "metros": int.tryParse(_metrosCtrl.text) ?? 0,
      "observaciones": _obsCtrl.text,
      "lat": _gpsLat,
      "lon": _gpsLon,
      "foto_base64": base64Image ?? "", // Si no hay foto, envía vacío
    };

    final resp = await ApiService.enviarReporte(datos);

    if (mounted) {
      setState(() => _enviando = false);
      if (resp['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("¡INSTALACIÓN FINALIZADA!"),
            backgroundColor: Colors.green,
          ),
        );
        context.go('/home', extra: 1); // Volver al inicio
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(resp['mensaje'] ?? "Error desconocido"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reporte Técnico")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. ZONA DE FOTO
              GestureDetector(
                onTap: _tomarFoto,
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _fotoEvidencia == null
                      ? const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.camera_alt,
                              size: 50,
                              color: Colors.grey,
                            ),
                            Text(
                              "Tocar para FOTO EVIDENCIA",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        )
                      : Image.file(_fotoEvidencia!, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 15),

              // 2. ZONA DE GPS
              ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                tileColor: _gpsLat == null ? Colors.red[50] : Colors.green[50],
                leading: Icon(
                  Icons.location_on,
                  color: _gpsLat == null ? Colors.red : Colors.green,
                ),
                title: Text(
                  _gpsLat == null
                      ? "GPS No Capturado"
                      : "Lat: $_gpsLat\nLon: $_gpsLon",
                  style: const TextStyle(fontSize: 13),
                ),
                trailing: _gpsCargando
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _obtenerGPS,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        child: const Text(
                          "CAPTURAR",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
              ),
              const SizedBox(height: 20),

              // 3. CAMPOS DE DATOS
              Row(
                children: [
                  Expanded(child: _input("Serie ONU", _serieCtrl)),
                  const SizedBox(width: 10),
                  Expanded(child: _input("Cód NAP", _napCtrl)),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: _input("Puerto", _puertoCtrl, num: true)),
                  const SizedBox(width: 10),
                  Expanded(child: _input("Potencia", _potenciaCtrl, num: true)),
                ],
              ),
              const SizedBox(height: 10),
              _input("Metros de Cable", _metrosCtrl, num: true),
              const SizedBox(height: 10),
              _input("Observaciones", _obsCtrl, lineas: 3),

              const SizedBox(height: 30),

              // 4. BOTÓN FINALIZAR
              SizedBox(
                height: 55,
                child: ElevatedButton(
                  onPressed: _enviando ? null : _finalizar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF9800),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: _enviando
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "FINALIZAR ORDEN",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _input(
    String label,
    TextEditingController ctrl, {
    bool num = false,
    int lineas = 1,
  }) {
    return TextFormField(
      controller: ctrl,
      keyboardType: num ? TextInputType.number : TextInputType.text,
      maxLines: lineas,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 15,
        ),
      ),
      validator: (v) => v!.isEmpty ? "Requerido" : null,
    );
  }
}
