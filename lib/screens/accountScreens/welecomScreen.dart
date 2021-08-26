import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task/constant.dart';
import 'package:task/reuseableWidget.dart';
import 'package:task/screens/accountScreens/loginScreen.dart';
import 'package:task/screens/accountScreens/registerScreen.dart';

class WelecomScreen extends StatelessWidget {
  static const String id = "_welecomScreen";
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: cornerLinearGradient,
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Icon(
                        Icons.imagesearch_roller_outlined,
                        color: Colors.white,
                        size: MediaQuery.of(context).size.width / 4,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Welecom To',
                        style: TextStyle(color: firstColor, letterSpacing: 2),
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 40,
                            color: firstColor,
                            letterSpacing: 2,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'IMAGE ',
                                style: TextStyle(fontWeight: FontWeight.w600)),
                            TextSpan(
                              text: 'APP',
                              style: TextStyle(
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      MyButton(
                        buttonText: 'Log in',
                        buttonColor: firstColor,
                        buttonFunction: () =>
                            Navigator.pushNamed(context, LoginScreen.id),
                        textColor: secondColor,
                        minwidth: MediaQuery.of(context).size.width / 3,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MyButton(
                        buttonText: 'Register',
                        buttonColor: firstColor,
                        buttonFunction: () =>
                            Navigator.pushNamed(context, RegisterScreen.id),
                        textColor: secondColor,
                        minwidth: MediaQuery.of(context).size.width / 2,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
