import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import './../model/product_info.dart';

class ProductItemViewWidget extends StatelessWidget {
  final Product mProduct;
  final Function mOnClickCallbackAction;
  final int noOfItemPerRow ;

  const ProductItemViewWidget({Key key, this.mProduct, this.mOnClickCallbackAction , @required this.noOfItemPerRow}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    bool toggle= false;
    return noOfItemPerRow == 1 ? Card(

      child: Container(
        alignment: Alignment.center,
        child: ListTile(
          onTap: () => mOnClickCallbackAction(action: "Click"),
          //leading: Icon(Icons.category ),
          /*leading: Image.asset("assets/dummy_res/sample_01.jpg" ,),*/
          leading: Image.network(mProduct.image),
          title: Text(mProduct.name),
          subtitle: Text(mProduct.description , maxLines: 1, overflow: TextOverflow.ellipsis,),
          trailing:IconButton(
              icon: toggle
                  ? Icon(Icons.check)
                  : Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {

                mOnClickCallbackAction(action: "buy");
              }),/* IconButton(
            icon: const Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {
              mOnClickCallbackAction(action: "buy");
            },
            color: Colors.grey,
          ),*/
        ),
      ),
    ):

      _getGridTile(context);
  }



  Widget _getGridTile(BuildContext ctx){
    return Card(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          child: GestureDetector(
            onTap: () {
              mOnClickCallbackAction(action: "Click");
            },
            /*child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),*/
            child:Image.asset("assets/dummy_res/sample_01.jpg" ,),

          ),
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            /*leading: Consumer<Book>(
              builder: (ctx, product, _) => IconButton(
                icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border,
                ),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  product.toggleFavoriteStatus();
                },
              ),
            ),*/
            title: Text(
              mProduct.name,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                mOnClickCallbackAction(action: "buy");
              },
              color: Theme.of(ctx).primaryColor,
            ),
          ),
        ),
      ),
    );
  }

}
