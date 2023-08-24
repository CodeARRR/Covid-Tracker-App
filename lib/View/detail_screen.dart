import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String? name;
  String? image;
  int? totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      test;
  DetailScreen(
      {required this.name,
      required this.image,
      required this.totalCases,
      required this.todayRecovered,
      required this.active,
      required this.totalDeaths,
      required this.test,
      required this.totalRecovered,
      required this.critical});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(widget.name.toString()),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .067),
                  child: Card(
                    child: Column(children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .067,
                      ),
                      ReuseAbleScreen(
                          value: widget.active.toString(),
                          title: 'active cases'),
                      ReuseAbleScreen(
                          value: widget.totalCases.toString(),
                          title: 'total cases'),
                      ReuseAbleScreen(
                          value: widget.totalDeaths.toString(),
                          title: 'total deaths'),
                      ReuseAbleScreen(
                          value: widget.totalRecovered.toString(),
                          title: 'total recovered'),
                      ReuseAbleScreen(
                          value: widget.test.toString(), title: 'test'),
                      ReuseAbleScreen(
                          value: widget.todayRecovered.toString(),
                          title: 'today recovered'),
                      ReuseAbleScreen(
                          value: widget.todayRecovered.toString(),
                          title: 'today deaths'),
                      ReuseAbleScreen(
                          value: widget.active.toString(),
                          title: 'active cases'),
                    ]),
                  ),
                ),
                CircleAvatar(
                  radius: 58,
                  backgroundImage: NetworkImage(widget.image.toString()),
                )
              ],
            )
          ],
        ));
  }
}

class ReuseAbleScreen extends StatelessWidget {
  final String title, value;
  const ReuseAbleScreen({Key? key, required this.value, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
