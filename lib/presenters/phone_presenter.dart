import 'package:responsi_prak_mob/models/PhoneModel.dart';
import 'package:responsi_prak_mob/network/base_network.dart';

abstract class PhoneView{
  void showLoading();
  void hideLoading();
  void showAllPhoneData(List<PhoneModel> placeCategoryList);
  void showDetailPhoneData(List<PhoneModel> placeCategoryList);
  bool? addPhoneStatus;
  bool? updatePhoneStatus;
  bool? deletPhoneStatus;
  void showError(String message);
}

class PhonePresenter {
  final PhoneView view;
  PhonePresenter(this.view);

  Future<void> loadAllPhoneData() async {
    try {
      final Map<String, dynamic> response = await BaseNetwork.getAllDataPhone();
      print("Response : $response");

      final List<dynamic> data = response['data'][0]; // ambil field 'data'
      print("INI HANPHONENYA: $data");
      final phoneList = data.map((json) => PhoneModel.fromJson(json)).toList();
      print("INI HANPHONENYA: $phoneList");
      view.showAllPhoneData(phoneList);
    } catch (e) {
      view.showError(e.toString());
    } finally {
      view.hideLoading();
    }
  }

  Future<void> loadPhoneDetailData(int id) async {
    try{
      final Map<String, dynamic> response = await BaseNetwork.getPhoneDetail(id);
      final List<dynamic> data = response['data']; // ambil field 'data'
      final phoneList = data.map((json)=>PhoneModel.fromJson(json)).toList();
      view.showDetailPhoneData(phoneList);
    }catch(e){
      view.showError(e.toString());
    }finally{
      view.hideLoading();
    }
  }

  Future<void> addPhoneData(String name, String brand, int price, String spesification) async {
    try{
      final bool response = await BaseNetwork.addPhoneData(name, brand, price, spesification);
      view.addPhoneStatus = response;
    }catch(e){
      view.showError(e.toString());
    }finally{
      view.hideLoading();
    }
  }

  Future<void> updatePhoneData(int id, String name, String brand, int price, String spesification) async {
    try{
      final bool response = await BaseNetwork.updatePhoneData(id, name, brand, price, spesification);
      view.updatePhoneStatus = response;
    }catch(e){
      view.showError(e.toString());
    }finally{
      view.hideLoading();
    }
  }

  Future<void> deletePhoneData(int id) async {
    try{
      final bool response = await BaseNetwork.deletePhoneData(id);
      view.deletPhoneStatus = response;
    }catch(e){
      view.showError(e.toString());
    }finally{
      view.hideLoading();
    }
  }
}