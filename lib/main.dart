import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/login_screen.dart';
<<<<<<< HEAD
=======
import 'screens/home_screen.dart';
>>>>>>> 359bcf543dcabbc0d90869c2574858518a60bb50
import 'screens/detalle_screen.dart';
import 'screens/formulario_screen.dart';
import 'models/orden_model.dart';
import 'screens/main_container.dart';

void main() => runApp(const MyApp());

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const LoginScreen()),
<<<<<<< HEAD
    GoRoute(
      path: '/home',
      builder: (context, state) {
        final userData =
            state.extra as Map<String, dynamic>? ??
            {'id': 1, 'nombre': 'Técnico'};
        return MainContainer(userData: userData);
=======
    // CAMBIO IMPORTANTE: La ruta /home ahora carga el CONTENEDOR PRINCIPAL
    GoRoute(
      path: '/home',
      builder: (context, state) {
        final idTecnico = state.extra as int? ?? 0;
        return MainContainer(idTecnico: idTecnico); // Usamos MainContainer
>>>>>>> 359bcf543dcabbc0d90869c2574858518a60bb50
      },
    ),
    GoRoute(
      path: '/detalle',
      builder: (context, state) {
        final orden = state.extra as OrdenTrabajo;
        return DetalleScreen(orden: orden);
      },
    ),
    GoRoute(
      path: '/formulario',
      builder: (context, state) {
        final orden = state.extra as OrdenTrabajo;
        return FormularioScreen(orden: orden);
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      title: 'Opticcom App',
      theme: ThemeData(
        useMaterial3: true,
<<<<<<< HEAD
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF9800),
          primary: const Color(0xFFFF9800),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
=======
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF9800)),
>>>>>>> 359bcf543dcabbc0d90869c2574858518a60bb50
      ),
    );
  }
}
