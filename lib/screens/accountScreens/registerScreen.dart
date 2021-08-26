import 'package:flutter/material.dart';
import 'package:task/helper/database/sqlite.dart';
import 'package:task/helper/providerHelper.dart';
import 'package:task/helper/sharedPre.dart';

import '../../reuseableWidget.dart';
import '../homeScreen.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  static final String id = 'RegisterScreen';
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

final _formKey = GlobalKey<FormState>();

String errorText = '';
bool isLoading = false;

TextEditingController nameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController conPasswordController = TextEditingController();
TextEditingController referralController = TextEditingController();

FocusNode nameFocuseNode = FocusNode();
FocusNode emailFocuseNode = FocusNode();
FocusNode passwordFocuseNode = FocusNode();
FocusNode conPasswordFocuseNode = FocusNode();
FocusNode referralFocuseNode = FocusNode();

class _RegisterScreenState extends State<RegisterScreen> {
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
                LoginScreenHeader(headerText: 'REGISTER'),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      InputContainer(
                        controller: nameController,
                        valid: (value) {
                          if (value.length >= 5)
                            return null;
                          else
                            return "your name must be longer than 4 letter";
                        },
                        placeHolderText: 'Full name',
                        newWidth: 4 * MediaQuery.of(context).size.width / 5,
                        focusNode: nameFocuseNode,
                        obscureTextValue: false,
                        onchange: () {},
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InputContainer(
                        onchange: () {},
                        controller: emailController,
                        valid: (value) {
                          if (RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                            return null;
                          } else
                            return 'enter valid email';
                        },
                        obscureTextValue: false,
                        placeHolderText: 'Email',
                        newWidth: 4 * MediaQuery.of(context).size.width / 5,
                        focusNode: emailFocuseNode,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InputContainer(
                        controller: passwordController,
                        valid: (value) {
                          if (value.length >= 7)
                            return null;
                          else
                            return "your password must be longer than 7 letters";
                        },
                        keyboardType: TextInputType.emailAddress,
                        placeHolderText: 'Password',
                        newWidth: 4 * MediaQuery.of(context).size.width / 5,
                        focusNode: passwordFocuseNode,
                        obscureTextValue: true,
                        onchange: () {},
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InputContainer(
                        controller: conPasswordController,
                        valid: (value) {
                          if (value == passwordController.text)
                            return null;
                          else
                            return "enter the same password";
                        },
                        keyboardType: TextInputType.emailAddress,
                        placeHolderText: 'Confirm Password',
                        newWidth: 4 * MediaQuery.of(context).size.width / 5,
                        focusNode: conPasswordFocuseNode,
                        obscureTextValue: true,
                        onchange: () {},
                      ),
                      SizedBox(
                        height: 10,
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
                      MyGradiantButton(
                        buttonText: 'Register',
                        buttonFunction: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              errorText = "";
                            });
                            if (await validEmail(emailController.text)) {
                              DatabaseHelper.addRowToDataBase(
                                nameController.text,
                                emailController.text,
                                passwordController.text,
                                "",
                              ).then(
                                (value) async {
                                  SharedPre.setUserEmail(emailController.text);
                                  context.read<ProviderHelper>().hasLoggedIn =
                                      true;
                                  context.read<ProviderHelper>().email =
                                      emailController.text;
                                  context.read<ProviderHelper>().name =
                                      nameController.text;
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, HomeScreen.id, (route) => false);
                                },
                              );
                            } else {
                              setState(() {
                                errorText = "This account is already in use";
                              });
                            }
                          }
                        },
                        minwidth: MediaQuery.of(context).size.width / 2,
                      )
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

  Future<bool> validEmail(String email) async {
    bool test = false;
    List li = await DatabaseHelper.getTheTableRowData(email);
    if (li.length == 0) test = true;
    return test;
  }
}
