import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practice/main.dart';
import 'package:practice/splash.dart';
import 'package:practice/view2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

class home1 extends StatefulWidget {
  static SharedPreferences? pref;

  const home1({Key? key}) : super(key: key);

  @override
  State<home1> createState() => _home1State();
}

class _home1State extends State<home1> {
  String? imagepath;
  String? nameee;
  String? maillll;
  String? id;
  int currentPageIndex = 0;
  bool image1 = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getvalue();
    Future.delayed(Duration(seconds: 4)).then((value) {
      setState(() {
        image1 = true;
      });
    });
  }

  getvalue() {
    id = splash.pref!.getString("id") ?? "";
    imagepath = splash.pref!.getString("imagename") ?? "";
    nameee = splash.pref!.getString("name") ?? "";
    maillll = splash.pref!.getString("email") ?? "";
  }

  List<Widget> list = [Viewdata(), adddata()];

  int cnt = 0;

  @override
  Widget build(BuildContext context) {
    double theight = MediaQuery.of(context).size.height;
    double twidth = MediaQuery.of(context).size.width;
    double statusbarheight = MediaQuery.of(context).padding.top;
    double navibartheight = MediaQuery.of(context).padding.bottom;
    double appbarheight = kToolbarHeight;

    double bodyheight = theight -
        navibartheight -
        statusbarheight -
        appbarheight -
        navibartheight;

    return Scaffold(
        appBar: cnt == 1
            ? AppBar(
          backgroundColor: Colors.black,
          actions: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://priyadevani.000webhostapp.com/Apicalling/$imagepath'),
            )
          ],
          title: Text(
            "Addpage",
            style: TextStyle(
                fontSize: bodyheight * 0.03, fontWeight: FontWeight.bold),
          ),
        )
            : AppBar(
          title: Text(
            "Homepage",
            style: TextStyle(
                fontSize: bodyheight * 0.03, fontWeight: FontWeight.bold),
          ),
        ),
        drawer: Drawer(
            child: ListView(
              children: [
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color(0xff111010),
                        Color(0xff666161),
                        Color(0xffd5c1c1)
                      ])),
                  currentAccountPicture: InkWell(
                      onTap: () {
                        showAnimatedDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              actions: [
                                Center(
                                  child: Container(
                                    height: bodyheight * 0.25,
                                    child: Image.network(
                                        'https://priyadevani.000webhostapp.com/Apicalling/$imagepath',
                                        fit: BoxFit.fill),
                                  ),
                                ),
                              ],
                            );
                          },
                          animationType: DialogTransitionType.slideFromBottomFade,
                          curve: Curves.fastOutSlowIn,
                          duration: Duration(seconds: 1),
                        );
                      },
                      child: CircleAvatar(
                        maxRadius: bodyheight * 0.15,
                        backgroundImage: NetworkImage(
                            'https://priyadevani.000webhostapp.com/Apicalling/$imagepath'),
                      )),
                  accountName: Text(
                    "${nameee}",
                    style: TextStyle(
                      fontSize: bodyheight * 0.03,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  accountEmail: Text(
                    "${maillll}",
                    style: TextStyle(
                      fontSize: bodyheight * 0.03,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    setState(() {
                      Navigator.pop(context);
                      cnt = 1;
                    });
                  },
                  title: Text(
                    "Add Product",
                    style: TextStyle(
                        fontSize: bodyheight * 0.03, fontWeight: FontWeight.bold),
                  ),
                  leading: Icon(
                    Icons.add_shopping_cart,
                    size: bodyheight * 0.05,
                  ),
                  trailing: Icon(
                    Icons.arrow_right,
                    size: bodyheight * 0.07,
                  ),
                ),
                ListTile(
                  onTap: () {
                    setState(() {
                      Navigator.pop(context);
                      cnt = 0;
                    });
                  },
                  title: Text(
                    "View Product",
                    style: TextStyle(
                        fontSize: bodyheight * 0.03, fontWeight: FontWeight.bold),
                  ),
                  leading: Icon(
                    Icons.home,
                    size: bodyheight * 0.05,
                  ),
                  trailing: Icon(
                    Icons.arrow_right,
                    size: bodyheight * 0.07,
                  ),
                ),
                ListTile(
                  onTap: () {
                    setState(() {
                      Navigator.pop(context);
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return first();
                        },
                      ));
                    });
                  },
                  title: Text(
                    "Log Out",
                    style: TextStyle(
                        fontSize: bodyheight * 0.03, fontWeight: FontWeight.bold),
                  ),
                  leading: Icon(
                    Icons.lock,
                    size: bodyheight * 0.05,
                  ),
                )
              ],
            )),
        backgroundColor: Colors.pink,
        body: list[cnt]);
  }
}

class Viewdata extends StatefulWidget {
  const Viewdata({Key? key}) : super(key: key);

  @override
  State<Viewdata> createState() => _ViewdataState();
}

class _ViewdataState extends State<Viewdata> {

  bool status = false;

  // List productid = [];
  // List image1 = [];
  // List image2 = [];
  // List image3 = [];
  // List name1 = [];
  // List catogary1 = [];
  // List details1 = [];
  // List price1 = [];
  // List discountprice = [];
  // int productlength = 0;

  viewdata? vvv;

  Map mapp = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    myviewdata();

  }

  myviewdata() async {
    String userid = splash.pref!.getString("id") ?? "";

    print("objectjjjjjjjjjjjjjjj");

    mapp = {"id": userid};
    //userid getstring mathi ave

    var url = Uri.parse(
        'https://priyadevani.000webhostapp.com/Apicalling/secondview.php');
    var response = await http.post(url, body: mapp);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    developer.log('Response body: ${response.body}');

    var viewdata1 = jsonDecode(response.body);
    setState(() {
      vvv = viewdata.fromJson(viewdata1);
      status=true;
    });

    //   setState(() {
    //     productlength = vvv.productdata!.length;
    //   });
    //
    //   for (int i = 0; i < productlength; i++) {
    //     productid.add(vvv.productdata![i].id);
    //     name1.add(vvv.productdata![i].productname);
    //     details1.add(vvv.productdata![i].description);
    //     price1.add(vvv.productdata![i].price);
    //     image1.add(vvv.productdata![i].image);
    //     image2.add(vvv.productdata![i].image2);
    //     image3.add(vvv.productdata![i].image3);
    //     discountprice.add(vvv.productdata![i].discountprice);
    //     catogary1.add(vvv.productdata![i].catogary);
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    double theight = MediaQuery.of(context).size.height;
    double twidth = MediaQuery.of(context).size.width;
    double statusbarheight = MediaQuery.of(context).padding.top;
    double navibartheight = MediaQuery.of(context).padding.bottom;
    double appbarheight = kToolbarHeight;

    double bodyheight = theight - navibartheight - statusbarheight;

    return Scaffold(
      // backgroundColor: Colors.green,
      body: status
          ? WillPopScope(onWillPop: onback,
            child: SingleChildScrollView(
        child: SafeArea(
            child: Container(
              height: bodyheight,
              child: Container(
                height: bodyheight * 0.90,
                width: double.infinity,
                // decoration: BoxDecoration(border: Border.all(width: 1)),
                child: ListView.builder(
                  itemCount: vvv!.productdata!.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(
                              builder: (context) {
                                return view2(
                                  vvv!.productdata![index].image!,
                                  vvv!.productdata![index].image2!,
                                  vvv!.productdata![index].image3!,
                                  vvv!.productdata![index].productname!,
                                  vvv!.productdata![index].price!,
                                  vvv!.productdata![index].discountprice!,
                                  vvv!.productdata![index].descripation!,
                                  vvv!.productdata![index].catogary!,
                                  vvv!.productdata![index].id!,
                                  vvv!.productdata![index].userid!,
                                );
                              },
                            ));
                      },
                      child: Container(
                        height: bodyheight * 0.30,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(width: bodyheight * 0.01)),
                        child: Row(
                          children: [
                            Card(
                              child: Container(
                                height: bodyheight * 0.25,
                                width: twidth * 0.30,
                                margin: EdgeInsets.all(bodyheight * 0.01),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            'https://priyadevani.000webhostapp.com/Apicalling/${vvv!.productdata![index].image}'),
                                        fit: BoxFit.fill)),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: bodyheight * 0.25,
                                width: twidth * 0.50,
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    // Text(
                                    //   "  ${details1[index]}",
                                    //   style: TextStyle(
                                    //       fontSize: bodyheight * 0.03,
                                    //       fontWeight: FontWeight.bold),
                                    // ),
                                    Text(
                                      "  ${vvv!.productdata![index].productname}",
                                      style: TextStyle(
                                        fontSize: bodyheight * 0.03,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "  ${vvv!.productdata![index].catogary}",
                                      style: TextStyle(
                                          fontSize: bodyheight * 0.03,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "  ${vvv!.productdata![index].descripation}",
                                      style: TextStyle(
                                          fontSize: bodyheight * 0.03,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      height: bodyheight * 0.04,
                                      width: twidth * 0.70,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            "Rs.${vvv!.productdata![index].discountprice}/-",
                                            style: TextStyle(
                                                fontSize:
                                                bodyheight * 0.02,
                                                fontWeight:
                                                FontWeight.bold),
                                          ),
                                          Text(
                                            "${100 * (int.parse(vvv!.productdata![index].price.toString()) - int.parse(vvv!.productdata![index].discountprice.toString())) ~/ int.parse(vvv!.productdata![index].price.toString())}% off",
                                            style: TextStyle(
                                                fontSize:
                                                bodyheight * 0.02,
                                                fontWeight:
                                                FontWeight.bold,
                                                color: Colors.red),
                                          ),
                                          Text(
                                            "Rs.${vvv!.productdata![index].price}/-",
                                            style: TextStyle(
                                                fontSize:
                                                bodyheight * 0.02,
                                                fontWeight:
                                                FontWeight.bold,
                                                decoration: TextDecoration
                                                    .lineThrough),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
        ),
      ),
          )
          : Center(child: CircularProgressIndicator(color: Colors.black,)),

    );
  }

  TextEditingController search = TextEditingController();

  Future<bool> onback() {

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return home1();
    },));

    return Future.value(true);
  }
}
class viewdata {
  int? connection;
  int? result;
  List<Productdata>? productdata;

  viewdata({this.connection, this.result, this.productdata});

  viewdata.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    result = json['result'];
    if (json['productdata'] != null) {
      productdata = <Productdata>[];
      json['productdata'].forEach((v) {
        productdata!.add(new Productdata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    if (this.productdata != null) {
      data['productdata'] = this.productdata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Productdata {
  String? id;
  String? userid;
  String? image;
  String? image2;
  String? image3;
  String? productname;
  String? catogary;
  String? descripation;
  String? price;
  String? discountprice;

  Productdata(
      {this.id,
        this.userid,
        this.image,
        this.image2,
        this.image3,
        this.productname,
        this.catogary,
        this.descripation,
        this.price,
        this.discountprice});

  Productdata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userid = json['userid'];
    image = json['image'];
    image2 = json['image2'];
    image3 = json['image3'];
    productname = json['productname'];
    catogary = json['catogary'];
    descripation = json['descripation'];
    price = json['price'];
    discountprice = json['discountprice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userid'] = this.userid;
    data['image'] = this.image;
    data['image2'] = this.image2;
    data['image3'] = this.image3;
    data['productname'] = this.productname;
    data['catogary'] = this.catogary;
    data['descripation'] = this.descripation;
    data['price'] = this.price;
    data['discountprice'] = this.discountprice;
    return data;
  }
}






class adddata extends StatefulWidget {
  const adddata({Key? key}) : super(key: key);

  @override
  State<adddata> createState() => _adddataState();
}

class _adddataState extends State<adddata> {
  String? userid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    userid = splash.pref!.getString("id") ?? "";
    

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double theight = MediaQuery.of(context).size.height;
    double twidth = MediaQuery.of(context).size.width;
    double statusbarheight = MediaQuery.of(context).padding.top;
    double navibartheight = MediaQuery.of(context).padding.bottom;
    double appbarheight = kToolbarHeight;

    double bodyheight = theight - navibartheight - statusbarheight;
    return Scaffold(
      // backgroundColor: Colors.green,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            height: bodyheight,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/cart1.gif"),
                    fit: BoxFit.fitHeight)),
            child: Container(
              height: bodyheight,
              width: twidth,
              margin: EdgeInsets.all(bodyheight * 0.01),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(color: Colors.white12, blurRadius: bodyheight * 0.03)
              ]),
              child: Column(
                children: [
                  Container(
                    height: bodyheight * 0.32,
                    width: double.infinity,
                    // decoration: BoxDecoration(border: Border.all(width: 2)),
                    child:
                    // GridView.builder(
                    //     physics: NeverScrollableScrollPhysics(),
                    //     itemCount: imagelist.length + 1,
                    //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //       crossAxisCount: 3,
                    //     ),
                    //     itemBuilder: (BuildContext context, int index) {
                    //       if (imagelist.length == index) {
                    //         print("==================objeeee");
                    //         return Container(
                    //           height: bodyheight * 0.05,
                    //           width: twidth * 0.05,
                    //           decoration: BoxDecoration(
                    //               border:
                    //               Border.all(width: bodyheight * 0.001)),
                    //           child: Icon(
                    //             Icons.add,
                    //             size: bodyheight * 0.04,
                    //           ),
                    //         );
                    //       }
                    //       if (imagelist.length > index) {
                    //         print("fdjjjjjjj===========");
                    //         Container(
                    //           height: bodyheight * 0.05,
                    //           width: twidth * 0.10,
                    //           decoration: BoxDecoration(
                    //               border:
                    //               Border.all(width: bodyheight * 0.001)),
                    //           child: Icon(
                    //             Icons.add,
                    //             size: bodyheight * 0.04,
                    //           ),
                    //         );
                    //       }
                    //
                    //       return InkWell(
                    //         onTap: () {
                    //           print("onpreeeeeeeeeeeee");
                    //           AwesomeDialog(
                    //             context: context,
                    //             dialogType: DialogType.QUESTION,
                    //             animType: AnimType.BOTTOMSLIDE,
                    //             title: 'Do you Want to Edit Product........',
                    //             btnCancelOnPress: () {
                    //               setState(() {
                    //                 imagelist[index] = "";
                    //                 print("cancelllllllllll");
                    //               });
                    //             },
                    //             btnOkOnPress: () async {
                    //               final ImagePicker picker = ImagePicker();
                    //
                    //               final XFile? image = await picker.pickImage(
                    //                   source: ImageSource.gallery);
                    //
                    //               setState(() {
                    //                 print("blankkkkk");
                    //                 imagelist.replaceRange(
                    //                     index, index + 1, [image!.path]);
                    //                 print("============${imagelist}");
                    //               });
                    //             },
                    //           )..show();
                    //         },
                    //         child: Stack(
                    //           children: [
                    //             Container(
                    //               height: bodyheight * 0.30,
                    //               margin: EdgeInsets.all(bodyheight * 0.01),
                    //               width: twidth * 0.30,
                    //               decoration: BoxDecoration(
                    //                   image: DecorationImage(
                    //                       image:
                    //                       FileImage(File(imagelist[index])),
                    //                       fit: BoxFit.fill),
                    //                   border: Border.all(width: 1)),
                    //             ),
                    //             Positioned(
                    //               top: bodyheight * 0.001,
                    //               right: twidth * 0.01,
                    //               child: GestureDetector(
                    //                 onTap: () {
                    //                   setState(() {
                    //                     imagelist[index] = "";
                    //                     print("cancelllllllllll");
                    //                   });
                    //                 },
                    //                 child: Align(
                    //                   alignment: Alignment.topRight,
                    //                   child: CircleAvatar(
                    //                     radius: 14.0,
                    //                     backgroundColor: Colors.white,
                    //                     child: Icon(Icons.close,
                    //                         color: Colors.red),
                    //                   ),
                    //                 ),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       );
                    //     }),
                    GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: imagelist.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () async {
                              print("onpreeeeeeeeeeeee");
                              final ImagePicker picker = ImagePicker();

                              final XFile? image =
                                  await picker.pickImage(source: ImageSource.gallery);

                              setState(() {
                                print("""""""object""""""");
                                imagelist.add(image!.path);
                                print("============${imagelist}");
                              });

                            },
                            child: Container(
                              height: bodyheight * 0.30,
                              margin: EdgeInsets.all(bodyheight * 0.01),
                              width: twidth * 0.30,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                      FileImage(File(imagelist[index])),
                                      fit: BoxFit.fill),
                                  border: Border.all(width: 1)),
                            ),
                          );
                        }),
                    // ListView.builder(
                    //   scrollDirection: Axis.horizontal,
                    //   shrinkWrap: true,
                    //   itemCount:imagelist.length,
                    //   itemBuilder: (context, index) {
                    //
                    //     return InkWell(
                    //       onTap: () async {
                    //         final ImagePicker picker = ImagePicker();
                    //
                    //         final XFile? image =
                    //             await picker.pickImage(source: ImageSource.gallery);
                    //
                    //         setState(() {
                    //               imagelist[index] = image!.path;
                    //         });
                    //
                    //       },
                    //       child:imagelist[index] ==""?Container(
                    //           height: bodyheight * 0.10,
                    //           width: twidth * 0.30,
                    //           decoration: BoxDecoration(
                    //               image: DecorationImage(
                    //                   image: AssetImage("images/upload (2).gif"),
                    //                   fit: BoxFit.fitHeight)))
                    //           :Container(
                    //         height: bodyheight * 0.05,
                    //         margin: EdgeInsets.all(bodyheight*0.01),
                    //         width: twidth * 0.30,
                    //         decoration: BoxDecoration(
                    //             image: DecorationImage(
                    //                 image: FileImage(File(imagelist[index])),
                    //                 fit: BoxFit.fill),
                    //             border: Border.all(width: 1)),
                    //       ),
                    //     );
                    //
                    //   },
                    //
                    // ),
                  ),
                  InkWell(
                    onTap: () async {
                      final ImagePicker picker = ImagePicker();

                      final XFile? image =
                      await picker.pickImage(source: ImageSource.gallery);

                      setState(() {
                        print("press");
                        imagelist.add(image!.path);
                        print("============${imagelist}");
                      });
                    },
                    child: Container(
                      height: bodyheight * 0.05,
                      child: Text(
                        "Add Images",
                        style: TextStyle(
                            fontSize: bodyheight * 0.03,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    height: bodyheight * 0.10,
                    margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          namestatus = false;
                        });
                      },
                      controller: name,
                      decoration: InputDecoration(
                          prefixIconColor: Colors.black,
                          prefixIcon: Icon(
                            Icons.add_shopping_cart,
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(20))),
                          labelText: "Enter Product Name....",
                          labelStyle: TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.black, width: 2)),
                          errorText:
                          namestatus ? "Pls fill Details....." : null),
                    ),
                  ),
                  Container(
                    height: bodyheight * 0.10,
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child:
                    TextField(
                      onChanged: (value) {
                        setState(() {

                          catogarystatus=false;
                        });
                      },
                      controller: catogary,
                      decoration: InputDecoration(
                          prefixIconColor: Colors.black,
                          prefixIcon: Icon(
                            Icons.category,
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(20))),
                          labelText: "Enter Catogary....",
                          labelStyle: TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.black, width: 2)),
                          errorText:
                          catogarystatus ? "Pls fill Details....." : null),
                    ),
                  ),
                  Container(
                    height: bodyheight * 0.10,
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          detailsstatus = false;
                        });
                      },
                      controller: details,
                      maxLines: 10,
                      decoration: InputDecoration(
                          prefixIconColor: Colors.black,
                          prefixIcon: Icon(
                            Icons.description_outlined,
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(20))),
                          labelText: "Enter Description....",
                          labelStyle: TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.black, width: 2)),
                          errorText:
                          detailsstatus ? "Pls fill Details....." : null),
                    ),
                  ),
                  Container(
                    height: bodyheight * 0.10,
                    margin: EdgeInsets.fromLTRB(10, 10, bodyheight * 0.25, 0),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          pricestatus = false;
                        });
                      },
                      controller: price,
                      decoration: InputDecoration(
                          prefixIconColor: Colors.black,
                          prefixIcon: Icon(
                            Icons.attach_money_sharp,
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(20))),
                          labelText: "Price....",
                          labelStyle: TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.black, width: 2)),
                          errorText:
                          pricestatus ? "Pls fill Details....." : null),
                    ),
                  ),
                  Container(
                    height: bodyheight * 0.10,
                    margin: EdgeInsets.fromLTRB(10, 10, bodyheight * 0.25, 0),
                    child: TextField(
                      onChanged: (value) {
                          disstatus=false;

                      },
                      controller: disprice,
                      decoration: InputDecoration(
                        prefixIconColor: Colors.black,
                        errorText: disstatus?"${discountprice}":null,
                        prefixIcon: Icon(
                          Icons.attach_money_sharp,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(20))),
                        labelText: "Discount Price",
                        labelStyle: TextStyle(color: Colors.black),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.black, width: 2)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          print("1");
          String name1 = name.text;
          String catogary1 = catogary.text;
          String details1 = details.text;
          String price1 = price.text;
          discountprice = disprice.text;

          if (name1.isEmpty) {
            setState(() {
              namestatus = true;
            });
          } else if (catogary1.isEmpty) {
            setState(() {
              catogarystatus = true;
            });
          } else if (details1.isEmpty) {
            setState(() {
              detailsstatus = true;
            });
          }
          else if (discountprice.isEmpty) {
            setState(() {
              disstatus = true;
            });
          }
          else {
            print("2");
            
            //
            // if(int.parse(price1)>int.parse(discountprice))
            //   {
            //
            //         setState(() {
            //           disstatus=true;
            //           discountprice="cjjdjsdjddj";
            //         });
            //
            //   }

            for(int v=0;v<imagelist.length;v++)
              {
                print("11111111111=========${imagelist}");
                List<int> ii = File(imagelist[v]).readAsBytesSync();
                imagepath[v] = base64Encode(ii);
                print("2222=========${imagelist}");
              }

              

            print("3");
            print("1==========${imagepath[0]}");
            print("2==========${imagepath[1]}");
            print("3==========${imagepath[2]}");

            String image1 = "";
            String image2 = "";
            String image3 = "";

            image1 = imagepath[0];
            image2 = imagepath[1];
            image3 = imagepath[2];
            print("4");

            Map productmap = {
              "id": userid,
              "names": name1,
              "category": catogary1,
              "description": details1,
              "prices": price1,
              "image1": image1,
              "image2": image2,
              "image3": image3,
              "disprice": discountprice,
            
            };

            print("okk");
            var url = Uri.parse(
                'https://priyadevani.000webhostapp.com/Apicalling/secondaddproduct.php');
            var response = await http.post(url, body: productmap);
            print("virajjjjjjjjjjjj");
            print('Response status: ${response.statusCode}');
            print("mihirrrrrrrrrr");
            print('Response body: ${response.body}');
            print("printttttttttttt");


            var add=jsonDecode(response.body.toString());
               print("yesssss");
            addprodduct aa=addprodduct.fromJson(add);


            if (aa.connection == 1) // connection
                {
              if (aa.result == 1) // first time data store
                  {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Add Product Sucessfully...")));
              } else if (aa.result == 2) {
                Fluttertoast.showToast(
                    msg: "Data....",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            }
          }

          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return Viewdata();
            },
          ));
        },
        backgroundColor: Colors.white,
        icon: Icon(
          Icons.save,
          color: Colors.black,
        ),
        label: Text(
          "Save",
          style: TextStyle(
              fontSize: bodyheight * 0.03,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
    );
  }

  TextEditingController name = TextEditingController();
  TextEditingController catogary = TextEditingController();
  TextEditingController details = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController disprice = TextEditingController();

  String discountprice="";

  bool namestatus = false;
  bool catogarystatus = false;
  bool detailsstatus = false;
  bool pricestatus = false;
  bool disstatus = false;

  List<String>imagelist =[];
  List<String>imagepath = List.filled(3, "");
  int i = 0;
  String mm = "";
}

class addprodduct {
  int? connection;
  int? result;

  addprodduct({this.connection, this.result});

  addprodduct.fromJson(Map<String, dynamic> json) {
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

