import 'package:flutter/material.dart';
import 'package:shop_app/network/local/cachHelper.dart';
import 'package:shop_app/modules/login/shop_login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class BoardingModel
{
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body
});
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding=[
    BoardingModel(
        image: 'assets/images/OnlineShop.png',
        body: 'Choose Whatever the Product you wish for with the easiest way possible using ShopMart',
        title: 'Explore'),
    BoardingModel(
        image: 'assets/images/Delivery.png',
        body: 'Yor Order will be shipped to you as fast as possible by our carrier',
        title: 'Shipping'),
    BoardingModel(
        image: 'assets/images/Payment.png',
        body: 'Pay with the safest way possible either by cash or credit cards',
        title: 'Make the Payment'),

  ];

  var boardcontrooler=PageController();
  bool islast=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.4),
        elevation: 0.0,
        actions: [
          TextButton(onPressed: (){
            CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
              if(value==true){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LogIn(),), (route) => false);

              }
            });
          }, child: Text('SKIP',style: TextStyle(
            color: Colors.blueGrey
          ),))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 15,bottom: 15),
        child: Column(
          children:
          [
            Expanded(
              child: PageView.builder(itemBuilder: (context, index) => buildBoardingItem(boarding[index]),
              itemCount: 3,
                controller: boardcontrooler,
                onPageChanged: (int index){
                if(index==boarding.length-1)
                  {
                    setState(() {
                      islast=true;
                    });
                  }
                else
                  {
                    setState(() {
                      islast=false;
                    });

                  }
                },
                physics: BouncingScrollPhysics(),

              ),
            ),
            Row(
              children:
              [
                SmoothPageIndicator(
                    controller: boardcontrooler,
                    count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                     activeDotColor: Colors.blueGrey,
                     dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5,
                  ),
                ),
                Spacer(),
                FloatingActionButton(onPressed: ()
                {

                  if(islast){
                    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
                      if(value==true){
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LogIn(),), (route) => false);

                      }
                    });
                  }else
                    {
                      boardcontrooler.nextPage(duration: Duration(
                        microseconds: 1000,
                      ), curve: Curves.fastLinearToSlowEaseIn);

                    }

                },
                  child: Icon(Icons.arrow_forward_ios_sharp,color: Colors.white,),backgroundColor: Colors.blueGrey,)

              ],
            ),
          ],
        ),
      ),
    );
  }
}
Widget buildBoardingItem(BoardingModel model)=>Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children:
  [
    Expanded(child: Image(image: AssetImage('${model.image}'),)),
    SizedBox(
      height: 30,
    ),
    Text('${model.title}',
      style: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
    ),
    SizedBox(
      height: 15.0,
    ),
    Text('${model.body}',
      style: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
      ),
    ),
    SizedBox(
      height: 30.0,
    ),



  ],
);
