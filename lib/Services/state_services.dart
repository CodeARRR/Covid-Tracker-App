import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mycovidtracker/Model/world_state_model.dart';
import 'package:mycovidtracker/Utils/app_url.dart';

class StatesServices {
  Future<WorldStateesModel> fetchWorldStatesRecords() async {
    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return WorldStateesModel.fromJson(data);
    } else {
      throw Exception('error');
    }
  }

  Future<List<dynamic>> countriesListApi() async {
    final response = await http.get(Uri.parse(AppUrl.countriesList));
    var data;
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);

      return data;
    } else {
      throw Exception('error');
    }
  }
}
