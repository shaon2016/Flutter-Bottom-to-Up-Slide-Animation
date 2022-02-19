import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late AnimationController addToCartPopUpAnimationController;

  @override
  void initState() {
    addToCartPopUpAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));

    super.initState();
  }

  @override
  void dispose() {
    addToCartPopUpAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animation Example"),
      ),
      body: Stack(
        children: [
          Center(
            child: ElevatedButton(onPressed: () {
              addToCartPopUpAnimationController.forward();

              Timer(const Duration(seconds: 3), () {
                addToCartPopUpAnimationController.reverse();
              });
            }, child: const Icon(Icons.slideshow)),
          ),
          addToCartPopUp(),
        ],
      ),
    );
  }

  addToCartPopUp() {
    return SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
            .animate(addToCartPopUpAnimationController),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Wrap(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 12,
                margin: const EdgeInsets.all(15),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Icon(Icons.add_shopping_cart),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Successfully added to cart",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          InkWell(
                            onTap: () {},
                            child: const Text(
                              "Go to cart",
                              style: TextStyle(
                                color: Color(0xff535960),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      )),
                      const SizedBox(
                        width: 15,
                      ),
                      InkWell(
                          onTap: () {
                            addToCartPopUpAnimationController.reverse();
                          },
                          child: const Icon(Icons.cancel)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
