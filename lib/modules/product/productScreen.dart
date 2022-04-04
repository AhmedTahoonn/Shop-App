import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../cuibt/shaared sshop/cubit.dart';
import '../../cuibt/shaared sshop/states.dart';
import '../../models/productModel.dart';
import '../../styles/icon_broken.dart';
import '../cartScreen.dart';

class ProductScreen extends StatelessWidget {
  PageController productImages = PageController();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Shopcubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ProductDetailsData? model =
            Shopcubit.get(context).productDetailsModel?.data;
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            titleSpacing: 0,
            title: Text(
              'shopApp',
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              IconButton(onPressed: () {}, icon: Icon(IconBroken.Search)),
            ],
          ),
          body: state is productDetailsLoadingState
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Container(
                                color: Colors.white,
                                width: double.infinity,
                                child: Text(
                                  '${model!.name}',
                                  style: TextStyle(fontSize: 20),
                                )),
                            Container(
                              height: 400,
                              color: Colors.white,
                              width: double.infinity,
                              child: Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  PageView.builder(
                                    controller: productImages,
                                    itemBuilder: (context, index) => Image(
                                      image: NetworkImage(
                                          '${model.images![index]}'),
                                    ),
                                    itemCount: model.images!.length,
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      IconBroken.Heart,
                                      color: Colors.blue,
                                    ),
                                    iconSize: 35,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SmoothPageIndicator(
                              controller: productImages,
                              count: model.images!.length,
                              effect: ExpandingDotsEffect(
                                  dotColor: Colors.grey,
                                  activeDotColor: Colors.blue,
                                  expansionFactor: 4,
                                  dotHeight: 7,
                                  dotWidth: 10,
                                  spacing: 10),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'EGP '
                                          '' +
                                      '${model.price}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.italic),
                                ),
                                if (model.discount != 0)
                                  Row(
                                    children: [
                                      Text(
                                        'EGP' + '${model.oldPrice}',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            decoration:
                                                TextDecoration.lineThrough),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '${model.discount}% OFF',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ],
                                  ),
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'FREE delivery by ',
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    //  Text('${getDateTomorrow()}'),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Order in 19h 16m',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text('Offer Details',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.check_circle_outline,
                                        color: Colors.green),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('Enjoy free returns with this offer'),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.check_circle_outline,
                                        color: Colors.green),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('1 Year warranty'),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.check_circle_outline,
                                      color: Colors.green,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('Sold by ShopMart'),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text('Overview',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 15,
                                ),
                                Text('${model.description}'),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                            Container(
                              height: 40,
                              width: double.infinity,
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30, right: 30, bottom: 20),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.blueGrey
                        ),
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: MaterialButton(
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_shopping_cart_outlined,
                                  size: 25,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Add to cart',
                                  style: TextStyle(fontSize: 20,color: Colors.black),
                                ),
                              ],
                            ),
                              elevation: 0.0,
                              onPressed: () {
                                if (Shopcubit.get(context).cart[model.id]) {
                                  Fluttertoast.showToast(
                                      msg:'Already in Your Cart \nCheck your cart To Edit or Delete ',
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 5,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0
                                  );
                                } else {
                                  Shopcubit.get(context).addToCart(model.id);
                                  scaffoldKey.currentState!.showBottomSheet(
                                    (context) => Container(
                                      color: Colors.grey[300],
                                      padding: EdgeInsets.all(15),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.check_circle,
                                                color: Colors.green,
                                                size: 30,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '${model.name}',
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      'Added to Cart',
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 13),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              OutlinedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                      'CONTINUE SHOPPING')),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen(),));
                                                },
                                                child: Text('CHECKOUT'),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    elevation: 50,
                                  );
                                }

                              }),

                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
