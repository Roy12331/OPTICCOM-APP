import 'dart:convert';
import 'dart:io';
<<<<<<< HEAD
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:signature/signature.dart';
import '../models/orden_model.dart';
import '../services/reporte_service.dart'; // 🔹 Importación del nuevo servicio
=======
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart'; // Para la Cámara
import 'package:geolocator/geolocator.dart'; // Para el GPS
import 'package:permission_handler/permission_handler.dart'; // Para permisos
import '../models/orden_model.dart';
import '../services/api_service.dart';
>>>>>>> 359bcf543dcabbc0d90869c2574858518a60bb50

class FormularioScreen extends StatefulWidget {
  final OrdenTrabajo orden;
  const FormularioScreen({super.key, required this.orden});
  @override
  State<FormularioScreen> createState() => _FormularioScreenState();
}

class _FormularioScreenState extends State<FormularioScreen> {
  final _formKey = GlobalKey<FormState>();

<<<<<<< HEAD
  int _pasoActual = 1;
  bool get esInstalacion => widget.orden.tipoTrabajo == 'Instalacion';

  final _serieCtrl = TextEditingController();
  final _napCtrl = TextEditingController();
  final _potenciaCtrl = TextEditingController();
  final _metrosCtrl = TextEditingController();
  final _conectoresCtrl = TextEditingController();
  final _solucionCtrl = TextEditingController();
  final _obsCtrl = TextEditingController();

  int _puertoSeleccionado = 1;

  XFile? _fotoFachada;
  XFile? _fotoEquipo;

  final SignatureController _firmaController = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

=======
  // Controladores de texto
  final _serieCtrl = TextEditingController();
  final _napCtrl = TextEditingController();
  final _puertoCtrl = TextEditingController();
  final _potenciaCtrl = TextEditingController();
  final _metrosCtrl = TextEditingController();
  final _obsCtrl = TextEditingController();

  // Variables para Foto y GPS
  File? _fotoEvidencia;
>>>>>>> 359bcf543dcabbc0d90869c2574858518a60bb50
  String? _gpsLat;
  String? _gpsLon;
  bool _enviando = false;
  bool _gpsCargando = false;

<<<<<<< HEAD
  Future<void> _tomarFoto(bool esFachada) async {
    if (!kIsWeb) {
      var status = await Permission.camera.request();
      if (status.isDenied) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Permiso de cámara denegado")),
          );
        }
        return;
      }
    }

    final picker = ImagePicker();
=======
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
>>>>>>> 359bcf543dcabbc0d90869c2574858518a60bb50
    final XFile? foto = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );

    if (foto != null) {
      setState(() {
<<<<<<< HEAD
        if (esFachada) {
          _fotoFachada = foto;
        } else {
          _fotoEquipo = foto;
        }
=======
        _fotoEvidencia = File(foto.path);
>>>>>>> 359bcf543dcabbc0d90869c2574858518a60bb50
      });
    }
  }

<<<<<<< HEAD
  Future<void> _obtenerGPS() async {
    setState(() => _gpsCargando = true);

    if (!kIsWeb) {
      bool servicioHabilitado = await Geolocator.isLocationServiceEnabled();
      if (!servicioHabilitado) {
        setState(() => _gpsCargando = false);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Prende el GPS del celular")),
          );
        }
=======
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
>>>>>>> 359bcf543dcabbc0d90869c2574858518a60bb50
        return;
      }
    }

    try {
<<<<<<< HEAD
=======
      // Obtener posición (High accuracy)
>>>>>>> 359bcf543dcabbc0d90869c2574858518a60bb50
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
<<<<<<< HEAD
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error GPS: $e")));
      }
    }
  }

  Future<String?> _xfileToBase64(XFile? file) async {
    if (file == null) return null;
    final bytes = await file.readAsBytes();
    return base64Encode(bytes);
  }

  void _finalizarOrden() async {
    if (_gpsLat == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("⚠️ Captura la ubicación GPS primero"),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    if (_fotoFachada == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("⚠️ Falta la foto de evidencia"),
=======
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
>>>>>>> 359bcf543dcabbc0d90869c2574858518a60bb50
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() => _enviando = true);

<<<<<<< HEAD
    String? base64Fachada = await _xfileToBase64(_fotoFachada);
    String? base64Firma;
    if (_firmaController.isNotEmpty) {
      final firmabytes = await _firmaController.toPngBytes();
      if (firmabytes != null) base64Firma = base64Encode(firmabytes);
=======
    // Convertir foto a Base64 (Texto largo)
    String? base64Image;
    if (_fotoEvidencia != null) {
      List<int> imageBytes = await _fotoEvidencia!.readAsBytes();
      base64Image = base64Encode(imageBytes);
>>>>>>> 359bcf543dcabbc0d90869c2574858518a60bb50
    }

    final datos = {
      "id_orden": widget.orden.idOrden,
<<<<<<< HEAD
      "potencia": double.tryParse(_potenciaCtrl.text) ?? 0.0,
      "metros": int.tryParse(_metrosCtrl.text) ?? 0,
      "conectores": int.tryParse(_conectoresCtrl.text) ?? 0,
      "observaciones": _obsCtrl.text,
      "lat": _gpsLat,
      "lon": _gpsLon,
      "foto_base64": base64Fachada ?? "",
      "firma_base64": base64Firma ?? "",
    };

    if (esInstalacion) {
      datos["serie"] = _serieCtrl.text;
      datos["nap"] = _napCtrl.text;
      datos["puerto"] = _puertoSeleccionado;
    } else {
      datos["solucion"] = _solucionCtrl.text;
    }

    // 🔹 Llamada al nuevo servicio separado
    final resp = await ReporteService.enviarReporte(datos);
=======
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
>>>>>>> 359bcf543dcabbc0d90869c2574858518a60bb50

    if (mounted) {
      setState(() => _enviando = false);
      if (resp['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
<<<<<<< HEAD
            content: Text("¡Trabajo Completado Exitosamente!"),
            backgroundColor: Colors.green,
          ),
        );
        context.go('/home', extra: 1);
=======
            content: Text("¡INSTALACIÓN FINALIZADA!"),
            backgroundColor: Colors.green,
          ),
        );
        context.go('/home', extra: 1); // Volver al inicio
>>>>>>> 359bcf543dcabbc0d90869c2574858518a60bb50
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
<<<<<<< HEAD
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(_pasoActual == 1 ? "Datos Técnicos" : "Evidencias y Firma"),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () {
            if (_pasoActual == 2) {
              setState(() => _pasoActual = 1);
            } else {
              context.pop();
            }
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: _pasoActual == 1
            ? _pantallaDatosTecnicos()
            : _pantallaEvidencias(),
      ),
    );
  }

  Widget _pantallaDatosTecnicos() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (esInstalacion) ...[
            _label("Serie ONU *"),
            _input("Escanear o ingresar serie", _serieCtrl, requerido: true),
            const SizedBox(height: 20),
            _label("Código Caja NAP *"),
            _input("Ejemplo: NAP-04", _napCtrl, requerido: true),
            const SizedBox(height: 20),
            _label("Puerto NAP"),
            _selectorPuertos(),
            const SizedBox(height: 20),
          ] else ...[
            _label("Solución Aplicada *"),
            _input(
              "Describe qué reparaste...",
              _solucionCtrl,
              requerido: true,
              lineas: 2,
            ),
            const SizedBox(height: 20),
          ],
          _label("Potencia Óptica (-dBm) *"),
          _input(
            "Ingresa potencia óptica",
            _potenciaCtrl,
            num: true,
            requerido: true,
          ),
          const SizedBox(height: 20),
          _label("Metros de Cable"),
          _input("Ingresa longitud del cable", _metrosCtrl, num: true),
          const SizedBox(height: 20),
          _label("Observaciones"),
          _input("Escriba sus observaciones aquí", _obsCtrl, lineas: 3),
          const SizedBox(height: 40),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => context.pop(),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Cancelar",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() => _pasoActual = 2);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Continuar",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _pantallaEvidencias() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: _gpsLat == null
                  ? Colors.red.shade50
                  : Colors.green.shade50,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: _gpsLat == null
                    ? Colors.red.shade200
                    : Colors.green.shade200,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.gps_fixed,
                  color: _gpsLat == null ? Colors.red : Colors.green,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    _gpsLat == null
                        ? "Ubicación obligatoria"
                        : "GPS Capturado: $_gpsLat",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                _gpsCargando
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : TextButton(
                        onPressed: _obtenerGPS,
                        child: const Text("CAPTURAR"),
                      ),
              ],
            ),
          ),
          const SizedBox(height: 25),
          const Text(
            "Evidencias a Subir",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _cajaFoto(
                  "Fachada",
                  _fotoFachada,
                  () => _tomarFoto(true),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: _cajaFoto(
                  "Equipo",
                  _fotoEquipo,
                  () => _tomarFoto(false),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          const Text(
            "Firma del Cliente",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Text(
            "Por favor firme para confirmar",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Signature(
                controller: _firmaController,
                height: 150,
                backgroundColor: Colors.grey.shade100,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () => _firmaController.clear(),
              icon: const Icon(Icons.clear, size: 16, color: Colors.red),
              label: const Text("Limpiar", style: TextStyle(color: Colors.red)),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: _enviando ? null : _finalizarOrden,
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
    );
  }

  Widget _label(String texto) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        texto,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
=======
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
>>>>>>> 359bcf543dcabbc0d90869c2574858518a60bb50
      ),
    );
  }

  Widget _input(
<<<<<<< HEAD
    String hint,
    TextEditingController ctrl, {
    bool num = false,
    int lineas = 1,
    bool requerido = false,
  }) {
    return TextFormField(
      controller: ctrl,
      keyboardType: num
          ? const TextInputType.numberWithOptions(decimal: true)
          : TextInputType.text,
      maxLines: lineas,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
        filled: true,
        fillColor: Colors.grey.shade50,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.black),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
      validator: requerido
          ? (v) => v == null || v.trim().isEmpty ? "Obligatorio" : null
          : null,
    );
  }

  Widget _selectorPuertos() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: List.generate(6, (index) {
        int puerto = index + 1;
        bool seleccionado = _puertoSeleccionado == puerto;
        return GestureDetector(
          onTap: () => setState(() => _puertoSeleccionado = puerto),
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: seleccionado ? Colors.black : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: seleccionado ? Colors.black : Colors.grey.shade300,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              puerto.toString(),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: seleccionado ? Colors.white : Colors.black87,
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _cajaFoto(String titulo, XFile? archivo, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(10),
        ),
        child: archivo == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.cloud_upload_outlined,
                    color: Colors.grey,
                    size: 30,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    titulo,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: kIsWeb
                    ? Image.network(archivo.path, fit: BoxFit.cover)
                    : Image.file(File(archivo.path), fit: BoxFit.cover),
              ),
      ),
=======
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
>>>>>>> 359bcf543dcabbc0d90869c2574858518a60bb50
    );
  }
}
