import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeCarousel extends StatefulWidget {
  const HomeCarousel({super.key});

  @override
  State<HomeCarousel> createState() => _HomeCarouselState();
}

class _HomeCarouselState extends State<HomeCarousel> {
  CarouselController carouselController = CarouselController();
  List<String> products = [];

  @override
  void initState() {
    super.initState();
    // fetchAdvertisement();
    setState(() {
      products;
    });
  }

  // Future<void> fetchAdvertisement() async {
  //   // you can replace your api link with this link
  //   for (var i = 1; i <= 3; i++) {
  //     var response =
  //         await http.get(Uri.parse('http://localhost:3000/advertisement/${i}'));
  //     if (response.statusCode == 200) {
  //       products.add(json.decode(response.body)['image']);
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CarouselSlider(
          // Set carousel controller
          carouselController: carouselController,
          items: ["assets/ad1.jpeg", "assets/ad2.jpeg", "assets/ad3.jpeg"].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Image.asset(
                      i,
                      fit: BoxFit.fill,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        // return Image.asset('assets/loading.gif');
                        return Container(
                          color: const Color(0xFFF8F8F8),
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(
                            color: Colors.pink,
                            strokeAlign: 5,
                          ),
                        );
                      },
                      
                    ));
              },
            );
          }).toList(),
          options: CarouselOptions(
            // Set the height of each carousel item
            height: 200,

            // Set the size of each carousel item
            // if height is not specified
            aspectRatio: 16 / 9,

            // Set how much space current item widget
            // will occupy from current page view
            viewportFraction: 0.8,

            // Set the initial page
            initialPage: 0,

            // Set carousel to repeat when reaching the end
            enableInfiniteScroll: true,

            // Set carousel to scroll in opposite direction
            reverse: false,

            // Set carousel to display next page automatically
            autoPlay: true,

            // Set the duration of which carousel slider will wait
            // in current page utill it moves on to the next
            autoPlayInterval: const Duration(seconds: 3),

            // Set the duration of carousel slider
            // scrolling to the next page
            autoPlayAnimationDuration: const Duration(milliseconds: 800),

            // Set the carousel slider animation
            autoPlayCurve: Curves.fastOutSlowIn,

            // Set the current page to be displayed
            // bigger than previous or next page
            enlargeCenterPage: true,

            // Do actions for each page change
            onPageChanged: (index, reason) {},

            // Set the scroll direction
            scrollDirection: Axis.horizontal,
          ),
        ),
        const SizedBox(height: 15),

        // Change page on each tap
        // ElevatedButton(
        //   onPressed: () => carouselController.nextPage(
        //       duration: const Duration(milliseconds: 300),
        //       curve: Curves.linear),
        //   child: const Icon(Icons.arrow_forward),
        // ),
      ],
    );
  }
}
