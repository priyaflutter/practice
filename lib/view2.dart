
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:practice/edit.dart';
import 'package:practice/home.dart';
import 'package:practice/splash.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';


class view2 extends StatefulWidget {
  String image;
  String image2;
  String image3;
  String productname;
  String price;
  String discountprice;
  String description;
  String catogary;
  String id;
  String userid;

  view2(
      this.image,
      this.image2,
      this.image3,
      this.productname,
      this.price,
      this.discountprice,
      this.description,
      this.catogary,
      this.id,
      this.userid);

  // view2(this.image1, this.image2, this.image3, this.name1, this.details1,
  //     this.price1, this.discountprice, this.catogary1,this.productid);

  @override
  State<view2> createState() => _view2State();
}

class _view2State extends State<view2> {
  String? userid;
  List newimagelist = ["", "", ""];



  int currentimage = 0;

  late Razorpay _razorpay;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userid = splash.pref!.getString('id') ?? "";
    setState(() {});
    newimagelist = [widget.image, widget.image2, widget.image3,];


    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

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
                margin: EdgeInsets.fromLTRB(
                    bodyheight * 0.01, 0, bodyheight * 0.01, bodyheight * 0.01),
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(color: Colors.white12, blurRadius: bodyheight * 0.03)
                ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: bodyheight * 0.38,
                      width: double.infinity,
                      // decoration: BoxDecoration(border: Border.all(width: 2)),
                      child: Column(
                        children: [
                          CarouselSlider.builder(
                              itemCount: newimagelist.length,
                              itemBuilder: (context, index, realIndex) {
                                return InkWell(
                                    onTap: () {
                                      print("onpreeeeeeeeeeeee");
                                      showAnimatedDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (BuildContext context) {
                                          return InteractiveViewer(
                                            child: AlertDialog(
                                              actions: [
                                                Center(
                                                  child: Container(
                                                    height: bodyheight * 0.30,
                                                    margin: EdgeInsets.all(
                                                        bodyheight * 0.01),
                                                    width: twidth * 0.55,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                'https://priyadevani.000webhostapp.com/Apicalling/${newimagelist[index]}'),
                                                            fit: BoxFit.cover),
                                                        border: Border.all(
                                                            width: 1)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        animationType: DialogTransitionType
                                            .slideFromBottomFade,
                                        curve: Curves.fastOutSlowIn,
                                        duration: Duration(seconds: 1),
                                      );
                                    },
                                    child: Container(
                                      height: bodyheight * 0.35,
                                      margin: EdgeInsets.all(bodyheight * 0.01),
                                      width: twidth * 0.55,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  'https://priyadevani.000webhostapp.com/Apicalling/${newimagelist[index]}'),
                                              fit: BoxFit.cover),
                                          border: Border.all(width: 1)),
                                    ));
                              },
                              options: CarouselOptions(
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    currentimage = index;
                                  });
                                },
                                scrollDirection: Axis.horizontal,
                                autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
                                aspectRatio: 16 / 9,
                                autoPlay: true,
                                height: bodyheight * 0.33,
                                enlargeCenterPage: true,
                              )),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: newimagelist.map((e) {
                                int index = newimagelist.indexOf(e);
                                return Container(
                                  width: 8.0,
                                  height: bodyheight * 0.01,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 2.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: currentimage == index
                                        ? Color.fromRGBO(0, 0, 0, 0.9)
                                        : Color.fromRGBO(0, 0, 0, 0.2),
                                  ),
                                );
                              }).toList()),
                        ],
                      ),

                      // GridView.builder(
                      //     physics: NeverScrollableScrollPhysics(),
                      //     itemCount: imagelist.length,
                      //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      //       crossAxisCount: 3,
                      //     ),
                      //     itemBuilder: (BuildContext context, int index) {
                      //       return Container(
                      //         height: bodyheight * 0.30,
                      //         margin: EdgeInsets.all(bodyheight * 0.01),
                      //         width: twidth * 0.30,
                      //         decoration: BoxDecoration(
                      //             image: DecorationImage(
                      //                 image: NetworkImage(
                      //                     'https://priyadevani.000webhostapp.com/Apicalling/${newimagelist[index]}'),
                      //                 fit: BoxFit.fill),
                      //             border: Border.all(width: 1)),
                      //       );
                      //     }),
                    ),
                    Container(
                      height: bodyheight * 0.08,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(width: bodyheight * 0.001),
                          borderRadius: BorderRadius.all(
                              Radius.circular(bodyheight * 0.02))),
                      child: ListTile(
                        title: Text(
                          "${widget.productname}",
                          style: TextStyle(
                              fontSize: bodyheight * 0.02,
                              fontWeight: FontWeight.bold),
                        ),
                        leading: Icon(
                          Icons.add_shopping_cart,
                          size: bodyheight * 0.03,
                        ),
                      ),
                    ),
                    Container(
                      height: bodyheight * 0.08,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(width: bodyheight * 0.001),
                          borderRadius: BorderRadius.all(
                              Radius.circular(bodyheight * 0.02))),
                      child: ListTile(
                        title: Text(
                          "${widget.catogary}",
                          style: TextStyle(
                              fontSize: bodyheight * 0.02,
                              fontWeight: FontWeight.bold),
                        ),
                        leading: Icon(
                          Icons.category,
                          size: bodyheight * 0.03,
                        ),
                      ),
                    ),
                    Container(
                      height: bodyheight * 0.08,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(width: bodyheight * 0.001),
                          borderRadius: BorderRadius.all(
                              Radius.circular(bodyheight * 0.02))),
                      child: ListTile(
                        title: Text(
                          "${widget.description}",
                          style: TextStyle(
                              fontSize: bodyheight * 0.02,
                              fontWeight: FontWeight.bold),
                        ),
                        leading: Icon(
                          Icons.description_outlined,
                          size: bodyheight * 0.03,
                        ),
                      ),
                    ),
                    Container(
                      height: bodyheight * 0.08,
                      width: twidth * 0.50,
                      margin: EdgeInsets.fromLTRB(0, 0, bodyheight * 0.25, 0),
                      decoration: BoxDecoration(
                          border: Border.all(width: bodyheight * 0.001),
                          borderRadius: BorderRadius.all(
                              Radius.circular(bodyheight * 0.02))),
                      child: ListTile(
                        title: Text(
                          "रु ${widget.price}/-",
                          style: TextStyle(
                              fontSize: bodyheight * 0.02,
                              fontWeight: FontWeight.bold),
                        ),
                        leading: Icon(
                          Icons.attach_money_sharp,
                          size: bodyheight * 0.03,
                        ),
                      ),
                    ),
                    Container(
                      height: bodyheight * 0.08,
                      width: twidth * 0.50,
                      margin: EdgeInsets.fromLTRB(0, 0, bodyheight * 0.25, 0),
                      decoration: BoxDecoration(
                          border: Border.all(width: bodyheight * 0.001),
                          borderRadius: BorderRadius.all(
                              Radius.circular(bodyheight * 0.02))),
                      child: ListTile(
                        title: Text(
                          "रु ${widget.discountprice}/-",
                          style: TextStyle(
                              fontSize: bodyheight * 0.02,
                              fontWeight: FontWeight.bold),
                        ),
                        leading: Icon(
                          Icons.attach_money_sharp,
                          size: bodyheight * 0.03,
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
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed:openCheckout ,
            backgroundColor: Colors.white,
            icon: Icon(
              Icons.shopping_bag_outlined,
              color: Colors.black,
            ),
            label: Text(
              "Buy Now",
              style: TextStyle(
                  fontSize: bodyheight * 0.03,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          SizedBox(
            height: bodyheight * 0.02,
          ),
          FloatingActionButton.extended(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return edit(
                      widget.image,
                      widget.image2,
                      widget.image3,
                      widget.productname,
                      widget.description,
                      widget.price,
                      widget.discountprice,
                      widget.catogary,
                      widget.id);
                },
              ));
            },
            backgroundColor: Colors.white,
            icon: Icon(
              Icons.edit_sharp,
              color: Colors.black,
            ),
            label: Text(
              "Edit",
              style: TextStyle(
                  fontSize: bodyheight * 0.03,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          SizedBox(
            height: bodyheight * 0.02,
          ),
          FloatingActionButton.extended(
            onPressed: () async {
              print("deleteeeeeeeeeeeeeeeeeee");

              var url = Uri.parse(
                  'https://priyadevani.000webhostapp.com/Apicalling/seconddelete.php');

              print("cantttttttttttt");
              var response = await http.post(url, body: {"id": widget.id});

              print('Response status: ${response.statusCode}');
              print('Response body: ${response.body}');

              Fluttertoast.showToast(
                  msg: "Record Delete Sucessfully",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  fontSize: bodyheight * 0.02);

              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return Viewdata();
                },
              ));
            },
            backgroundColor: Colors.white,
            icon: Icon(
              Icons.delete_forever,
              color: Colors.black,
            ),
            label: Text(
              "Delete",
              style: TextStyle(
                  fontSize: bodyheight * 0.03,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          )
        ],
      ),
    );
  }

  List imagelist = ["", "", "",];
  List imagepath = List.filled(3, "");
  int i = 0;

  //payment


  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_Kg84my9pEQ1MGW',
      'amount':100*int.parse(widget.discountprice),
      'name': widget.productname,
      // 'description': 'Fine T-Shirt',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '9586877460', 'email': 'priyadevani25@gmail.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print('Success Response: $response');
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Error Response: $response');
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External SDK Response: $response');
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT);
  }


  Future<bool> onback() {

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return home1();
    },));

        return Future.value(true);
  }
}
