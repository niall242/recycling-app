// This page has an upload image feature, with a preview displayed
// Email Input
// Validation for PNG/JPG and correct email type

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'settings_provider.dart'; 
import 'widgets/page_header.dart';
import 'app_colors.dart';
import 'theme_colors.dart';


double scale(BuildContext context, double base) {
  return context.watch<SettingsProvider>().largeText ? base + 8 : base;
}

class SendPicturePage extends StatefulWidget {
  const SendPicturePage({super.key});

  @override
  State<SendPicturePage> createState() => _SendPicturePageState();
}

class _SendPicturePageState extends State<SendPicturePage> {
  File? _imageFile;
  final TextEditingController _emailController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Take a photo'),
                onTap: () async {
                  final XFile? image = await _picker.pickImage(source: ImageSource.camera);
                  if (image != null) {
                    setState(() {
                      _imageFile = File(image.path);
                    });
                  }
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Choose from gallery'),
                onTap: () async {
                  final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    setState(() {
                      _imageFile = File(image.path);
                    });
                  }
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _sendData() {
    final email = _emailController.text.trim();

    if (_imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please upload an image.")),
      );
      return;
    }

    final extension = _imageFile!.path.split('.').last.toLowerCase();
    if (extension != 'jpg' && extension != 'jpeg' && extension != 'png') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Only JPG and PNG images are allowed.")),
      );
      return;
    }

    if (email.isEmpty || !email.contains('@') || !email.contains('.')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter a valid email address.")),
      );
      return;
    }

    Navigator.pushNamed(context, '/picture-sent');
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PageHeader(
                title: "Send a picture",
                titleBackgroundColor: ThemeColors.picture(context),
                titleTextColor: Colors.white,
                buttonIconColor: settings.highContrast ? Colors.white : Colors.black,
                buttonTextColor: settings.highContrast ? Colors.white : Colors.black,
                buttonBackgroundColor: ThemeColors.settings(context),
              ),
              Text(
                "Upload your photo below:",
                style: TextStyle(fontSize: scale(context, 16)),
              ),
              const SizedBox(height: 16),

              // Upload and Preview
              Row(
                children: [
                  // Upload Icon
                  Expanded(
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                          color: AppColors.settings,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Icon(Icons.upload_file, color: Colors.black, size: 40),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Preview
                  Expanded(
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: AppColors.settings,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: _imageFile != null
                          ? Image.file(_imageFile!, fit: BoxFit.cover)
                          : const Center(
                              child: Text(
                                "No image selected",
                                style: TextStyle(color: Color(0xFF424242)),
                              ),
                            ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              Text(
                "Enter email address below:",
                style: TextStyle(fontSize: scale(context, 16)),
              ),
              const SizedBox(height: 8),

              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: "you@example.com",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black), 
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black, width: 2), // thicker on focus
                  ),
                ),
              ),


              const SizedBox(height: 24),

              GestureDetector(
                onTap: _sendData,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: ThemeColors.picture(context),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      "Send",
                      style: TextStyle(color: Colors.white, fontSize: scale(context, 16)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
