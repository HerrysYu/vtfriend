import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:vtfriend/MainPage.dart';

class passwordPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => passwordPageState();
}

class passwordPageState extends State<passwordPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final LocalAuthentication auth = LocalAuthentication();
            // ···
            final bool canAuthenticateWithBiometrics =
                await auth.canCheckBiometrics;
            final bool canAuthenticate =
                canAuthenticateWithBiometrics || await auth.isDeviceSupported();
            try {
              final bool didAuthenticate = await auth.authenticate(
                  localizedReason:
                      'Please authenticate to show account balance',
                  options: const AuthenticationOptions(biometricOnly: true));
              if (didAuthenticate == true) {
                print("authenticated");
                Navigator.pop(context);
                ispush = false;
                autnecafrfq = true;
              }
              // ···
            } on PlatformException catch (e) {
              // ...
            }
          },
          child: Text("grehgiewhufiubiUfb9pweg9fg979"),
        ),
      ),
    );
    throw UnimplementedError();
  }
}
