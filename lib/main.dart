import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Importante: Asegúrate de que estos nombres coincidan con tus archivos en lib/screens/
// Si te marca error aquí, es porque los archivos no existen con estos nombres exactos.
import 'package:flutter_application_1/screens/my_home_page.dart';
import 'package:flutter_application_1/screens/registro_page.dart';
import 'package:flutter_application_1/screens/notificaciones_page.dart';
import 'package:flutter_application_1/screens/formulario_page.dart';
import 'package:flutter_application_1/screens/detalles_page.dart';
import 'package:flutter_application_1/screens/historial_page.dart';

// 1. EL PUNTO DE ENTRADA (Esto evita el error de compilation)
void main() {
  runApp(const MyApp());
}

// 2. CONFIGURACIÓN DE RUTAS (Conexión entre páginas)
final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MyHomePage(title: 'OpticCom Home'),
    ),
    GoRoute(
      path: '/registro',
      builder: (context, state) => const RegistroPage(),
    ),
    GoRoute(
      path: '/notificaciones',
      builder: (context, state) => const NotificacionesPage(),
    ),
    GoRoute(
      path: '/formulario',
      builder: (context, state) => const FormularioPage(),
    ),
    GoRoute(
      path: '/detalles',
      builder: (context, state) => const DetallesPage(),
    ),
    GoRoute(
      path: '/historial',
      builder: (context, state) => const HistorialPage(),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'OpticCom',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      routerConfig: _router, // Conecta las rutas aquí
    );
  }
}
