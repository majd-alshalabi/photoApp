import 'package:flutter/material.dart';
import 'package:task/helper/database/sqlite.dart';
import 'package:task/helper/sharedPre.dart';
import 'package:task/screens/homeScreen.dart';

import '../../reuseableWidget.dart';

class LoginScreen extends StatefulWidget {
  static final String id = 'LoginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

final formGlobalKey = GlobalKey<FormState>();

String errorText = '';
bool isLoading = false;

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

FocusNode userFocuseNode = FocusNode();
FocusNode passwordFocuseNode = FocusNode();

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          Container(
            height: MediaQuery.of(context).size.height - 40,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                LoginScreenHeader(
                  headerText: 'SIGN IN',
                ),
                Form(
                  key: formGlobalKey,
                  child: Column(
                    children: [
                      InputContainer(
                        controller: emailController,
                        valid: (value) {
                          if (RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                            return null;
                          } else
                            return 'enter valid email';
                        },
                        keyboardType: TextInputType.emailAddress,
                        placeHolderText: 'Email',
                        newWidth: 4 * MediaQuery.of(context).size.width / 5,
                        focusNode: userFocuseNode,
                        obscureTextValue: false,
                        onchange: () {},
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InputContainer(
                        onchange: () {},
                        controller: passwordController,
                        valid: (value) {
                          if (value.length >= 8) {
                            return null;
                          } else
                            return 'your password must be more the 7 letters';
                        },
                        obscureTextValue: true,
                        placeHolderText: 'Password',
                        newWidth: 4 * MediaQuery.of(context).size.width / 5,
                        focusNode: passwordFocuseNode,
                      ),
                      Container(
                        child: Text(
                          errorText,
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                        margin: EdgeInsets.only(top: 10),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width / 10),
                        child: InkWell(
                          onTap: () {},
                          child: Text(
                            'Forget Password ?',
                          ),
                        ),
                        width: MediaQuery.of(context).size.width,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      MyGradiantButton(
                          buttonText: 'Login in',
                          buttonFunction: () async {
                            if (formGlobalKey.currentState!.validate()) {
                              List<Map> dataList =
                                  await DatabaseHelper.getTheTableRowData(
                                      emailController.text);

                              if (dataList.length == 0) {
                                print('00');
                                setState(() {
                                  errorText = 'enter correct data';
                                });
                              } else if (dataList[0]
                                      [DatabaseHelper.columnPassword] ==
                                  passwordController.text) {
                                setState(() {
                                  errorText = '';
                                });
                                SharedPre.setUserEmail(
                                  emailController.text,
                                ).then(
                                  (value) => Navigator.pushNamedAndRemoveUntil(
                                      context, HomeScreen.id, (route) => false),
                                );
                              } else {
                                setState(() {
                                  errorText = 'enter correct data';
                                });
                              }
                            }
                          },
                          minwidth: MediaQuery.of(context).size.width / 3),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
