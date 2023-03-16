import 'package:coffee_splashscreen/constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _coffeeController;
  bool copAnimated = false;
  bool animateCafeText = false;

  @override
  void initState() {
    super.initState();
    _coffeeController = AnimationController(vsync: this);
    _coffeeController.addListener(() {
      if (_coffeeController.value > 0.7) {
        _coffeeController.stop();
        copAnimated = true;
        setState(() {});
        Future.delayed(const Duration(seconds: 1), () {
          animateCafeText = true;
          setState(() {});
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _coffeeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: cafeBrown,
      body: Stack(
        children: [
          // White Container top half
          AnimatedContainer(
            duration: const Duration(seconds: 1),
            height: copAnimated ? screenHeight / 1.9 : screenHeight,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(copAnimated ? 40.0 : 0.0)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Visibility(
                  visible: !copAnimated,
                  child: Lottie.asset(
                    'assets/coffeesplash.json',
                    controller: _coffeeController,
                    onLoaded: (composition) {
                      _coffeeController
                        ..duration = composition.duration
                        ..forward();
                    },
                  ),
                ),
                Visibility(
                  visible: copAnimated,
                  child: Image.asset(
                    'assets/coffeepic2.png',
                    height: 190.0,
                    width: 190.0,
                  ),
                ),
                Center(
                  child: AnimatedOpacity(
                    opacity: animateCafeText ? 1 : 0,
                    duration: const Duration(seconds: 1),
                    child: Column(
                      children: [
                        const Padding(padding: EdgeInsets.only(bottom: 10.0)),
                        const Text(
                          'C A F É',
                          style: TextStyle(fontSize: 50.0, color: cafeBrown),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: const Text('Please Login to your Account',
                              style:
                                  TextStyle(fontSize: 17.0, color: cafeBrown)),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Text bottom part
          Visibility(visible: copAnimated, child: const _BottomPart()),
        ],
      ),
    );
  }
}

class _BottomPart extends StatelessWidget {
  const _BottomPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              // width: 250,
              child: const TextField(
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  labelStyle: TextStyle(color: Colors.white),
                  suffixIcon: Icon(
                    FontAwesomeIcons.envelope,
                    size: 17,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              // width: 250,
              child: const TextField(
                obscureText: true,
                decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.white),
                    suffixIcon: Icon(
                      FontAwesomeIcons.eyeSlash,
                      size: 17,
                      color: Colors.white,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 0, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Forget Password',
                    style: TextStyle(color: Colors.orangeAccent[700]),
                  )
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 15.0)),
            const Text(
              'Or Login using',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(padding: EdgeInsets.only(top: 20.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  FontAwesomeIcons.facebookF,
                  color: Colors.orangeAccent[700],
                ),
                Icon(
                  FontAwesomeIcons.twitter,
                  color: Colors.orangeAccent[700],
                ),
                Icon(
                  FontAwesomeIcons.google,
                  color: Colors.orangeAccent[700],
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            // Align(
            //   alignment: Alignment.centerRight,
            //   child: Container(
            //     height: 40.0,
            //     width: 40.0,
            //     decoration: BoxDecoration(
            //       shape: BoxShape.circle,
            //       border: Border.all(color: Colors.white, width: 2.0),
            //     ),
            //     child: const Icon(
            //       Icons.chevron_right,
            //       size: 30.0,
            //       color: Colors.white,
            //     ),
            //   ),
            // ),
            const SizedBox(height: 50.0),
          ],
        ),
      ),
    );
  }
}
