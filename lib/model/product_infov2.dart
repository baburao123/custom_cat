class Product{
  int id;
  String name;
  String description;
  double proPrice = 0.0;
  String proStrPrice;
  String  image = "";


  Product(
      {
        this.id,
        this.name,
        this.description,
        this.proPrice,
        this.proStrPrice,
        this.image,
      });


  factory Product.fromJson(Map<String, dynamic> json){
    try {



      return Product(
        id: json['id'] ?? 0,
        name: json['name'] ?? "",
        description: json['description'] ?? "",
        proPrice: 0.0,

        proStrPrice: json['proStrPrice'] ?? "0.0",
        image: json['image'] ?? "",

      );
    } catch (e) {
      print("----> ");
      print(e);
    }

    return null;


  }


  static List<Product> getListFromJson( List< dynamic > _json){
    List<Product> tList = [];
    List<Map<String, dynamic>> tt =   List<Map<String, dynamic>>.from(_json);
    print("getListFromJson>>: ${tt.length}");
    for( Map<String, dynamic> v in   tt){
      // Map<String, dynamic> member = jsonDecode(v);
      try {
        var tPro = Product.fromJson(v) ;
        //  print("tPro:${tPro.proTitle}");
        if(tPro!=null)
          tList.add(tPro);
      } catch (e) {
        print(e);
      }
    }
    return  tList ;
  }

}