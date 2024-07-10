import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:local_auth/local_auth.dart';
import 'package:vtfriend/MainPage.dart';
import 'package:vtfriend/main.dart';

class passwordPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => passwordPageState();
}

class passwordPageState extends State<passwordPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: HexColor("#232946"),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Hero(
                    tag: 'mp',
                    child: Icon(
                      Icons.lock,
                      color: HexColor('#eebbc3'),
                      size: 60,
                      // shadows: [
                      //   BoxShadow(
                      //     color: Colors.white.withOpacity(0.5),
                      //     spreadRadius: 10,
                      //     blurRadius: 200,
                      //     offset: Offset(0, 3), // changes position of shadow
                      //   ),
                      // ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "oops,it's locked",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: HexColor("#eebbc3"),
                      // shadows: [
                      //   BoxShadow(
                      //     color: Colors.white.withOpacity(0.5),
                      //     spreadRadius: 20,
                      //     blurRadius: 200,
                      //     offset: Offset(0, 3), // changes position of shadow
                      //   ),
                      // ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                      onPressed: () async {
                        onpress();
                      },
                      child: Text(
                        "unlock",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: HexColor("#b8c1ec"),
                          // shadows: [
                          //   BoxShadow(
                          //     color: Colors.white.withOpacity(0.5),
                          //     spreadRadius: 2,
                          //     blurRadius: 100,
                          //     offset:
                          //         Offset(0, 3), // changes position of shadow
                          //   ),
                          // ],
                        ),
                      )),
                )
              ],
            ),
          ),
        ));
    throw UnimplementedError();
  }
}

onpress() async {
  final LocalAuthentication auth = LocalAuthentication();
  // ···
  final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
  final bool canAuthenticate =
      canAuthenticateWithBiometrics || await auth.isDeviceSupported();
  try {
    final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Please authenticate to show account balance',
        options: const AuthenticationOptions(biometricOnly: true));
    if (didAuthenticate == true) {
      print("authenticated");
      index = 0;
      lockStream.sink.add("");
      HavePush = false;
      autnecafrfq = true;
    }
    // ···
  } on PlatformException catch (e) {
    // ...
  }
}
