// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hefish_finalproject/class/color_palette.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hefish_finalproject/class/fishes.dart';
import 'package:http/http.dart' as http;

import '../class/user.dart';
import '../design/animatedPageRoute.dart';
import 'fishesPage.dart';

class HomePage extends StatefulWidget {
  final User user;
  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late Future<List<Fishes>> fishList;

  Future<List<Fishes>> fetchFishes() async{
    // String url = "http://10.0.2.2:3000/fishes";
    String url = "http://localhost:3000/fishes";


    var resp = await http.get(Uri.parse(url));
    var res = jsonDecode(resp.body);
    print(res);
    List<Fishes> fishlist = [];
    return fishlist;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // fetchFishes();
  }

  final List<String> carousel_img = [
    "assets/images/carousel/cyberpunk-city-7415576__340.jpg",
    "assets/images/carousel/dreaming-7415565__340.jpg",
    "assets/images/carousel/popart-4809534__340.jpg",
    "assets/images/carousel/studio-ghibli-7415572__340.jpg",
    "assets/images/carousel/wallpaper-7415571__340.jpg"
  ];

  List<Widget> carousel_style() {
    return carousel_img
        .map((item) => Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.asset(item, fit: BoxFit.cover),
            )))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Palette.background,
            title: Padding(
              padding: const EdgeInsets.fromLTRB(15, 20, 15, 15),
              child: Row(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Image.asset(
                          "assets/images/HEfish logo no-text.png",
                          height: 30,
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Row(
                          children: const [
                            Text(
                              "HE ",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w800,
                                  color: Palette.black),
                            ),
                            Text(
                              "Fish",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 1,
                                  color: Palette.black),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        Navigator.popUntil(
                            context, (Route<dynamic> route) => route.isFirst);
                      },
                      icon: const Icon(
                        Icons.logout,
                        size: 30,
                        color: Palette.error,
                      ))
                ],
              ),
            ),
          ),
          resizeToAvoidBottomInset: false,
          backgroundColor: Palette.background,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Hello, ${widget.user.username}!",
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600),
                        ))),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: CarouselSlider(
                    items: carousel_style(),
                    options: CarouselOptions(
                      height: 350,
                      autoPlay: true,
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 1500),
                      autoPlayInterval: const Duration(seconds: 3),
                      enableInfiniteScroll: true,
                      enlargeCenterPage: false,
                      disableCenter: true,
                    ),
                  ),
                ),
                const Padding(
                    padding: EdgeInsets.fromLTRB(20, 25, 20, 0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Collections",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600),
                        ))),
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: Palette.background,
                                minimumSize: Size.zero,
                                padding: EdgeInsets.zero,
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(7.5),
                                    child: Expanded(
                                      child: Image.asset(
                                        "assets/images/collections_fresh water.png",
                                        height: 85,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      "Fresh Water",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Palette.black),
                                      textAlign: TextAlign.left,
                                    ),
                                  )
                                ],
                              ),
                              onPressed: () {
                                Navigator.of(context).push(AnimatedPageRoute(
                                    child: FishesPage(
                                  "Fresh Water",
                                  user: widget.user,
                                )));
                              },
                            )),
                            Container(
                              width: 10,
                            ),
                            Expanded(
                                child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: Palette.background,
                                minimumSize: Size.zero,
                                padding: EdgeInsets.zero,
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(7.5),
                                    child: Expanded(
                                      child: Image.asset(
                                        "assets/images/collections_salt water.png",
                                        width: double.infinity,
                                        height: 85,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      "Salt Water",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Palette.black),
                                      textAlign: TextAlign.left,
                                    ),
                                  )
                                ],
                              ),
                              onPressed: () {
                                Navigator.of(context).push(AnimatedPageRoute(
                                    child: FishesPage(
                                  "Salt Water",
                                  user: widget.user,
                                )));
                              },
                            ))
                          ],
                        ),
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        Row(
                          children: [
                            Expanded(
                                child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: Palette.background,
                                minimumSize: Size.zero,
                                padding: EdgeInsets.zero,
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(7.5),
                                    child: Expanded(
                                      child: Image.asset(
                                        "assets/images/collections_brackish water.png",
                                        height: 85,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      "Brackish Water",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Palette.black),
                                      textAlign: TextAlign.left,
                                    ),
                                  )
                                ],
                              ),
                              onPressed: () {
                                Navigator.of(context).push(AnimatedPageRoute(
                                    child: FishesPage(
                                  "Brackish Water",
                                  user: widget.user,
                                )));
                              },
                            )),
                            Container(
                              width: 10,
                            ),
                            Expanded(
                                child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: Palette.background,
                                minimumSize: Size.zero,
                                padding: EdgeInsets.zero,
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(7.5),
                                    child: Expanded(
                                      child: Image.asset(
                                        "assets/images/collections_all ecosystems.png",
                                        height: 85,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      "All Ecosystems",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Palette.black),
                                      textAlign: TextAlign.left,
                                    ),
                                  )
                                ],
                              ),
                              onPressed: () {
                                Navigator.of(context).push(AnimatedPageRoute(
                                    child: FishesPage(
                                  "All Ecosystems",
                                  user: widget.user,
                                )));
                              },
                            ))
                          ],
                        )
                      ],
                    ))
              ],
            ),
          )),
    );
  }
}
