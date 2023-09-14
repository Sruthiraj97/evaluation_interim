// ignore: file_names
// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_shopping/bloc/animation_bloc.dart';
import 'package:sample_shopping/bloc/animation_state.dart';
import 'package:sample_shopping/constants/textconstants.dart';
import 'item_details_view.dart';

class SingleItemView extends StatefulWidget {
  const SingleItemView({Key? key}) : super(key: key);

  @override
  State<SingleItemView> createState() => _SingleItemViewState();
}

class _SingleItemViewState extends State<SingleItemView>
    with TickerProviderStateMixin {
  AnimatedBloc animatedBloc = AnimatedBloc();
  late AnimationController _controller;
  bool isVisible = true;

  final List<int> stepNumbers = [1, 2, 3, 4, 5];
  final List<Color> stepColors = [
    Colors.blue,
    Colors.blue,
    Colors.blue,
    Colors.blue,
    Colors.grey,
  ];

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => animatedBloc,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: customAppBar(textConstants.cart),
        body: Column(
          children: [
            SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 22, left: 22),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(ItemDetails.routeName);
                      },
                      child: cardData(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 22, left: 10),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(ItemDetails.routeName);
                      },
                      child: cardData(),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 30, bottom: 30)),
            stepWiseStatusOrder(textConstants.status.toUpperCase()),
            entireOrderStatus(textConstants.orderPlaced, 1),
            entireOrderStatus(textConstants.payConfor, 2),
            entireOrderStatus(textConstants.processing, 3),
            entireOrderStatus(textConstants.onTheWay, 4),
            entireOrderStatus(textConstants.deliver, 5),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget customAppBar(String title) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black, // Set text color to black
        ),
      ),
      leading: const Icon(
        Icons.arrow_back_ios,
        color: Colors.black,
      ),
    );
  }

  Widget statusNumberIcon(int step) {
    final Color col = stepColors[step - 1];

    return Padding(
      padding: const EdgeInsets.only(left: 22, top: 10, right: 8),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final interval = 1.0 / stepNumbers.length;
          final animationValue =
              (step - 1) * interval + _controller.value * interval;
          final double scale = Tween<double>(begin: 0, end: 1.5)
              .animate(
                CurvedAnimation(
                  parent: _controller,
                  curve: Interval(animationValue, (step * interval)),
                ),
              )
              .value;
          return Transform.scale(
            scale: scale,
            child: child,
          );
        },
        child: buildStepCircle(step, col),
      ),
    );
  }

  Widget stepWiseStatusOrder(String orderStatus) {
    return Text(
      orderStatus,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  Widget entireOrderStatus(String orderStatus, int step) {
    return BlocBuilder<AnimatedBloc, AnimatedState>(
      builder: (context, state) {
        if (state is AnimatedIntialState) {
          if (isVisible == true) {
            return Row(
              children: [
                Column(
                  children: [
                    statusNumberIcon(step),
                    if (step < 5)
                      AnimatedBuilder(
                        animation: _controller,
                        builder: (BuildContext _, child) {
                          final interval = 1.0 / stepNumbers.length;
                          final animationValue = (step - 1) * interval +
                              _controller.value * interval;
                          double scaleY = Tween<double>(begin: 0, end: 1)
                              .animate(
                                CurvedAnimation(
                                  parent: _controller,
                                  curve: Interval(
                                      animationValue, (step * interval)),
                                ),
                              )
                              .value;
                          return buildProgressBar(child!, scaleY);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: buildProgressBarContainer(),
                        ),
                      ),
                  ],
                ),
                Column(
                  children: [stepWiseStatusOrder(orderStatus)],
                )
              ],
            );
          } else {
            return Center(
              child: Text(textConstants.msg),
            );
          }
        } else {
          return _handleInitialEventUI();
        }
      },
    );
  }

  Widget cardData() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        width: 300,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              cardText(
                  textConstants.orderNoText +
                      textConstants().orderNo.toString(),
                  15,
                  FontWeight.bold),
              Padding(
                padding: const EdgeInsets.only(right: 14),
                child: Row(
                  children: [
                    cardText(textConstants.placedDate, 12, FontWeight.normal),
                    const Spacer(),
                    const Icon(
                      Icons.more_vert,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              cardText(textConstants.paid, 15, FontWeight.bold),
              cardText(textConstants.Status, 15, FontWeight.bold),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardText(String text, double size, FontWeight weight) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Text(
        text,
        style: TextStyle(fontSize: size, fontWeight: weight),
      ),
    );
  }
}

Widget _handleInitialEventUI() {
  return Center(child: Text(textConstants.msg));
}

Widget buildProgressBar(Widget child, double scaleY) {
  return SizedBox(
    width: 20,
    height: 60,
    child: Transform.scale(
      scale: 1.0,
      child: Transform(
        alignment: Alignment.topRight, // Align to the top
        transform: Matrix4.identity()..scale(1.0, scaleY),
        child: child,
      ),
    ),
  );
}

Widget buildProgressBarContainer() {
  return Container(
    width: 3,
    height: 40,
    color: Colors.blue,
  );
}

Widget buildStepCircle(int step, Color col) {
  return Container(
    height: 20,
    width: 20,
    decoration: BoxDecoration(
      color: col,
      borderRadius: BorderRadius.circular(15),
    ),
    child: buildStepText(step),
  );
}

Widget buildStepText(int step) {
  return Center(
    child: Text(
      step.toString(),
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
