import 'package:flutter/material.dart';
import 'package:responsi_prak_mob/models/PhoneModel.dart';
import 'package:responsi_prak_mob/presenters/phone_presenter.dart';
import 'package:responsi_prak_mob/views/PhoneForm.dart';
import 'package:responsi_prak_mob/views/DetailPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> implements PhoneView {
  bool? onDeleteStatus;
  int currentPageIndex = 0;
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Menu"),
        backgroundColor: Colors.green,
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.green,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.book),
            label: 'Bookmark',
          )
        ],
      ),
      body: <Widget>[
        //Index 0
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PhoneForm(isEdit: false),
                      ),
                    );
                  },
                  icon: Icon(Icons.edit, color: Colors.white),
                  label: Text("Add Phone Data"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                Text(
                  "Phone List",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: GridView.builder(
                      itemCount: _phoneDataList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Jumlah kolom
                        crossAxisSpacing: 5, // Spasi antar kolom
                        mainAxisSpacing: 0, // Spasi antar baris
                        childAspectRatio: 3 / 4, // Rasio lebar vs tinggi item
                      ),
                      itemBuilder: (context, index) {
                        final phone = _phoneDataList[index];
                        print("INI HANPHONENYA VIEW: $_phoneDataList");
                        return Column(
                          children: [
                            InkWell(
                              onTap: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DetailPage(id: phone.id!),
                                  ),
                                )
                              },
                              child: Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                          top: Radius.circular(16)),
                                      child: Image.network(
                                        phone.img_url,
                                        height: 120,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        phone.name,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        phone.brand,
                                        style:
                                            const TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        "Rp ${phone.price}",
                                        style: const TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.edit),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => PhoneForm(
                                                    isEdit: true,
                                                    existingData: phone),
                                              ),
                                            );
                                          },
                                          tooltip:
                                              'Edit', // Tampilkan teks saat disentuh (opsional)
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.delete),
                                          onPressed: () {
                                            _presenter
                                                .deletePhoneData(phone.id!);
                                          },
                                          tooltip:
                                              'Delete', // Tampilkan teks saat disentuh (opsional)
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                )
              ],
            )),

        //Index 1
        Column(
          children: [
            Center(
              child: Text("Halaman Bookmark!"),
            )
          ],
        )
      ][currentPageIndex],
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
    setState(() {
      _phoneDataList = phoneListData;
    });
  }

  @override
  void showDetailPhoneData(PhoneModel phoneListData) {
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

  @override
  void onAddPhoneResult(bool status) {}

  @override
  void onDeletePhoneResult(bool status) {
    if (status) {
      SnackBar snackBar = SnackBar(content: Text("Succesfully Deleted Phone!"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      _presenter.loadAllPhoneData();
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
