import 'dart:convert';
import 'dart:io';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practice/main.dart';

class create1 extends StatefulWidget {
  const create1({Key? key}) : super(key: key);

  @override
  State<create1> createState() => _create1State();
}

class _create1State extends State<create1> {


  @override
  Widget build(BuildContext context) {

    double theight = MediaQuery.of(context).size.height;
    double twidth = MediaQuery.of(context).size.width;
    double statusbarheight = MediaQuery.of(context).padding.top;
    double navibartheight = MediaQuery.of(context).padding.bottom;
    double appbarheight =kToolbarHeight;

    double bodyheight = theight - navibartheight - statusbarheight;


    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return first();
        },));
      },),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Stack(children: [Container(
              height:  bodyheight,
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color(0xfff1e2cb),
                    Color(0xffc1c3c4),
                    Color(0xf0ced0de)
                  ])),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () async {
                      showAnimatedDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            actions: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      final ImagePicker picker = ImagePicker();
                                      final XFile? photo = await picker
                                          .pickImage(
                                          source: ImageSource.camera);
                                      setState(() {
                                        img = photo!.path;
                                      });
                                      print("========${img}");

                                      croppedFile =
                                      await ImageCropper().cropImage(
                                        sourcePath: photo!.path,
                                        uiSettings: [
                                          AndroidUiSettings(
                                              toolbarTitle: 'Cropper',
                                              toolbarColor: Colors.deepOrange,
                                              toolbarWidgetColor: Colors.white,
                                              initAspectRatio:
                                              CropAspectRatioPreset.original,
                                              lockAspectRatio: false),
                                          IOSUiSettings(
                                            title: 'Cropper',
                                          ),
                                        ],
                                      );

                                      setState(() {
                                        img = croppedFile!.path;
                                        print(croppedFile.runtimeType);
                                      });

                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                        decoration:
                                        BoxDecoration(shape: BoxShape.circle),
                                        height: 75,
                                        child: Image(
                                          image: AssetImage(
                                              "images/camera.png"),
                                          fit: BoxFit.fill,
                                        )),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      final ImagePicker picker = ImagePicker();
                                      // Pick an image
                                      final XFile? image = await picker
                                          .pickImage(
                                          source: ImageSource.gallery);

                                      setState(() {
                                        img = image!.path;
                                      });
                                      print("========${img}");

                                      croppedFile =
                                      await ImageCropper().cropImage(
                                        sourcePath: image!.path,
                                        uiSettings: [
                                          AndroidUiSettings(
                                              toolbarTitle: 'Cropper',
                                              toolbarColor: Colors.deepOrange,
                                              toolbarWidgetColor: Colors.white,
                                              initAspectRatio:
                                              CropAspectRatioPreset.original,
                                              lockAspectRatio: false),
                                          IOSUiSettings(
                                            title: 'Cropper',
                                          ),
                                        ],
                                      );

                                      setState(() {
                                        img = croppedFile!.path;
                                        print(croppedFile.runtimeType);
                                      });

                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                        decoration:
                                        BoxDecoration(shape: BoxShape.circle),
                                        height: 100,
                                        child: Image(
                                            image:
                                            AssetImage("images/gallary.jpg"))),
                                  )
                                ],
                              ),
                            ],
                          );
                        },
                        animationType: DialogTransitionType.slideFromBottomFade,
                        curve: Curves.fastOutSlowIn,
                        duration: Duration(seconds: 1),
                      );
                    },
                    child: img != ""
                        ? Container(
                      height: 150,
                      width: double.infinity,
                      child: CircleAvatar(
                        backgroundImage: FileImage(File(img)),
                        maxRadius: 20,
                      ),
                    )
                        : Container(
                        height:  bodyheight*0.25,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage("images/per2.jpg"),
                                fit: BoxFit.fitHeight))),
                  ),
                  InkWell(onTap: () {
                    var email = mail.text;
                    bool emailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(email);
                    print(emailValid);

                    setState(() {
                      mailstatus = emailValid;
                    });
                  },
                    child: Container(
                      height:bodyheight*0.10,
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            namestatus = false;
                          });
                        },
                        controller: name,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xe1000211), width: 2)),
                            labelText: "Name",
                            errorText:
                            namestatus ? "Pls fill Details....." : null),
                      ),
                    ),
                  ),
                  Container(
                    height:bodyheight*0.10,
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          mailstatus = false;
                        });
                      },
                      controller: mail,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.mail_outline),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  20))),
                          labelText: "Email",
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Color(0xe1000211), width: 2)),
                          errorText: mailstatus
                              ? "Pls fill Details....."
                              : null),
                    ),
                  ),
                  Container(
                    height:bodyheight*0.10,
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          monostatus = false;
                        });
                      },
                      controller: mono,
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  20))),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Color(0xe1000211), width: 2)),
                          labelText: "Phone No",
                          errorText: monostatus
                              ? "Pls fill Details....."
                              : null),
                    ),
                  ),
                  Container(
                    height:bodyheight*0.10,
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          passstatus = false;
                        });
                      },
                      controller: pass,
                      obscureText: show,
                      decoration: InputDecoration(
                          prefixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  if (show == false) {
                                    show = true;
                                  } else {
                                    show = false;
                                  }
                                });
                              },
                              icon: Icon(
                                  show ? Icons.visibility_off : Icons
                                      .visibility)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  20))),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Color(0xe1000211), width: 2),
                          ),
                          labelText: "Password",
                          errorText: passstatus
                              ? "Pls fill Details....."
                              : null),
                    ),
                  ),
                  FlutterPwValidator(
                    controller: pass,
                    defaultColor: Colors.black26,
                    successColor: Colors.black,
                    failureColor: Colors.red,
                    minLength: 8,
                    uppercaseCharCount: 1,
                    numericCharCount: 3,
                    specialCharCount: 1,
                    normalCharCount: 3,
                    width: 400,
                    height: 150,
                    onSuccess: () {
                      setState(() {
                        success = true;
                      });
                      print("MATCHED");
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Password is matched")));
                    },
                    onFail: () {
                      setState(() {
                        success = false;
                      });
                      print("NOT MATCHED");
                    },
                  ),
                  InkWell(
                      onTap: () async {
                        String name1 = name.text;
                        String mail1 = mail.text;
                        String mono1 = mono.text;
                        String pass1 = pass.text;

                        List<int> ii = File(img).readAsBytesSync();
                        String imagedata1 = base64Encode(ii);

                        if (name1.isEmpty ||
                            mail1.isEmpty ||
                            mono1.isEmpty ||
                            pass1.isEmpty) {
                          namestatus = true;
                          mailstatus = true;
                          monostatus = true;
                          passstatus = true;
                        }
                        else {
                          Map map = {
                            "name": name1,
                            "email": mail1,
                            "contact": mono1,
                            "password": pass1,
                            "imagedata": imagedata1
                          };

                          // search http
                          var url = Uri.parse(
                              'https://priyadevani.000webhostapp.com/Apicalling/Register.php');
                          var response = await http.post(url, body: map);
                          print('Response status: ${response.statusCode}');
                          print('Response body: ${response.body}');
                          print("done");

                          var ddd = jsonDecode(response.body);

                          My_Register mm = My_Register.fromJson(ddd);

                          if (mm.connection == 1) // connection
                              {
                            if (mm.result == 1) // first time data store
                                {

                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(
                                      "Registration Sucessfully.....")));
                            }
                            else if (mm.result == 2) {
                              Fluttertoast.showToast(
                                  msg: "Email already Exit....",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                            }
                          }

                        }

                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                          return first();
                        },)) ;
                      },
                      child: GlassmorphicContainer(
                        height:bodyheight*0.10,
                        width: 150,
                        borderRadius: 20,
                        blur: 20,
                        alignment: Alignment.bottomCenter,
                        border: 2,
                        linearGradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFFffffff).withOpacity(0.1),
                              Color(0xFFFFFFFF).withOpacity(0.05),
                            ],
                            stops: [
                              0.1,
                              1,
                            ]),
                        borderGradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFFffffff).withOpacity(0.5),
                            Color((0xFFFFFFFF)).withOpacity(0.5),
                          ],
                        ),
                        child: Center(
                            child: Text(
                              "Register",
                              style: TextStyle(
                                // color: Colors.white,
                                  fontSize:bodyheight*0.03,
                                  fontWeight: FontWeight.bold),
                            )),
                      )),
                ],
              ),
            ),],
            )),
      ),
    );
    ;
  }

  TextEditingController name = TextEditingController();
  TextEditingController mail = TextEditingController();
  TextEditingController mono = TextEditingController();
  TextEditingController pass = TextEditingController();

  bool namestatus = false;
  bool mailstatus = false;
  bool monostatus = false;
  bool passstatus = false;
  bool imagestatus = false;

  String name1 = "";
  String img = "";
  CroppedFile? croppedFile;
  bool show = false;
  Map map = {};
  bool success = false;
}
class My_Register {
  int? connection;
  int? result;

  My_Register({this.connection, this.result});

  My_Register.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    return data;
  }
}
// class My_Register {
//   int? connection;
//   int? result;
//
//   My_Register({this.connection, this.result});
//
//   My_Register.fromJson(Map<String, dynamic> json) {
//     connection = json['connection'];
//     result = json['result'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['connection'] = this.connection;
//     data['result'] = this.result;
//     return data;
//   }
// }



