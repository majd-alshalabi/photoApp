import 'package:flutter/material.dart';
import 'package:task/reuseableWidget.dart';

import '../constant.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
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
                  'IMAGE APP',
                  style: TextStyle(letterSpacing: 2),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
