import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/login_screen.dart';
import 'screens/detalle_screen.dart';
import 'screens/formulario_screen.dart';
import 'models/orden_model.dart';
import 'screens/main_container.dart';

void main() => runApp(const MyApp());

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const LoginScreen()),
    GoRoute(
      path: '/home',
      builder: (context, state) {
        final userData =
            state.extra as Map<String, dynamic>? ??
            {'id': 1, 'nombre': 'Técnico'};
        return MainContainer(userData: userData);
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
      ),
    );
  }
}
