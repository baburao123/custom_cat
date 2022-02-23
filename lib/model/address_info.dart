class Address{
  String addressId;
  String addressInfo;
  String addressLabel;
  String pincode;
  String phone;
  bool isActive ;


  Address({this.addressId, this.addressInfo, this.isActive , this.addressLabel , this.pincode, this.phone});
/*  String emial;
  String phone;
  String addressName;
  int position ;*/



  factory Address.fromJson(Map<String, dynamic> json){
    try {
      print("--> ${json["isActive"]}");
      if( !json["isActive"] ){
        print("----> null");
        return null;
      }

      return Address(
        addressId: json['addressId'] ?? "",
        addressInfo: json['addressInfo'] ?? "",
        addressLabel: json['addressLabel'] ?? "",
        pincode: json['pincode'] ?? "",
        phone: json['phone'] ?? "",
        isActive: json['isActive'] ?? true,
      );
    } catch (e) {
      print("----> ");
      print(e);
    }

    return null;


  }

  static List<Address> getListFromJson( List< dynamic > _json){
    List<Address> tList = [];
    List<Map<String, dynamic>> tt =   List<Map<String, dynamic>>.from(_json);
    print("getListFromJson>>: ${tt.length}");
    for( Map<String, dynamic> v in   tt){
      // Map<String, dynamic> member = jsonDecode(v);
      try {
        var tPro = Address.fromJson(v) ;
       // print("tPro:${tPro.proTitle}");
        if(tPro!=null)
          tList.add(tPro);
      } catch (e) {
        print(e);
      }
    }
    return  tList ;
  }
}