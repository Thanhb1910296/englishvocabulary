import 'package:english_vocabulary/constants/global_variables.dart';
import 'package:english_vocabulary/pages/home_page.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Welcome to',
                  style: TextStyle(fontSize: 36,fontWeight: FontWeight.bold, color: AppColors.secondColor),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'English',
                      style: TextStyle(fontSize: 72,fontWeight: FontWeight.bold, color: AppColors.greyText),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(
                        'Vocabulary',
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 36, color: AppColors.secondColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 72),
                child: RawMaterialButton(
                  shape: CircleBorder(),
                  fillColor: AppColors.lighBlue,
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => HomePage()),
                        (route) => false);
                  },
                  child: Icon(Icons.keyboard_double_arrow_right_outlined),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}