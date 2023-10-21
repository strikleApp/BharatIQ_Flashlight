import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class FlashlightScreen extends StatefulWidget {
  final CameraDescription camera;

  const FlashlightScreen({super.key, required this.camera});

  @override
  FlashlightScreenState createState() => FlashlightScreenState();
}

class FlashlightScreenState extends State<FlashlightScreen> {
  late CameraController _controller;
  bool _isFlashOn = false;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.camera, ResolutionPreset.high);
    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggleFlashlight() {
    if (_isFlashOn) {
      _controller.setFlashMode(FlashMode.off);
    } else {
      _controller.setFlashMode(FlashMode.torch);
    }
    setState(() {
      _isFlashOn = !_isFlashOn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      backgroundColor: _isFlashOn
          ? Theme.of(context).scaffoldBackgroundColor
          : Colors.black12,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(2),
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _isFlashOn ? Colors.yellowAccent : Colors.transparent,
          ),
          child: ElevatedButton(
            onPressed: toggleFlashlight,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.white,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(20),
            ),
            child: Image.asset(
              _isFlashOn
                  ? 'asset/flashlight_on.png'
                  : 'asset/flashlight_off.png',
              height: 60,
              width: 60,
            ),
          ),
        ),
      ),
    );
  }
}
