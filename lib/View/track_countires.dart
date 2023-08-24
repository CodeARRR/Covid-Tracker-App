import 'package:flutter/material.dart';

import 'package:mycovidtracker/Services/state_services.dart';
import 'package:mycovidtracker/View/detail_screen.dart';
import 'package:shimmer/shimmer.dart';

class TrackCountries extends StatefulWidget {
  @override
  State<TrackCountries> createState() => _TrackCountriesState();
}

class _TrackCountriesState extends State<TrackCountries> {
  TextEditingController searchController = TextEditingController();

  StatesServices statesServices = StatesServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextFormField(
            controller: searchController,
            decoration: InputDecoration(
                hintText: 'search countries',
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50))),
            onChanged: ((value) {
              setState(() {});
            }),
          ),
        ),
        Expanded(
            child: FutureBuilder(
          future: statesServices.countriesListApi(),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (!snapshot.hasData) {
              return ListView.builder(
                  itemCount: 4,
                  itemBuilder: ((context, index) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey.shade700,
                      highlightColor: Colors.grey.shade100,
                      child: Column(
                        children: [
                          ListTile(
                              title: Container(
                                height: 10,
                                width: 89,
                                color: Colors.white,
                              ),
                              subtitle: Container(
                                height: 10,
                                width: 89,
                                color: Colors.white,
                              ),
                              leading: Container(
                                height: 10,
                                width: 50,
                                color: Colors.white,
                              ))
                        ],
                      ),
                    );
                  }));
            } else {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: ((context, index) {
                    String name = snapshot.data![index]['country'];
                    if (searchController.text.isEmpty) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailScreen(
                                            name: snapshot.data![index]
                                                ['country'],
                                            image: snapshot.data![index]
                                                ['countryInfo']['flag'],
                                            active: snapshot.data![index]
                                                ['active'],
                                            critical: snapshot.data![index]
                                                ['critical'],
                                            todayRecovered: snapshot
                                                .data![index]['todayRecovered'],
                                            totalCases: snapshot.data![index]
                                                ['cases'],
                                            test: snapshot.data![index]
                                                ['tests'],
                                            totalDeaths: snapshot.data![index]
                                                ['deaths'],
                                            totalRecovered: snapshot
                                                .data![index]['recovered'],
                                          )));
                            },
                            child: ListTile(
                              title: Text(snapshot.data![index]['country']),
                              subtitle: Text(
                                  snapshot.data![index]['cases'].toString()),
                              leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage(snapshot.data![index]
                                      ['countryInfo']['flag'])),
                            ),
                          )
                        ],
                      );
                    } else if (name
                        .toLowerCase()
                        .contains(searchController.text.toLowerCase())) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailScreen(
                                            name: snapshot.data![index]
                                                ['country'],
                                            image: snapshot.data![index]
                                                ['countryInfo']['flag'],
                                            active: snapshot.data![index]
                                                ['active'],
                                            critical: snapshot.data![index]
                                                ['critical'],
                                            todayRecovered: snapshot
                                                .data![index]['todayRecovered'],
                                            totalCases: snapshot.data![index]
                                                ['cases'],
                                            test: snapshot.data![index]
                                                ['tests'],
                                            totalDeaths: snapshot.data![index]
                                                ['deaths'],
                                            totalRecovered: snapshot
                                                .data![index]['recovered'],
                                          )));
                            },
                            child: ListTile(
                              title: Text(snapshot.data![index]['country']),
                              subtitle: Text(
                                  snapshot.data![index]['cases'].toString()),
                              leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage(snapshot.data![index]
                                      ['countryInfo']['flag'])),
                            ),
                          )
                        ],
                      );
                    } else {
                      return Container();
                    }
                  }));
            }
          },
        ))
      ]),
    );
  }
}
