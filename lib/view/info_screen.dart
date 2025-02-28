import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_book_store/view/login_screen.dart';
import 'package:the_book_store/view/registration_screen.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.only(bottom: 20)),
            Align(
              alignment: Alignment.topLeft,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Skip',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Color.fromRGBO(74, 138, 196, 1),
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 10)),
            Image.asset("lib/assets/images/Frame.png", height: 320, width: 320),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.08,
              width: MediaQuery.sizeOf(context).width - 200,
              child: Text(
                'Your Bookish Soulmate Awaits',
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 10)),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.09,
              width: MediaQuery.sizeOf(context).width - 100,
              child: Text(
                'Let us be your guide to the perfect read. Discover books tailored to your tastes for a truly rewarding experience.',
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Color.fromRGBO(166, 166, 166, 1),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 60)),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegistrationScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(74, 138, 196, 1),
                minimumSize: Size(327, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Register',
                style: GoogleFonts.openSans(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 10)),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(229, 243, 255, 1),
                minimumSize: Size(327, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Login',
                style: GoogleFonts.openSans(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Color.fromRGBO(74, 138, 196, 1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
