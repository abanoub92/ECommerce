import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/ads_provider.dart';

class CarouselImages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      child: FutureBuilder(
        future: Provider.of<AdsProvider>(context, listen: false).fetchAds(),
        builder: (ctx, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }else {
            if (snapshot.error != null) return Text(snapshot.error.toString());
            else {
              return Consumer<AdsProvider>(
                builder: (context, ads, _) => CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: false,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    autoPlayAnimationDuration: Duration(milliseconds: 1000,),
                    enlargeCenterPage: true,
                  ),
                  items: ads.items.map((image) {
                    return Image.network(image);
                  }).toList(), 
                ),
              );
            }
          }
        }
      ),
    );
  }
}

// Carousel(
//         boxFit: BoxFit.cover,
//         images: [
//           AssetImage('assets/images/c1.jpg'),
//           AssetImage('assets/images/c2.jpg'),
//           AssetImage('assets/images/m1.jpeg'),
//           AssetImage('assets/images/m2.jpg'),
//           AssetImage('assets/images/w1.jpeg'),
//           AssetImage('assets/images/w3.jpeg'),
//           AssetImage('assets/images/w4.jpeg'),
//         ],
//         autoplay: false,
//         animationCurve: Curves.fastOutSlowIn,
//         animationDuration: Duration(milliseconds: 1000,),
//         dotSize: 6,
//         dotBgColor: Colors.transparent,
//         indicatorBgPadding: 2,
//       ),
//     );