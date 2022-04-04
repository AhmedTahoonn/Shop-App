import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/address/aad%20address.dart';
import 'package:shop_app/modules/address/update%20address.dart';

import '../../cuibt/shaared sshop/cubit.dart';
import '../../cuibt/shaared sshop/states.dart';
import '../../models/addressModel.dart';


class AddressesScreen extends StatelessWidget {

  TextEditingController cityController = TextEditingController();
  TextEditingController regionController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Shopcubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            titleSpacing: 0,
            title:Text('ShopMart',style: TextStyle(
              color: Colors.black,
            ),),

          ),
          bottomSheet: Container(
            width: double.infinity,
            height: 70,
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 10 ,horizontal: 15),
            child: MaterialButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddAddressScreen(isEdit: false,),));
              },
              color: Colors.grey,
              //shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              child: Text('ADD A NEW ADDRESS',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
            ),
          ),
          body:SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder:(context,index) => Shopcubit.get(context).getAddressModel.data!.data!.isEmpty?
                    Container():
                    addressItem(Shopcubit.get(context).getAddressModel.data!.data![index],context),
                    separatorBuilder:(context,index) => Container(
                      height: 1,
                      color: Colors.grey,
                    ),
                    itemCount: Shopcubit.get(context).getAddressModel.data!.data!.length
                ),
                Container(color: Colors.white,height: 70,width: double.infinity,)
              ],
            ),
          ),
        );
      },
    );
    // Container(
    //                   width: double.infinity,
    //                   height: 70,
    //                   color: Colors.white,
    //                   padding: EdgeInsets.symmetric(vertical: 10 ,horizontal: 15),
    //                   child: MaterialButton(
    //                     onPressed: (){},
    //                     color: Colors.deepOrange,
    //                     //shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
    //                     child: Text('Add Address',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,letterSpacing: 2),),
    //                   ),
    //                 )
  }
  Widget addressItem(AddressData model,context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Icon(Icons.location_on_outlined,color: Colors.green,),
              SizedBox(width: 5,),
              Text ('${model.name}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              Spacer(),
              TextButton(
                  onPressed: (){
                    Shopcubit.get(context).deleteAddress(addressId: model.id);
                  },
                  child: Row(children:
                  [
                    Icon(Icons.delete_outline,size: 17,),
                    Text('Delete')
                  ],)
              ),
              Container(height: 20,width: 1,color: Colors.grey[300],),
              TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateAddressScreen(isEdit: true,addressId: model.id,name: model.name,city: model.city,details: model.details,notes: model.notes,region: model.region),));

                  },
                  child: Row(children:
                  [
                    Icon(Icons.edit,size: 17,color: Colors.grey,),
                    Text('Edit',style: TextStyle(color: Colors.grey),)
                  ],)
              ),


            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Container(
                width : 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('City',style: TextStyle(fontSize: 15,color: Colors.grey),),
                    SizedBox(height: 10,),
                    Text('Region',style: TextStyle(fontSize: 15,color: Colors.grey),),
                    SizedBox(height: 10,),
                    Text('Details',style: TextStyle(fontSize: 15,color: Colors.grey),),
                    SizedBox(height: 10,),
                    Text('Notes',style: TextStyle(fontSize: 15,color: Colors.grey),),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${model.city}',style: TextStyle(fontSize: 15,)),
                  SizedBox(height: 10,),
                  Text('${model.region}',style: TextStyle(fontSize: 15,)),
                  SizedBox(height: 10,),
                  Text('${model.details}',style: TextStyle(fontSize: 15,)),
                  SizedBox(height: 10,),
                  Text('${model.notes}',style: TextStyle(fontSize: 15,)),
                  //
                ],)
            ],
          ),
        ),
      ],
    );
  }


}
