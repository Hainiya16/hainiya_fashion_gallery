// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';
import 'providers/auth_provider.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/checkout_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/shop_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'ShoeShop',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Poppins',
          scaffoldBackgroundColor: Colors.white,
        ),
        initialRoute: '/',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(
                builder: (context) => Consumer<AuthProvider>(
                  builder: (context, auth, _) {
                    return auth.isLoggedIn ? const HomeScreen() : const LoginScreen();
                  },
                ),
              );
            case '/cart':
              return MaterialPageRoute(builder: (context) => const CartScreen());
            case '/checkout':
              return MaterialPageRoute(builder: (context) => const CheckoutScreen());
            case '/profile':
              return MaterialPageRoute(builder: (context) => const ProfileScreen());
            default:
              return MaterialPageRoute(
                builder: (context) => Consumer<AuthProvider>(
                  builder: (context, auth, _) {
                    return auth.isLoggedIn ? const HomeScreen() : const LoginScreen();
                  },
                ),
              );
          }
        },
      ),
    );
  }
}