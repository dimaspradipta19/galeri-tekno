import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:galeri_teknologi_technical/models/artist_detail_model.dart';

class ServiceArtistDetail {
  Future<List<Results>?> getArtistDetail(String artistName) async {
    try {
      final response = await Dio()
          .get("https://itunes.apple.com/search?term=$artistName&entity=song");

      Map<String, dynamic> decodeData = jsonDecode(response.data);
      var model = CountResultArtist.fromJson(decodeData);

      List<Results>? result = model.results!;

      return result;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
