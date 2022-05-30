import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:practice/home.dart';
import 'package:practice/splash.dart';

class edit extends StatefulWidget {
  String image1;
  String image2;
  String image3;
  String name1;
  String details1;
  String price1;
  String discountprice;
  String catogary1;
  String productid;

  edit(this.image1, this.image2, this.image3, this.name1, this.details1,
      this.price1, this.discountprice, this.catogary1, this.productid);

  @override
  State<edit> createState() => _editState();
}

class _editState extends State<edit> {
  String? userid;

  ImagePicker picker = ImagePicker();
  TextEditingController name = TextEditingController();
  TextEditingController catogary = TextEditingController();
  TextEditingController details = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController disprice = TextEditingController();

  bool namestatus = false;
  bool catogarystatus = false;
  bool detailsstatus = false;
  bool pricestatus = false;

  List<String>imagelist =[];
  List fileimage = List.filled(3, "");
  List<String>imagepath = List.filled(3, "");
  int length = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    userid = splash.pref!.getString('id') ?? "";

    setState(() {});
    print("imageeeeeeeeeeeeeeeeeee");
    String name1 = widget.name1;
    name.text = name1;
    String price1 = widget.price1;
    price.text = price1;
    String details1 = widget.details1;
    details.text = details1;
    String disprice1 = widget.discountprice;
    disprice.text = disprice1;
    String catogary11 = widget.catogary1;
    catogary.text = catogary11;


    imagepath[0] = widget.image1;
    imagepath[1] = widget.image2;
    imagepath[2] = widget.image3;

    for(int i=0;i<3;i++){
                if(imagepath[i]!=""){
                  imagelist.add(imagepath[i]);
                }
    }

    setState(() {
      length = imagelist.length;
    });


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
      body: WillPopScope(onWillPop: onback,
        child: SingleChildScrollView(
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
                      height: bodyheight * 0.30,
                      width: double.infinity,
                      // decoration: BoxDecoration(border: Border.all(width: 2)),
                      child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 3,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                          ),
                          itemBuilder: (BuildContext context, index) {
                            if(index < length){
                              print("hddddddddddddd");
                              return InkWell(onTap: () {
                                print("object");
                                showAnimatedDialog(builder: (context) {

                                    return AlertDialog(backgroundColor: Colors.white30,
                                      actions: [Container(
                                        height: bodyheight * 0.10,
                                        width: twidth,
                                        margin: EdgeInsets.all(
                                            bodyheight * 0.01),
                                        decoration: BoxDecoration(),
                                        child: Center(
                                          child: Text(
                                            "Are you sure want to Delete..",
                                            style: TextStyle(
                                                fontSize: bodyheight * 0.03,
                                                color: Colors.black,
                                                fontWeight:
                                                FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                        InkWell(
                                          onTap: () {
                                              Navigator.pop(context);
                                              setState(() {
                                                imagelist.removeAt(index);
                                                length=length-1;
                                              });

                                          },
                                          child: Card(
                                            child: Container(
                                              height: bodyheight * 0.10,
                                              margin: EdgeInsets.all(
                                                  bodyheight * 0.01),
                                              width: twidth,
                                              decoration: BoxDecoration(
                                                  color: Color(0xffd5baba),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      bodyheight * 0.01)),
                                              // decoration: BoxDecoration(color: Colors.yellow),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceEvenly,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Icon(
                                                      Icons.delete_forever,
                                                      size: bodyheight * 0.04,
                                                    ),
                                                  ),
                                                  Text(
                                                    " Delete      ",
                                                    style: TextStyle(
                                                        fontSize:
                                                        bodyheight * 0.03,
                                                        fontWeight:
                                                        FontWeight.w900),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),],
                                    );
                                },context: context,);
                              },
                                child: Container(
                                  height: bodyheight * 0.25,
                                  margin: EdgeInsets.all(bodyheight * 0.01),
                                  width: twidth * 0.55,
                                  decoration: BoxDecoration(
                                    // color: Color(0xff8892de),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              'https://priyadevani.000webhostapp.com/Apicalling/${imagelist[index]}'),
                                          fit: BoxFit.cover),
                                      border: Border.all(width: 1)),
                                ),
                              );
                            }else{
                              return InkWell(onTap: () {
                                showAnimatedDialog(builder: (context) {

                                  return AlertDialog(backgroundColor: Colors.white30,
                                    actions: [Container(
                                      height: bodyheight * 0.10,
                                      width: twidth,
                                      margin: EdgeInsets.all(
                                          bodyheight * 0.01),
                                      decoration: BoxDecoration(),
                                      child: Center(
                                        child: Text(
                                          "Are you sure want to Delete..",
                                          style: TextStyle(
                                              fontSize: bodyheight * 0.03,
                                              color: Colors.black,
                                              fontWeight:
                                              FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                      InkWell(
                                        onTap: () async {
                                           Navigator.pop(context);
                                          print("edtitttt");
                                          ImagePicker picker = ImagePicker();
                                          XFile? image1 = await picker.pickImage(
                                              source: ImageSource.gallery);

                                          setState(() {
                                            fileimage[index]=(image1!.path);
                                          });
                                        },
                                        child: Card(
                                          child: Container(
                                            height: bodyheight * 0.10,
                                            margin: EdgeInsets.all(
                                                bodyheight * 0.01),
                                            width: twidth,
                                            decoration: BoxDecoration(
                                                color: Color(0xffd5baba),
                                                borderRadius:
                                                BorderRadius.circular(
                                                    bodyheight * 0.01)),
                                            // decoration: BoxDecoration(color: Colors.yellow),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceEvenly,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Icon(
                                                    Icons.edit,
                                                    size: bodyheight * 0.04,
                                                  ),
                                                ),
                                                Text(
                                                  " Edit      ",
                                                  style: TextStyle(
                                                      fontSize:
                                                      bodyheight * 0.03,
                                                      fontWeight:
                                                      FontWeight.w900),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {

                                          Navigator.pop(context);

                                            setState(() {
                                              imagelist.removeAt(index);
                                              length=length-1;
                                            });

                                        },
                                        child: Card(
                                          child: Container(
                                            height: bodyheight * 0.10,
                                            margin: EdgeInsets.all(
                                                bodyheight * 0.01),
                                            width: twidth,
                                            decoration: BoxDecoration(
                                                color: Color(0xffd5baba),
                                                borderRadius:
                                                BorderRadius.circular(
                                                    bodyheight * 0.01)),
                                            // decoration: BoxDecoration(color: Colors.yellow),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceEvenly,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Icon(
                                                    Icons.delete_forever,
                                                    size: bodyheight * 0.04,
                                                  ),
                                                ),
                                                Text(
                                                  " Delete      ",
                                                  style: TextStyle(
                                                      fontSize:
                                                      bodyheight * 0.03,
                                                      fontWeight:
                                                      FontWeight.w900),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),],
                                  );
                                },context: context,);

                              },
                                child: Container(
                                  height: bodyheight * 0.25,
                                  width: twidth * 0.55,
                                  margin: EdgeInsets.all(bodyheight * 0.01),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: FileImage(
                                              File("${fileimage[index]}")
                                          ) ,fit: BoxFit.cover
                                      )
                                  ),
                                ),
                              );
                            }

                          }),

                      // CarouselSlider.builder(
                      //     itemCount: imagelist.length-1,
                      //     itemBuilder: (context, index, realIndex) {
                      //
                      //       return InkWell(
                      //           onTap: () async {
                      //             print("presssssssssssssss");
                      //
                      //             ImagePicker picker = ImagePicker();
                      //             XFile? image1 =
                      //                 await picker.pickImage(source: ImageSource.gallery);
                      //             setState(() {
                      //
                      //               if(newimagelist !="")
                      //                 {
                      //                   imagelist.removeAt(index);
                      //                   print("removeeeeee");
                      //                   imagelist.add(index);
                      //                   // String imagepath = image!.path;
                      //                   print("newimageeeeeeee");
                      //                   priya=newimagelist[index].toString();
                      //                   priya= image1!.path;
                      //                   print("${priya}");
                      //                   print("doneeeeeeee");
                      //                   setState(() {
                      //
                      //                   });
                      //                 }
                      //
                      //
                      //             });
                      //
                      //           },
                      //           child:Container( height: bodyheight * 0.25,
                      //             width: twidth * 0.60,
                      //             decoration: BoxDecoration(color: Colors.grey,
                      //                 image: DecorationImage(image: FileImage(File("${newimagelist[index]}")))),
                      //             child: Container(
                      //               height: bodyheight * 0.25,
                      //               margin: EdgeInsets.all(bodyheight * 0.01),
                      //               width: twidth * 0.55,
                      //               decoration:BoxDecoration(
                      //                   image: DecorationImage(
                      //                       image: NetworkImage(
                      //                           'https://priyadevani.000webhostapp.com/Apicalling/${imagelist[index]}'),
                      //                       fit: BoxFit.cover),
                      //                   border: Border.all(width: 1)),
                      //             ),
                      //           ));
                      //
                      // },
                      //     options:CarouselOptions(
                      //         scrollDirection: Axis.horizontal,
                      //       // autoPlayAnimationDuration: Duration(milliseconds: 800),
                      //       aspectRatio: 16 / 9,
                      //       // autoPlay: true,
                      //       height: bodyheight*0.33,
                      //       enlargeCenterPage: true,
                      //     ) ),
                    ),

                    Container(
                      height: bodyheight * 0.10,
                      margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {});
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
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            catogarystatus = false;
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
                        onChanged: (value) {},
                        controller: disprice,
                        decoration: InputDecoration(
                          prefixIconColor: Colors.black,
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
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {


          print("===========================${imagelist}");
          String name1 = name.text;
          String catogary1 = catogary.text;
          String details1 = details.text;
          String price1 = price.text;
          String discountprice = disprice.text;

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
          } else if (price1.isEmpty) {
            setState(() {
              pricestatus = true;
            });
          } else {
            print("2");

            for(int v=0;v<3;v++){
              if(fileimage[v]!=""){
                List<int> ii = File(fileimage[v]).readAsBytesSync();
                imagelist.add(base64Encode(ii));
              }
            }


            String newimage0 = "";
            String newimage1 = "";
            String newimage2 = "";

            newimage0 = imagelist[0];
            newimage1 = imagelist[1];
            newimage2 = imagelist[2];

            print("4");

            Map productmap = {
              "id": widget.productid,
              "names": name1,
              "category": catogary1,
              "description": details1,
              "prices": price1,
              "disprice": discountprice,
              "imagedata1": newimage0,
              "imagedata2": newimage1,
              "imagedata3": newimage2,
              "length": length.toString()
            };

            print("okk");
            var url = Uri.parse(
                'https://priyadevani.000webhostapp.com/Apicalling/secondupdate.php');
            var response = await http.post(url, body: productmap);
            print("virajjjjjjjjjjjj");
            print('Response status: ${response.statusCode}');
            print("mihirrrrrrrrrr");
            print('Response body: ${response.body}');

            var add = jsonDecode(response.body);

            updatedata aa = updatedata.fromJson(add);

            if (aa.connection == 1) // connection
                {
              if (aa.result == 1) // first time data store
                  {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Update Product Sucessfully...")));
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



  Future<bool> onback() {

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return home1();
    },));

    return Future.value(true);
  }
}

class updatedata {
  int? connection;
  int? result;
  List<Productdata>? productdata;

  updatedata({this.connection, this.result, this.productdata});

  updatedata.fromJson(Map<String, dynamic> json) {
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

