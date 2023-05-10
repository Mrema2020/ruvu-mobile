import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ReportPage extends StatefulWidget {
  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _controller = TextEditingController();
  File? _image;
  final _picker = ImagePicker();
  UploadTask? uploadTask;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _addData() {
    String category = _controller.text.trim();
    String address = _addressController.text.trim();
    String description = _descriptionController.text.trim();

    if (category.isNotEmpty && address.isNotEmpty && description.isNotEmpty) {
      _firestore.collection('reports').add({
        'category': category,
        'address': address,
        'description': description,
      }).then((value) {
        // Data added successfully
        _controller.clear();
        _addressController.clear();
        _descriptionController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data added successfully')),
        );
      }).catchError((error) {
        // Error occurred while adding data
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error occurred while adding data')),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
    }
  }

  // void _submitForm() {
  //   if (_formKey.currentState!.validate()) {
  //     FirebaseFirestore.instance.collection('reports').add({
  //       'category': _controller,
  //       'address': _addressController.text,
  //       'description': _descriptionController.text,
  //     }).then((value) {
  //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //         content: Text('Data added successfully.'),
  //       ));
  //       _formKey.currentState!.reset();
  //       _addressController.clear();
  //       _descriptionController.clear();
  //     }).catchError((error) {
  //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //         content: Text('Failed to add data.'),
  //       ));
  //     });
  //   }
  // }

  Future uploadFile() async {
    final path = 'files/$_image';
    final file = File(_image!.path);
    final ref = FirebaseStorage.instance.ref().child(path);
    setState(() {
      uploadTask = ref.putFile(file);
    });
    final snapshot = await uploadTask!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    if (kDebugMode) {
      print('Download link: $urlDownload');
    }
    setState(() {
      uploadTask = null;
    });
  }

  String _selectedValue = '';

  final List<String> _dropdownItems = [
    'Select category',
    'Water pollution',
    'Animal keeping',
    'Water blockage',
    'Agriculture activities',
    'Waste disposal',
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Report a problem',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Help to protect the environment',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Category',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Select category',
                      border: OutlineInputBorder(),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      _showDropdown(context);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Address',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _addressController,
                    keyboardType: TextInputType.streetAddress,
                    decoration: const InputDecoration(
                      labelText: 'Address',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Add pictures',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ClipRRect(
              child: Card(
                color: Colors.blueGrey,
                child: IconButton(
                  onPressed: () {
                    _openImagePicker();
                  },
                  icon: const Icon(Icons.cloud),
                ),
              ),
            ),
            const SizedBox(height: 35),
            // The picked image will be displayed here
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 300,
              color: Colors.grey[300],
              child: _image != null
                  ? Image.file(_image!, fit: BoxFit.cover)
                  : const Text('Please select an image'),
            ),
            TextButton(
                onPressed: () {
                  uploadFile();
                },
                child: const Text('Upload image')),
                const SizedBox(
                  height: 20,
                ),
            buildProgress(),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: ElevatedButton(
                  onPressed: () {
                    _addData();
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 15)),
                  child: const Text('Report Problem'),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
        stream: uploadTask?.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            double progress = data.bytesTransferred / data.totalBytes;
            return SizedBox(
              height: 50,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.green,
                  ),
                  Center(
                    child: Text(
                      '${(100 * progress).roundToDouble()}%',
                      style: const TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            );
          } else {}
          return Container();
        },
      );

  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  void _showDropdown(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select category'),
          content: DropdownButton<String>(
            value: _dropdownItems[0],
            onChanged: (value) {
              setState(() {
                _selectedValue = value!;
                _controller.text = value;
              });
              Navigator.of(context).pop();
            },
            items: _dropdownItems.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
