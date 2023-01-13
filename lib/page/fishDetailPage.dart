import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hefish_finalproject/class/fishes.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:hefish_finalproject/page/editFishPage.dart';

import '../class/color_palette.dart';
import '../class/user.dart';
import '../design/animatedPageRoute.dart';

class FishDetailPage extends StatefulWidget {
  final User user;
  // final Fishes item;
  final String imagePath;
  final String name;
  final String authorName;
  final String price;
  final int id;
  const FishDetailPage(
      {super.key,
      required this.id,
      required this.imagePath,
      required this.name,
      required this.authorName,
      required this.price,
      required this.user});

  @override
  State<FishDetailPage> createState() => _FishDetailPageState();
}

class _FishDetailPageState extends State<FishDetailPage> {
  String author = "NULL"; // ambil dari Id
  String type = "NULL"; // ambil dari Id

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: SpeedDial(
        marginBottom: MediaQuery.of(context).size.height * 0.515,
        marginEnd: MediaQuery.of(context).size.width - 80,
        elevation: 0,
        icon: Icons.menu,
        activeIcon: Icons.close,
        backgroundColor: Palette.accent,
        activeBackgroundColor: Palette.grey,
        foregroundColor: Palette.white,
        // visible: widget.user.id == widget.item.user_id,
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.transparent,
        overlayOpacity: 0.5,
        shape: const CircleBorder(),
        children: [
          SpeedDialChild(
            child: const Icon(Icons.delete_forever_rounded),
            backgroundColor: Palette.error,
            foregroundColor: Palette.white,
            elevation: 0,
            onTap: () => print('Delete Tapped'),
          ),
          SpeedDialChild(
            child: const Icon(Icons.edit_rounded),
            backgroundColor: Palette.accent,
            foregroundColor: Palette.white,
            elevation: 0,
            // onTap: () {
            //   Navigator.of(context).push(AnimatedPageRoute(
            //       child: EditFishPage(
            //     item: widget.item,
            //     user: widget.user,
            //   )));
            // },
          ),
        ],
      ),
      appBar: AppBar(
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 15),
          child: Row(
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    primary: Colors.transparent,
                    minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                  ),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 30,
                        color: Palette.white,
                      ),
                      Text(
                        "Back",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Palette.white),
                      )
                    ],
                  )),
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
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.topCenter,
            child: FractionallySizedBox(
              widthFactor: 1,
              heightFactor: 0.6,
              child: Image.network(
                widget.imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              widthFactor: 1,
              heightFactor: 0.55,
              child: Container(
                decoration: const BoxDecoration(
                    color: Palette.background,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30))),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 50, 30, 0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.name,
                          style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              color: Palette.black),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.price,
                          style: const TextStyle(
                              fontSize: 20, color: Palette.grey),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Author",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Palette.grey),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                widget.authorName,
                                style: const TextStyle(
                                    fontSize: 16, color: Palette.grey),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Type",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Palette.grey),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              // child: Text(
                              //   widget.item.typeName,
                              //   style: const TextStyle(
                              //       fontSize: 16, color: Palette.grey),
                              // ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Description",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Palette.grey),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              // child: Text(
                              //   widget.item.description,
                              //   style: const TextStyle(
                              //       fontSize: 16, color: Palette.grey),
                              // ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
