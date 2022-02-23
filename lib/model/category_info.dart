class Category{

  String categoryId;
  String categoryTitle;
  String categorySubTitle;
  String categoryBanner;
  int position;
  bool isActive;


  Category({this.categoryId, this.categoryTitle, this.categorySubTitle,
    this.categoryBanner, this.position, this.isActive});

  factory Category.fromJson(Map<String, dynamic> json){
    try {
      print("--> ${json["isActive"]}");
      if( !json["isActive"] ?? false ){
        print("----> null");
        return null;
      }


      return Category(
        categoryId: json['name'] ?? "",
        categoryTitle: json['id'] ?? "",
        categorySubTitle: json['description'] ?? "",
        categoryBanner: json['price'] ?? "",
        position: json['image'] ?? 0,
        //isActive: json['isActive'] ?? true,
      );
    } catch (e) {
      print("----> ");
      print(e);
    }

    return null;


  }
  static List<Category> getListFromJson( List< dynamic > _json){
    List<Category> tList = [];
    List<Map<String, dynamic>> tt =   List<Map<String, dynamic>>.from(_json);
    print("getListFromJson>>: ${tt.length}");
    for( Map<String, dynamic> v in   tt){
      // Map<String, dynamic> member = jsonDecode(v);
      try {
        var tPro = Category.fromJson(v) ;
        print("tPro:${tPro.categoryTitle}");
        if(tPro!=null)
          tList.add(tPro);
      } catch (e) {
        print(e);
      }
    }
    return  tList ;
  }
}