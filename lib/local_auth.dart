import 'package:flutter/material.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mytodo/homepage.dart';

class LocalAuth extends StatefulWidget {
  @override
  _LocalAuthState createState() => _LocalAuthState();
}

class _LocalAuthState extends State<LocalAuth> {
  bool isAuth = false;

  void _checkBiometric() async {
    // check for biometric availability
    final LocalAuthentication auth = LocalAuthentication();
    bool canCheckBiometrics = false;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } catch (e) {
      print("error biome trics $e");
    }

    print("biometric is available: $canCheckBiometrics");

    // enumerate biometric technologies
    List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } catch (e) {
      print("error enumerate biometrics $e");
    }

    print("following biometrics are available");
    if (availableBiometrics.isNotEmpty) {
      availableBiometrics.forEach((ab) {
        print("\ttech: $ab");
      });
    } else {
      print("no biometrics are available");
    }

    // authenticate with biometrics
    bool authenticated = false;
    try {
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: 'Verify your fingerprint for accessing MyToDo.',
          useErrorDialogs: true,
          stickyAuth: false,
          androidAuthStrings: AndroidAuthMessages(signInTitle: "Welcome !!"));
    } catch (e) {
      print("error using biometric auth: $e");
    }
    setState(() {
      isAuth = authenticated ? true : false;
    });

    print("authenticated: $authenticated");
  }

  @override
  Widget build(BuildContext context) {
    return isAuth
        ? HomePage()
        : Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'My Todo',
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 80,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(15.0)),
                  RaisedButton.icon(
                    onPressed: () {
                      _checkBiometric();
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    label: Text(
                      'Verify Your Finger Print' + '\n' + '"Click Here"',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    icon: Icon(
                      Icons.fingerprint,
                      color: Colors.white,
                    ),
                    textColor: Colors.white,
                    color: Colors.green,
                  ),
                ],
              ),
            ));
  }
}
