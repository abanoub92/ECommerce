import 'package:flutter/material.dart';

class HorizontalListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 8, left: 16, bottom: 8,),
          child: Text(
            'Categories',
            style: TextStyle(fontSize: 18),
          ),
        ),
        Container(
          height: 150,
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          //categories buttons
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Category(
                imageLocation: 'images/category/accessories.png',
                imageCaption: 'Accessories',
                onClickListener: () {},
              ), //accessories category button

              Category(
                imageLocation: 'images/category/dress.png',
                imageCaption: 'Dress',
                onClickListener: () {},
              ), //dress category button

              Category(
                imageLocation: 'images/category/formal.png',
                imageCaption: 'Formal',
                onClickListener: () {},
              ), //formal category button

              Category(
                imageLocation: 'images/category/informal.png',
                imageCaption: 'Informal',
                onClickListener: () {},
              ), //informal category button

              Category(
                imageLocation: 'images/category/jeans.png',
                imageCaption: 'Jeans',
                onClickListener: () {},
              ), //jeans category button

              Category(
                imageLocation: 'images/category/shoe.png',
                imageCaption: 'Shoes',
                onClickListener: () {},
              ), //shoes category button

              Category(
                imageLocation: 'images/category/tshirt.png',
                imageCaption: 'T-Shirts',
                onClickListener: () {},
              ), //tshirt category button
            ],
          ),
        ),
      ],
    );
  }
}

class Category extends StatelessWidget {
  final String imageLocation;
  final String imageCaption;
  final Function onClickListener;

  Category({this.imageLocation, this.imageCaption, this.onClickListener});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110,
      child: ListTile(
        title: Image.asset(
          imageLocation,
          height: 80,
        ),
        subtitle: Container(
            padding: EdgeInsets.only(top: 8),
            child: Text(
              imageCaption,
              style: TextStyle(color: Colors.grey, fontSize: 14),
              textAlign: TextAlign.center,
            )),
        onTap: onClickListener,
      ),
    );
  }
}
