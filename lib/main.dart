import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ImageAnimationWidget(),
    );
  }
}


class ImageAnimationWidget extends StatefulWidget {
  const ImageAnimationWidget({super.key});

  @override
  ImageAnimationWidgetState createState() => ImageAnimationWidgetState();
}

class ImageAnimationWidgetState extends State<ImageAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  ValueNotifier <bool> visible=ValueNotifier(false);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _animationController = AnimationController(
      vsync: this,
      duration:const Duration(seconds: 10),
    );

    _animationController.forward();
    _animationController.addListener(() {
      if (_animationController.value > .2) {
          visible.value = true;
      }
      if (_animationController.value > .8) {
          visible.value = false;
      }
    });
    Animation<Offset> temo = Tween<Offset>(
      begin:const Offset(-1.0, 0.0),
      end:const Offset(2.5, 0.0),
    ).animate(_animationController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.repeat();
        }
      });
    return Scaffold(
        appBar: AppBar(
          title:const Text('Image Animation'),
        ),
        body: SlideTransition(
            position: temo,
            child: ValueListenableBuilder(
              valueListenable: visible,
              builder: (context,bool value, __) =>  AnimatedOpacity(
                opacity: value  ? 1.0 : 0.0,
                duration: const Duration(seconds: 1),
                child: Image.asset(
                  'assets/cloud.png',
                  width: 150,
                ),
              ),
            )));
  }
}
