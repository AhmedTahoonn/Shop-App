class LoginModel
{
   bool ?status;
   String? message;
   LoginUserData ?data;
   LoginModel.fromJ4son(Map<String,dynamic>json)
   {
     status=json['status'];
     message=json['message'];
     data=json['data']!=null?LoginUserData.fromJ4son(json['data']):null;


   }
}

class LoginUserData
{

  int ?id;
  String?name;
  String ?email;
  String ?phone;
  String ?image;
  int ?points;
  int ?credit;
  String ?token;

  //LoginUserData({


    //this.id,
     //this.name,
     //this.email,
    //this.phone,
     //this.image,
     //this.points,
    //this.credit,
     //this.token,
//});
  LoginUserData.fromJ4son(Map<String,dynamic>json)
  {
    id=json['id'];
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    image=json['image'];
    points=json['points'];
    credit=json['credit'];
    token=json['token'];


  }
}