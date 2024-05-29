import 'package:camera/camera.dart';
import 'package:detect_mask_v2/main.dart';

import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //Definir el requisito de instancia
  late CameraImage cameraImage;
  late CameraController cameraController;
  //variables
  bool isWorking = false;
  String result = '';

  get response => null;

  initCamera() {
    cameraController = CameraController(camera[0], ResolutionPreset.medium);
    cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }

      setState(() {
        cameraController.startImageStream((imageFromStream) {
          if (!isWorking) {
            isWorking = true;
            cameraImage = imageFromStream;
            runModelOnFrame();
          }
        });
      });
    });
  }

  runModelOnFrame() async {
    if (cameraImage != null){
          var recognitions = await Tflite.runModelOnFrame(
        bytesList: cameraImage.planes.map((plane) {
          return plane.bytes;
        }).toList(),
        imageHeight: cameraImage.height,
        imageWidth: cameraImage.width,
        imageMean: 127.5,
        imageStd: 127.5,
        rotation: 90,
        numResults: 1,
        threshold: 0.1,
        asynch: true);

    result = "";

    recognitions?.forEach((resonse) {
      result += response["label"] + "\n";
    });

    setState(() {
      //result
    });

    isWorking = false;

    }

  }

  loadModel() async {
    await Tflite.loadModel(
        model: "assets/model.tflite", 
        labels: "assets/labels.txt");
  }

  @override
  void initState() {
    initCamera();
    super.initState();
    loadModel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: SafeArea(
            child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: result.isEmpty
            ? const Text('ENFOQUE EL ROSTRO')
            : Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Text(
                  result,
                )),
        centerTitle: true,
      ),
      body: Container(
        child: (!cameraController.value.isInitialized)
            ? Container()
            : Align(
                alignment: Alignment.center,
                child: AspectRatio(
                  aspectRatio: cameraController.value.aspectRatio,
                  child: CameraPreview(cameraController),
                ),
              ),
      ),
      backgroundColor: Colors.black,
    )));
  }
}
