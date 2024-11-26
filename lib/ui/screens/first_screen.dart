import 'package:flutter/material.dart';
import 'package:urunler_app/ui/screens/home_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {

  @override
  void initState() {
    super.initState();
    _checkFirstLaunch();
  }

  // İlk açılış kontrolü
  Future<void> _checkFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

    // Eğer ilk açılışsa, 2 saniye sonra HomeScreen'e yönlendir
    if (isFirstLaunch) {
      Future.delayed(const Duration(seconds: 2)).then((value) {
        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(builder: (context) => const HomeScreen())
        );
      });

      // İlk açılış olarak işaretle
      prefs.setBool('isFirstLaunch', false);
    } else {
      // Eğer daha önce açıldıysa, doğrudan HomeScreen'e git
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(builder: (context) => const HomeScreen())
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SizedBox(
          height: 300,
          width: 300,
          child: Lottie.asset(
            'assets/animations/loading.json', // Animasyon dosyasının yolu
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
