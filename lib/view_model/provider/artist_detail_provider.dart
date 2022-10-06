import 'package:flutter/cupertino.dart';
import 'package:galeri_teknologi_technical/view_model/services/service_artist_detail.dart';

import '../../models/artist_detail_model.dart';

enum StateGetSearch { loadingData, noData, hasData }

class ArtistDetailProvider with ChangeNotifier {
  ServiceArtistDetail service = ServiceArtistDetail();
  List<Results> result = [];
  StateGetSearch state = StateGetSearch.noData;

  void getSearch(String artistName) async {
    state = StateGetSearch.loadingData;
    notifyListeners();
    result = await service.getArtistDetail(artistName) ?? [];
    if (result == []) {
      state = StateGetSearch.noData;
    } else {
      state = StateGetSearch.hasData;
    }
    notifyListeners();
  }
}
