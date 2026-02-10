import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// IMPORTS DE TUS PANTALLAS (Asegúrate que las rutas sean correctas)
import 'screens/my_home_page.dart';
import 'screens/notificaciones_page.dart';
import 'screens/historial_page.dart';
import 'screens/formulario_page.dart'; // Asumo que crearás esta pronto

void main() {
  runApp(const MyApp());
}

/// CONFIGURACIÓN DEL ROUTER (EL MAPA)
final GoRouter _router = GoRouter(
  initialLocation: '/', // La app arranca aquí (Login)
  routes: [
    // RUTA 1: LOGIN (La raíz "/")
    GoRoute(
      path: '/',
      builder: (context, state) => const MyHomePage(title: 'OPTICCOM Login'),
    ),

    // RUTA 2: LISTA DE ÓRDENES (Notificaciones)
    GoRoute(
      path: '/notificaciones',
      builder: (context, state) => const NotificacionesPage(),
    ),

    // RUTA 3: HISTORIAL (Perfil)
    GoRoute(
      path: '/historial',
      builder: (context, state) => const HistorialPage(),
    ),

    // RUTA 4: FORMULARIO (Detalle de trabajo)
    // RUTA 4: FORMULARIO (Detalle de trabajo)
    GoRoute(
      path: '/formulario',
      builder: (context, state) {
        // Ahora retornamos la página real, no el texto placeholder
        return const FormularioPage();
      },
    ),
    // RUTA NUEVA: REGISTRO
    GoRoute(
      path: '/registro',
      builder: (context, state) {
        return const Scaffold(
          body: Center(child: Text("Pantalla de Registro (En construcción)")),
        );
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // CAMBIO CLAVE: Usamos .router en lugar de MaterialApp normal
    return MaterialApp.router(
      title: 'OPTICCOM App',
      debugShowCheckedModeBanner: false,

      // TEMA: Naranja corporativo
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF9800)),
        useMaterial3: true,
      ),

      // CONECTAMOS EL GPS A LA APP
      routerConfig: _router,
    );
  }
}
