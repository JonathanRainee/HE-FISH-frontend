import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hefish_finalproject/class/fish_type.dart';
import 'package:hefish_finalproject/class/fishes.dart';
import 'package:hefish_finalproject/class/user.dart';
import 'package:hefish_finalproject/design/customTextField.dart';
import 'package:image_picker/image_picker.dart';

import '../class/color_palette.dart';

class EditFishPage extends StatefulWidget {
  final User user;
  final Fishes item;
  const EditFishPage({super.key, required this.user, required this.item});

  @override
  State<EditFishPage> createState() => _EditFishPageState();
}

class _EditFishPageState extends State<EditFishPage> {
  final fishType = ["Fresh Water", "Salt Water", "Brackish Water"];
  String fishTypeValue = "Fresh Water";

  TextEditingController fishNameCtrl = TextEditingController();
  TextEditingController fishPriceCtrl = TextEditingController();
  TextEditingController fishDescCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    fishTypeValue = widget.item.typeName;
    fishNameCtrl.text = widget.item.name;
    fishPriceCtrl.text = widget.item.price;
    fishDescCtrl.text = widget.item.description;
  }

  File? image;

  Future getImage() async {
    XFile? picked;
    try {
      showDialog(
          context: context,
          builder: ((context) => AlertDialog(
                backgroundColor: Colors.transparent,
                elevation: 0,
                alignment: Alignment.center,
                insetPadding: EdgeInsets.zero,
                content: Builder(
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 25),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          color: Palette.background,
                          height: 100,
                          width: 80,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Column(
                              children: [
                                const Text(
                                  "Choose a photo",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Palette.grey),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconButton(
                                        onPressed: () async {
                                          picked = await ImagePicker()
                                              .pickImage(
                                                  source: ImageSource.gallery);
                                          if (picked == null) {
                                            return;
                                          } else {
                                            setState(() =>
                                                image = File(picked!.path));
                                          }
                                          // ignore: use_build_context_synchronously
                                          Navigator.pop(context);
                                        },
                                        alignment: Alignment.center,
                                        icon: const Icon(
                                          Icons.photo_library_rounded,
                                          color: Palette.accent,
                                          size: 45,
                                        )),
                                    Container(
                                      width: 50,
                                    ),
                                    IconButton(
                                        onPressed: () async {
                                          picked = await ImagePicker()
                                              .pickImage(
                                                  source: ImageSource.camera);
                                          if (picked == null) {
                                            return;
                                          } else {
                                            setState(() =>
                                                image = File(picked!.path));
                                          }
                                          // ignore: use_build_context_synchronously
                                          Navigator.pop(context);
                                        },
                                        alignment: Alignment.center,
                                        icon: const Icon(
                                          Icons.camera_alt,
                                          color: Palette.accent,
                                          size: 45,
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )));
    } on PlatformException {
      const pwRecMsg = SnackBar(
        content: Text("Access Denied!"),
        backgroundColor: Palette.error,
        duration: Duration(seconds: 3),
      );
      ScaffoldMessenger.of(context).showSnackBar(pwRecMsg);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          titleSpacing: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Palette.background,
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
                      primary: Palette.background,
                      minimumSize: Size.zero,
                      padding: EdgeInsets.zero,
                    ),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 30,
                          color: Palette.black,
                        ),
                        Text(
                          "Back",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Palette.black),
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
        body: SingleChildScrollView(
          child: Container(
            color: Palette.background,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
              child: Column(
                children: [
                  Center(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: ElevatedButton(
                          onPressed: () {
                            getImage();
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            primary: Palette.background,
                            minimumSize: Size.zero,
                            padding: EdgeInsets.zero,
                          ),
                          child: image != null
                              ? Container(
                                  constraints: const BoxConstraints.expand(
                                    width: 160,
                                    height: 240,
                                  ),
                                  alignment: Alignment.bottomLeft,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: FileImage(image!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Container(
                                    color: const Color.fromRGBO(0, 0, 0, 0.5),
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 5, 10, 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: const [
                                          Icon(
                                            Icons.edit,
                                            size: 18,
                                          ),
                                          Text(
                                            " Choose Cover",
                                            style: TextStyle(fontSize: 14),
                                          )
                                        ],
                                      ),
                                    ),
                                  ))
                              : Stack(
                                  children: [
                                    Image.asset(
                                      widget.item.image_path,
                                      width: 160,
                                      height: 240,
                                      fit: BoxFit.cover,
                                    ),
                                    Container(
                                      constraints: const BoxConstraints.expand(
                                        width: 160,
                                        height: 240,
                                      ),
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        color:
                                            const Color.fromRGBO(0, 0, 0, 0.5),
                                        width: double.infinity,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 5, 10, 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: const [
                                              Icon(
                                                Icons.edit,
                                                size: 18,
                                              ),
                                              Text(
                                                " Choose Cover",
                                                style: TextStyle(fontSize: 14),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                        )),
                  ),
                  CustomTextField(
                      controller: fishNameCtrl,
                      hintText: "Fish Name",
                      keyboardType: TextInputType.name,
                      top: 45,
                      suffixIcon: Icons.abc),
                  Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Palette.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: DropdownButton(
                              dropdownColor: Palette.white,
                              isExpanded: true,
                              underline: Container(),
                              borderRadius: BorderRadius.circular(10),
                              icon: const Icon(Icons.keyboard_arrow_down),
                              value: fishTypeValue,
                              style: const TextStyle(fontSize: 16),
                              iconEnabledColor: Palette.grey,
                              elevation: 0,
                              hint: const Text("Fish Type"),
                              items: fishType.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(
                                    items,
                                    style: const TextStyle(
                                        color: Palette.black, fontSize: 16),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(
                                  () {
                                    fishTypeValue = value!;
                                  },
                                );
                              }),
                        ),
                      )),
                  CustomTextField(
                      controller: fishPriceCtrl,
                      hintText: "Fish Price",
                      keyboardType: TextInputType.number,
                      top: 25,
                      suffixIcon: Icons.abc),
                  Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: SizedBox(
                        height: 120,
                        width: double.infinity,
                        child: TextField(
                          controller: fishDescCtrl,
                          style: const TextStyle(fontSize: 16),
                          keyboardType: TextInputType.multiline,
                          maxLines: 7,
                          decoration: InputDecoration(
                            hintText: "Fish Description",
                            contentPadding: const EdgeInsets.all(15),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  style: BorderStyle.none,
                                  width: 0,
                                )),
                            filled: true,
                            fillColor: Palette.white,
                          ),
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Palette.accent,
                                      blurRadius: 3,
                                      spreadRadius: 0,
                                      offset: Offset(
                                        0.0,
                                        0.0,
                                      ),
                                    ),
                                  ]),
                              child: TextButton(
                                  onPressed: () {
                                    String errorMsg = "Updated fish article";
                                    Color snackBG;
                                    if (fishNameCtrl.text.isEmpty ||
                                        fishPriceCtrl.text.isEmpty ||
                                        fishDescCtrl.text.isEmpty ||
                                        fishTypeValue.isEmpty) {
                                      errorMsg =
                                          "Please fill all the article forms!";
                                      snackBG = Palette.error;
                                    } else {
                                      // ask for API
                                      if (1 < 4) {
                                        // post fish
                                        snackBG = Palette.success;
                                        Navigator.pop(context);
                                      } else {
                                        // error message ambil dari API nanti
                                        errorMsg = "Something went wrong!";
                                        snackBG = Palette.error;
                                      }
                                    }
                                    final message = SnackBar(
                                      content: Text(errorMsg),
                                      backgroundColor: snackBG,
                                      duration: const Duration(seconds: 3),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(message);
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Palette.accent),
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Palette.white),
                                    textStyle:
                                        MaterialStateProperty.all<TextStyle>(
                                            const TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                    )),
                                    shape: MaterialStateProperty.all<
                                        OutlinedBorder>(RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                                  ),
                                  child: const Text("Save"))))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
