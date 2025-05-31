import 'package:flutter/material.dart';
import 'package:responsi_prak_mob/models/PhoneModel.dart';
import 'package:responsi_prak_mob/presenters/phone_presenter.dart';
import 'package:responsi_prak_mob/views/HomePage.dart';
import 'package:responsi_prak_mob/views/PhoneForm.dart';

class DetailPage extends StatefulWidget {
  final int id;
  const DetailPage({super.key, required this.id});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> implements PhoneView {
  bool? onDeleteStatus;
  PhoneModel? _phoneDetailData;
  late PhonePresenter _presenter;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _presenter = PhonePresenter(this);
    showLoading();
    _presenter.loadPhoneDetailData(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Phone Detail"),
          backgroundColor: Colors.green.shade700,
          actions: [
            IconButton(onPressed: () => {}, icon: Icon(Icons.bookmark_border))
          ]),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(
                  child: Text(
                    'Error: $_errorMessage',
                    style: TextStyle(fontSize: 16, color: Colors.red),
                  ),
                )
              : _phoneDetailData != null
                  ? SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 8,
                        shadowColor: Colors.greenAccent.withOpacity(0.5),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    _phoneDetailData!.img_url,
                                    height: 250,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        height: 250,
                                        color: Colors.grey[300],
                                        child: Icon(
                                          Icons.broken_image,
                                          size: 80,
                                          color: Colors.grey[700],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                _phoneDetailData!.name,
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green[900],
                                ),
                              ),
                              SizedBox(height: 10),
                              _infoRow(Icons.branding_watermark, 'Brand',
                                  _phoneDetailData!.brand),
                              _infoRow(Icons.attach_money, 'Price',
                                  '\$${_phoneDetailData!.price}'),
                              SizedBox(height: 10),
                              Text(
                                'Specifications',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green[800],
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                _phoneDetailData!.specification,
                                style: TextStyle(fontSize: 16),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PhoneForm(
                                              isEdit: true,
                                              existingData: _phoneDetailData),
                                        ),
                                      );
                                    },
                                    icon: Icon(Icons.edit, color: Colors.white),
                                    label: Text("Edit Phone Data"),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blueAccent,
                                      foregroundColor: Colors.white,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      textStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      _presenter.deletePhoneData(widget.id);
                                    },
                                    icon:
                                        Icon(Icons.delete, color: Colors.white),
                                    label: Text("Delete Phone Data"),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.redAccent,
                                      foregroundColor: Colors.white,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      textStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: Text(
                        "No data available",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.green[700]),
          SizedBox(width: 10),
          Text(
            '$label: ',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.green[800]),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void hideLoading() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void showAllPhoneData(List<PhoneModel> phoneListData) {
    // Not used here
  }

  @override
  void showDetailPhoneData(PhoneModel phoneListData) {
    setState(() {
      _phoneDetailData = phoneListData;
      _errorMessage = null;
      _isLoading = false;
    });
  }

  @override
  void showError(String message) {
    setState(() {
      _errorMessage = message;
      _isLoading = false;
    });
  }

  @override
  void showLoading() {
    setState(() {
      _isLoading = true;
    });
  }

  @override
  void onAddPhoneResult(bool status) {
    // TODO: implement onAddPhoneResult
  }

  @override
  void onDeletePhoneResult(bool status) {
    if (status) {
      SnackBar snackBar = SnackBar(content: Text("Succesfully Deleted Phone!"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
        (route)=>false
      );
    } else {
      SnackBar snackBar = SnackBar(content: Text("Failed To Delete Phone!"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void onUpdatePhoneResult(bool status) {
    // TODO: implement onUpdatePhoneResult
  }
}
