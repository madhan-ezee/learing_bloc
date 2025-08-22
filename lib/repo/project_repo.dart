import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:api_bloc/models/gallery_model.dart';

class ProjectRepo {
  final String apiUrl =
      "http://bits-app.ezeebits.com/api/bits/4b3055c82e8af839cd5e723b48e42bddd0508b13/get/Galleries";

  Future<List<GetGalleriesRsp>> fetchproject() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List dataList = jsonData["data"] ?? [];
      return dataList.map((e) => GetGalleriesRsp.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load ");
    }
  }
}
