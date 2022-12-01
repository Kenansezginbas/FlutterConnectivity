import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Connectivity _connectivity = Connectivity();
  ConnectivityResult _connectivityStatus = ConnectivityResult.none;
  late StreamSubscription<ConnectivityResult> _streamSubscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initConnectivity();
    _streamSubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          _connectivityStatus == ConnectivityResult.none
              ? "Baglanti yok"
              : "Baglanti saglandi $_connectivityStatus",
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }

  Future<void> _initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.message);
    }
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectivityStatus = result;
      print(result.name.toString());
    });
  }
}
