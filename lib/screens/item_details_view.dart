import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_shopping/bloc/animation_bloc.dart';
import 'package:sample_shopping/bloc/animation_event.dart';
import 'package:sample_shopping/bloc/animation_state.dart';
import 'package:sample_shopping/screens/ItemsScreen.dart';
import '../constants/textconstants.dart';

class ItemDetails extends StatefulWidget {
  static const routeName = '/second';

  const ItemDetails({super.key});

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  AnimatedBloc animatedBloc = AnimatedBloc();

  @override
  void initState() {
    animatedBloc.add(InitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => animatedBloc,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              textConstants.selectedItem,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
            leading: GestureDetector(
                onTap: () {
                  // Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SingleItemView(),
                    ),
                  );
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                )),
            actions: const [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
                child: Icon(
                  Icons.favorite_border_outlined,
                  color: Colors.black,
                ),
              )
            ],
          ),
          body: BlocBuilder<AnimatedBloc, AnimatedState>(
            builder: (context, state) {
              if (state is InitialEvent) {
                return Text(textConstants.msg);
              } else {
                return Card(
                  color: Colors.white,
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        boxWithImage(
                            200, 200, Image.asset('assets/chappal.jpg')),
                        boxSize(10),
                        textData(textConstants.rateOfItem, 16, FontWeight.bold,
                            Colors.black),
                        boxSize(10),
                        textData(textConstants.itemDetail, 14,
                            FontWeight.normal, Colors.black),
                        boxWithImage(
                          50,
                          100,
                          Image.asset('assets/rating.PNG'),
                        ),
                        ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                                height: 25,
                                width: 100,
                                color: Colors.limeAccent,
                                child: Center(
                                    child: textData(textConstants.ratingRate,
                                        14, FontWeight.bold, Colors.orange)))),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.blue.shade800)),
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: textData(textConstants.buyNowButton, 14,
                                FontWeight.normal, Colors.white),
                          ),
                        ),
                        boxSize(10),
                        textData(textConstants.addToCart, 14, FontWeight.bold,
                            Colors.blue.shade800)
                        //SizedBox
                      ],
                    ),
                  ), //Column
                  //SizedBox
                  //Card
                );
              }
            },
          )),
    );
  }

  boxSize(double height) {
    return SizedBox(
      height: height,
    );
  }

  boxWithImage(double height, double width, Image image) {
    return SizedBox(height: height, width: width, child: image);
  }
}

textData(String data, double size, FontWeight weight, Color col) {
  return Text(data,
      style: TextStyle(fontSize: size, fontWeight: weight, color: col));
}
