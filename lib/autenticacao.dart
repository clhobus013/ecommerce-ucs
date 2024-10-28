import 'package:ecommerce/listaProdutos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:local_auth/local_auth.dart';

class Autenticacao extends StatefulWidget {
  const Autenticacao({super.key});

  @override
  State<Autenticacao> createState() => _AutenticacaoState();
}

class _AutenticacaoState extends State<Autenticacao> {
  final LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;

  @override
  void initState() {
    super.initState();
    auth.isDeviceSupported().then((bool isSupported) => {
          setState(() => _supportState = isSupported
              ? _SupportState.supported
              : _SupportState.unsupported),
          if (isSupported) {_authenticate()}
        });
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: 'Confirme sua identidade para acessar o app',
        options: const AuthenticationOptions(
          stickyAuth: true,
        ),
      );
      if (authenticated) {
        print("AUTENTICADO!! IR PARA PROXIMA PÁGINA");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ListaProdutos()));
      }
    } on PlatformException catch (e) {
      print(e);
      return;
    }
    if (!mounted) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_supportState != _SupportState.supported)
            const Text(
              'Sem suporte para API de segurança!',
              style: TextStyle(
                  fontSize: 15, color: Color.fromARGB(255, 226, 89, 79)),
            ),
          const SizedBox(
            height: 20,
          ),
          const FaIcon(
            FontAwesomeIcons.cartShopping,
            size: 70,
            color: Color.fromARGB(255, 54, 112, 189),
          ),
          const Text(
            "Compraki",
            style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 54, 112, 189)),
          ),
          const SizedBox(
            height: 60,
          ),
          ElevatedButton(
            onPressed: _authenticate,
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.black),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Autenticar',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                Icon(
                  Icons.perm_device_information,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

enum _SupportState {
  unknown,
  supported,
  unsupported,
}
