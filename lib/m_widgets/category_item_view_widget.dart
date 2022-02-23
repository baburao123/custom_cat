import 'package:flutter/material.dart';

import './../model/category_info.dart';

class CategoryItemViewWidget extends StatelessWidget {
  final Category mCategory;
  final Function mOnClickCallbackAction;

  const CategoryItemViewWidget({Key key, this.mCategory, this.mOnClickCallbackAction}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: ()=> mOnClickCallbackAction(action:"Click", selectedCategory:mCategory),
      leading: Icon(Icons.category),
      title: Text(mCategory.categoryTitle),
      subtitle: Text(mCategory.categorySubTitle),
      trailing: Icon(Icons.shop),
    );
  }
}
