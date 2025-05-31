import 'package:responsi_prak_mob/models/PhoneModel.dart';
import 'package:responsi_prak_mob/network/base_network.dart';

abstract class PhoneView{
  void showLoading();
  void hideLoading();
  void showAllPhoneData(List<PhoneModel> phoneListData);
  void showDetailPhoneData(PhoneModel phoneListData);
  void onAddPhoneResult(bool status);
  void onUpdatePhoneResult(bool status);
  void onDeletePhoneResult(bool status);
  void showError(String message);
}

class PhonePresenter {
  final PhoneView view;
  PhonePresenter(this.view);

  Future<void> loadAllPhoneData() async {
    try {
      final Map<String, dynamic> response = await BaseNetwork.getAllDataPhone();
      print("Response : $response");

      final List<dynamic> data = response['data']; // ambil field 'data'
      print("INI HANPHONENYA: $data");
      final phoneList = data.map((json) => PhoneModel.fromJson(json)).toList();
      print("INI HANPHONENYA PRESENTER: $phoneList");
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
      print("INI DATA DETAIL : $response");
      final PhoneModel data = PhoneModel.fromJson(response['data']); // ambil field 'data'
      print("INI DATA DETAIL : $data");
      view.showDetailPhoneData(data);
    }catch(e){
      view.showError(e.toString());
    }finally{
      view.hideLoading();
    }
  }

  Future<void> addPhoneData(PhoneModel phone) async {
    try{
      final bool response = await BaseNetwork.addPhoneData(phone);
      print("addStatus: $response");
      view.onAddPhoneResult(response);
    }catch(e){
      view.showError(e.toString());
    }finally{
      view.hideLoading();
    }
  }

  Future<void> updatePhoneData(PhoneModel phone) async {
    try{
      final bool response = await BaseNetwork.updatePhoneData(phone);
      print("updateStatus: $response");
      view.onUpdatePhoneResult(response);
    }catch(e){
      view.showError(e.toString());
    }finally{
      view.hideLoading();
    }
  }

  Future<void> deletePhoneData(int id) async {
    try{
      final bool response = await BaseNetwork.deletePhoneData(id);
      view.onDeletePhoneResult(response);
    }catch(e){
      view.showError(e.toString());
    }finally{
      view.hideLoading();
    }
  }
}