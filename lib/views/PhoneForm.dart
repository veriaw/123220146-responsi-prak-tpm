import 'package:flutter/material.dart';
import 'package:responsi_prak_mob/models/PhoneModel.dart';
import 'package:responsi_prak_mob/presenters/phone_presenter.dart';
import 'package:responsi_prak_mob/views/HomePage.dart';

class PhoneForm extends StatefulWidget {
  final bool isEdit;
  final PhoneModel? existingData;

  const PhoneForm({super.key, this.isEdit = false, this.existingData});

  @override
  State<PhoneForm> createState() => _PhoneFormState();
}

class _PhoneFormState extends State<PhoneForm> implements PhoneView {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _specController = TextEditingController();
  late PhonePresenter _presenter;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _presenter = PhonePresenter(this);
    if (widget.isEdit && widget.existingData != null) {
      _nameController.text = widget.existingData!.name ?? '';
      _brandController.text = widget.existingData!.brand ?? '';
      _priceController.text = widget.existingData!.price.toString();
      _specController.text = widget.existingData!.specification ?? '';
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final phoneData = PhoneModel(
        id: widget.isEdit ? widget.existingData!.id : null,
        name: _nameController.text.trim(),
        brand: _brandController.text.trim(),
        price: int.tryParse(_priceController.text.trim()) ?? 0,
        specification: _specController.text.trim(),
        img_url: widget.existingData?.img_url ?? '', // jika diperlukan
      );

      if (widget.isEdit) {
        // TODO: Call update method
        _presenter.updatePhoneData(phoneData);
        print("Edit Phone Data: $phoneData");
      } else {
        // TODO: Call add method
        _presenter.addPhoneData(phoneData);
        print("Add Phone Data: $phoneData");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit ? "Edit Phone" : "Add Phone"),
        backgroundColor: Colors.green.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField("Phone Name", _nameController),
              _buildTextField("Brand", _brandController),
              _buildTextField("Price", _priceController,
                  keyboardType: TextInputType.number),
              _buildTextField("Specification", _specController, maxLines: 3),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _submitForm,
                icon: Icon(widget.isEdit ? Icons.save : Icons.add),
                label: Text(widget.isEdit ? "Save Changes" : "Add Phone"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return '$label is required';
          }
          return null;
        },
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
    // TODO: implement showAllPhoneData
  }

  @override
  void showDetailPhoneData(PhoneModel phoneListData) {
    // TODO: implement showDetailPhoneData
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
    if (status) {
      SnackBar snackBar =
          SnackBar(content: Text("Succesfully Add Phone Data!"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
        (route) => false,
      );
    } else {
      SnackBar snackBar = SnackBar(content: Text("Failed To Add Phone Data!"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void onDeletePhoneResult(bool status) {
    // TODO: implement onDeletePhoneResult
  }

  @override
  void onUpdatePhoneResult(bool status) {
    if (status) {
      SnackBar snackBar =
          SnackBar(content: Text("Succesfully Edit Phone Data!"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
        (route) => false,
      );
    } else {
      SnackBar snackBar = SnackBar(content: Text("Failed To Edit Phone Data!"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
