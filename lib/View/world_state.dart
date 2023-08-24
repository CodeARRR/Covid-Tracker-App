import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mycovidtracker/Model/world_state_model.dart';
import 'package:mycovidtracker/Services/state_services.dart';
import 'package:mycovidtracker/View/track_countires.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldState extends StatefulWidget {
  const WorldState({Key? key}) : super(key: key);

  @override
  State<WorldState> createState() => _WorldStateState();
}

class _WorldStateState extends State<WorldState> with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final colorlist = <Color>[
    const Color(0xff4285f4),
    const Color(0xff1aa260),
    const Color(0xffde5246)
  ];

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              FutureBuilder(
                  future: statesServices.fetchWorldStatesRecords(),
                  builder:
                      (context, AsyncSnapshot<WorldStateesModel> snipshot) {
                    if (!snipshot.hasData) {
                      return SpinKitFadingCircle(
                        color: Colors.white,
                        controller: _controller,
                        size: 50,
                      );
                    } else {
                      return Column(
                        children: [
                          PieChart(
                            dataMap: {
                              "Cases":
                                  double.parse(snipshot.data!.cases.toString()),
                              "Recovered": double.parse(
                                  snipshot.data!.recovered.toString()),
                              "Deaths":
                                  double.parse(snipshot.data!.deaths.toString())
                            },
                            chartValuesOptions: const ChartValuesOptions(
                                showChartValuesInPercentage: true),
                            animationDuration: Duration(milliseconds: 1200),
                            chartType: ChartType.ring,
                            colorList: colorlist,
                            legendOptions: const LegendOptions(
                                legendPosition: LegendPosition.left),
                          ),
                          Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Card(
                              child: Column(children: [
                                ReuseAble(
                                    value: snipshot.data!.deaths.toString(),
                                    title: 'Deaths'),
                                ReuseAble(
                                    value: snipshot.data!.cases.toString(),
                                    title: 'Cases'),
                                ReuseAble(
                                    value: snipshot.data!.population.toString(),
                                    title: 'Population'),
                                ReuseAble(
                                    value: snipshot.data!.recovered.toString(),
                                    title: 'Recovered'),
                                ReuseAble(
                                    value: snipshot.data!.active.toString(),
                                    title: 'Active'),
                                ReuseAble(
                                    value:
                                        snipshot.data!.todayDeaths.toString(),
                                    title: 'Today Deaths'),
                              ]),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TrackCountries())),
                            child: Container(
                              height: 50,
                              child:
                                  const Center(child: Text('Track Countries')),
                              decoration: BoxDecoration(
                                color: Color(0xff1aa260),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          )
                        ],
                      );
                    }
                  }),
            ]),
          ),
        ),
      ),
    );
  }
}

class ReuseAble extends StatelessWidget {
  final String title, value;
  const ReuseAble({Key? key, required this.value, required this.title})
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
