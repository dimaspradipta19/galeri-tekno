import 'package:flutter/material.dart';
import 'package:galeri_teknologi_technical/view/home_screen.dart';
import 'package:galeri_teknologi_technical/view/login_screen.dart';
import 'package:galeri_teknologi_technical/view_model/provider/artist_detail_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ArtistDetailProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Galeri Tekno App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
