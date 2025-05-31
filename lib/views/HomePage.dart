import 'package:flutter/material.dart';
import 'package:responsi_prak_mob/models/PhoneModel.dart';
import 'package:responsi_prak_mob/presenters/phone_presenter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> implements PhoneView {
  List<PhoneModel> _phoneDataList = [];
  late PhonePresenter _presenter;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _presenter = PhonePresenter(this);
    showLoading();
    _presenter.loadAllPhoneData();
  }

  @override
  bool? addPhoneStatus;

  @override
  bool? deletPhoneStatus;

  @override
  bool? updatePhoneStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Main Menu"),
          backgroundColor: Colors.green,
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
                itemCount: _phoneDataList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Jumlah kolom
                  crossAxisSpacing: 10, // Spasi antar kolom
                  mainAxisSpacing: 10, // Spasi antar baris
                  childAspectRatio: 3 / 2, // Rasio lebar vs tinggi item
                ),
                itemBuilder: (context, index) {
                  final phone = _phoneDataList[index];
                  return Container(
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          phone.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ));
                })));
  }

  @override
  void hideLoading() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void showAllPhoneData(List<PhoneModel> placeCategoryList) {
    setState(() {
      _phoneDataList = placeCategoryList;
    });
  }

  @override
  void showDetailPhoneData(List<PhoneModel> placeCategoryList) {
    // TODO: implement showDetailPhoneData
  }

  @override
  void showError(String message) {
    setState(() {
      _errorMessage = message;
    });
  }

  @override
  void showLoading() {
    setState(() {
      _isLoading = true;
    });
  }
}
