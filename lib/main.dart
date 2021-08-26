import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task/constant.dart';
import 'package:task/helper/database/sqlite.dart';
import 'package:task/helper/providerHelper.dart';
import 'package:provider/provider.dart';
import 'package:task/helper/sharedPre.dart';
import 'package:task/screens/accountScreens/loginScreen.dart';
import 'package:task/screens/accountScreens/registerScreen.dart';
import 'package:task/screens/accountScreens/welecomScreen.dart';
import 'package:task/screens/detailsScreen.dart';
import 'package:task/screens/homeScreen.dart';
import 'package:task/screens/loadingScreen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  ).then(
    (value) => runApp(
      ChangeNotifierProvider<ProviderHelper>(
        create: (context) => ProviderHelper(),
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

bool loading = true;

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initStateFunction();
  }

  void initStateFunction() async {
    SharedPre.getUserEmail().then((value) {
      if (value != "") {
        context.read<ProviderHelper>().setHasLoggedIn(true);
        DatabaseHelper.getTheTableRowData(value).then((val) {
          context.read<ProviderHelper>().email = value;
          context.read<ProviderHelper>().name =
              val[0][DatabaseHelper.columnName];
        });
      }
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          loading = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: firstColor,
        iconTheme: IconThemeData(color: secondColor),
        appBarTheme: AppBarTheme(
          color: firstColor,
          elevation: 0,
        ),
      ),
      routes: {
        RegisterScreen.id: (BuildContext context) => RegisterScreen(),
        LoginScreen.id: (BuildContext context) => LoginScreen(),
        HomeScreen.id: (BuildContext context) => HomeScreen(),
        WelecomScreen.id: (BuildContext context) => WelecomScreen(),
        DetailsScreen.id: (BuildContext context) => DetailsScreen(),
      },
      home: loading
          ? LoadingScreen()
          : context.read<ProviderHelper>().hasLoggedIn
              ? HomeScreen()
              : WelecomScreen(),
    );
  }
}
