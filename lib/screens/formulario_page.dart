import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FormularioPage extends StatefulWidget {
  const FormularioPage({super.key});

  @override
  State<FormularioPage> createState() => _FormularioPageState();
}

class _FormularioPageState extends State<FormularioPage> {
  // Clave global para validar el formulario
  final _formKey = GlobalKey<FormState>();

  // Controladores para capturar lo que escribe el técnico
  final _serieOnuController = TextEditingController();
  final _cajaNapController = TextEditingController();
  final _potenciaController = TextEditingController();
  final _observacionesController = TextEditingController();

  @override
  void dispose() {
    // Siempre limpiar controladores al salir para liberar memoria
    _serieOnuController.dispose();
    _cajaNapController.dispose();
    _potenciaController.dispose();
    _observacionesController.dispose();
    super.dispose();
  }

  // Lógica de validación y "Envío"
  void _guardarFormulario() {
    if (_formKey.currentState!.validate()) {
      // SI TODO ESTÁ CORRECTO:

      // 1. Simulamos crear el objeto de datos
      final datosAEnviar = {
        "serie_onu": _serieOnuController.text,
        "nap": _cajaNapController.text,
        "potencia": _potenciaController.text,
        "observaciones": _observacionesController.text,
        "fecha": DateTime.now().toString(),
      };

      // 2. Mostramos feedback y volvemos
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('¡Datos guardados y enviados a OPTICCOM!'),
          backgroundColor: Colors.green,
        ),
      );

      print("Enviando al backend PHP: $datosAEnviar");

      // 3. Regresar a la lista de órdenes
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) context.pop(); // Vuelve atrás
      });
    } else {
      // SI HAY ERRORES
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor corrige los errores en rojo'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Datos Técnicos"),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(), // Cancelar y salir
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey, // Vinculamos la clave al formulario
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Detalles de Instalación",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // CAMPO 1: SERIE ONU
              TextFormField(
                controller: _serieOnuController,
                decoration: const InputDecoration(
                  labelText: "Serie ONU",
                  hintText: "Escanee o ingrese serie",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.qr_code),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Campo obligatorio';
                  return null;
                },
              ),
              const SizedBox(height: 15),

              // CAMPO 2: CÓDIGO NAP
              TextFormField(
                controller: _cajaNapController,
                decoration: const InputDecoration(
                  labelText: "Código Caja NAP",
                  hintText: "Ej: NAP-04",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.router),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Requerido';
                  return null;
                },
              ),
              const SizedBox(height: 15),

              // CAMPO 3: POTENCIA ÓPTICA (CRÍTICO)
              TextFormField(
                controller: _potenciaController,
                keyboardType: const TextInputType.numberWithOptions(
                  signed: true,
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: "Potencia Óptica (-dBm)",
                  hintText: "-18.5",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.speed),
                  suffixText: "dBm",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Requerido';

                  final numero = double.tryParse(value);
                  if (numero == null) return 'Debe ser número';

                  // REGLA DE NEGOCIO OPTICCOM: Rango -15 a -25
                  if (numero > -15 || numero < -25) {
                    return 'Fuera de rango (-15 a -25 dBm)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              // CAMPO 4: OBSERVACIONES
              TextFormField(
                controller: _observacionesController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Observaciones",
                  hintText: "Detalles adicionales...",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30),

              // BOTONES DE ACCIÓN
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => context.pop(),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.all(15),
                      ),
                      child: const Text(
                        "Cancelar",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _guardarFormulario,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.black, // Color corporativo secundario
                        padding: const EdgeInsets.all(15),
                      ),
                      child: const Text(
                        "Guardar",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
