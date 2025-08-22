import 'dart:convert';
import 'package:api_bloc/api.dart';
import 'package:api_bloc/models/gallery_model.dart';
import 'package:api_bloc/models/image_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GalleryRepo {
   static getGallries() async {
    final response = await http.get(
      Uri.parse(
        "${Api.baseURL}/${Api.nsCode}/${Api.authToken}/${Api.getGallery}",
      ),
    );
    print(
      "URL is ${Api.baseURL}/${Api.nsCode}/${Api.authToken}/${Api.getGallery}",
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final dataList = jsonData["data"] ?? [];
      List<GetGalleries> getphotoGallery =
          (dataList as List)
              .map((itemWord) => GetGalleries.fromJson(itemWord))
              .toList();
      return getphotoGallery;
    } else if (Api.authToken.isEmpty || response.statusCode == 100) {
      await getAuth();
      return await getGallries();
    } else {
      throw Exception("Failed to load galleries (status ${response.body})");
    }
  }
//for image
  static getGallriesImage(String code) async {
    final response = await http.get(
      Uri.parse(
        "${Api.baseURL}/${Api.nsCode}/${Api.authToken}/${Api.getGalleryImage}/$code",
      ),
    );
    print(
      "URL is ${Api.baseURL}/${Api.nsCode}/${Api.authToken}/${Api.getGalleryImage}/$code",
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final dataList = jsonData["data"] ?? [];
      List<Data> getphotoGallery =
          (dataList as List)
              .map((itemWord) => Data.fromJson(itemWord))
              .toList();
      return getphotoGallery;
    } else if (Api.authToken.isEmpty || response.statusCode == 100) {
      await getAuth();
      return await getGallriesImage(code);
    } else {
      throw Exception("Failed to load galleries (status ${response.body})");
    }
  }

  static getAuth() async {
    var body = jsonEncode({
      "username": "ezeedemo",
      "password": "ezeedemo",
      "namespaceCode": "demobo",
      "devicemedium": "APP",
    });
    final response = await http.post(
      Uri.parse("${Api.baseURL}/${Api.nsCode}/${Api.authToken}/${Api.getAuth}"),
      body: body,
    );
    print("  url is  ${Api.baseURL}/${Api.nsCode}/${Api.getAuth}");
    try {
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        String auth = jsonData["data"]["authToken"] ?? "";
        Api.authToken = auth;
      } else {
        throw Exception("Failed to load ");
      }
    } catch (e) {
      SnackBar(content: Text(e.toString()));
    }
  }
}
