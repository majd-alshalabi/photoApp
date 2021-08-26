import 'package:flutter/material.dart';
import 'package:task/constant.dart';
import 'package:task/helper/providerHelper.dart';
import 'package:provider/provider.dart';
import 'package:task/helper/sharedPre.dart';
import 'package:task/screens/accountScreens/welecomScreen.dart';

class MyGradiantButton extends StatelessWidget {
  final String buttonText;

  final Function buttonFunction;

  final double minwidth;

  MyGradiantButton(
      {required this.buttonText,
      required this.buttonFunction,
      required this.minwidth});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          gradient: linearGradient,
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          child: MaterialButton(
            minWidth: minwidth,
            onPressed: () {
              buttonFunction();
            },
            height: 42.0,
            child: Text(
              buttonText,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                color: firstColor,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Function buttonFunction;
  final Color textColor;
  final double minwidth;

  MyButton(
      {required this.buttonText,
      required this.buttonColor,
      required this.buttonFunction,
      required this.textColor,
      required this.minwidth});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: buttonColor,
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
      child: MaterialButton(
        elevation: 5.0,
        minWidth: minwidth,
        onPressed: () {
          buttonFunction();
        },
        height: 42.0,
        child: Text(
          buttonText,
          style: TextStyle(
            fontWeight: FontWeight.w300,
            color: textColor,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}

class InputContainer extends StatefulWidget {
  final String placeHolderText;
  final double newWidth;
  final TextEditingController controller;
  final bool obscureTextValue;
  final keyboardType;
  final Function valid;
  final Function onchange;
  final FocusNode focusNode;

  InputContainer({
    required this.placeHolderText,
    required this.newWidth,
    required this.controller,
    required this.obscureTextValue,
    this.keyboardType,
    required this.valid,
    required this.onchange,
    required this.focusNode,
  });
  @override
  _InputContainerState createState() => _InputContainerState();
}

class _InputContainerState extends State<InputContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.newWidth,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextFormField(
        onTap: () {
          setState(() {
            FocusScope.of(context).requestFocus(widget.focusNode);
          });
        },
        focusNode: widget.focusNode,
        onChanged: widget.onchange(),
        textInputAction: TextInputAction.next,
        validator: (value) {
          return widget.valid(value);
        },
        obscureText: widget.obscureTextValue,
        keyboardType: widget.keyboardType == null
            ? TextInputType.text
            : widget.keyboardType,
        controller: widget.controller,
        cursorColor: secondColor,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          labelText: widget.placeHolderText == 'Referral (if you have)'
              ? widget.focusNode.hasFocus
                  ? 'Referral'
                  : widget.placeHolderText
              : widget.placeHolderText,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: firstColor,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 1, color: Colors.grey),
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(width: 1, color: Colors.red)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(width: 1, color: Colors.red)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: secondColor,
              width: 1.0,
            ),
          ),
          labelStyle: TextStyle(
              color: widget.focusNode.hasFocus ? secondColor : Colors.grey),
        ),
      ),
    );
  }
}

class LoginScreenHeader extends StatelessWidget {
  final String headerText;

  const LoginScreenHeader({required this.headerText});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadiantGradientMask(
          child: Icon(
            Icons.imagesearch_roller_outlined,
            size: MediaQuery.of(context).size.width / 5,
            color: firstColor,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          headerText,
          style: TextStyle(letterSpacing: 2),
        ),
        Text(
          'TO CONTNUE',
          style: TextStyle(letterSpacing: 2),
        ),
      ],
    );
  }
}

class RadiantGradientMask extends StatelessWidget {
  RadiantGradientMask({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => linearGradient.createShader(bounds),
      child: child,
    );
  }
}

class MainDrawar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            child: DrawerHeader(
                decoration: BoxDecoration(
                  color: secondColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                    ),
                    Text(
                      context.read<ProviderHelper>().name,
                      style: TextStyle(
                          color: firstColor, letterSpacing: 1, fontSize: 20),
                    ),
                    Text(
                      context.read<ProviderHelper>().email,
                      style: TextStyle(
                          color: firstColor, letterSpacing: 1, fontSize: 12),
                    )
                  ],
                )),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ListTile(
                  title: InkWell(
                    onTap: () {
                      SharedPre.setUserEmail("").then((value) {
                        context.read<ProviderHelper>().hasLoggedIn = false;
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          WelecomScreen.id,
                          (route) => false,
                        );
                      });
                    },
                    child: Row(
                      children: [Icon(Icons.logout), Text('Log out')],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
