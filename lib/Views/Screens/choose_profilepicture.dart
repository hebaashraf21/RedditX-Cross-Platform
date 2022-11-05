import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Widgets/bottm_sheet.dart';
import '../Widgets/sign_up_bar.dart';
import 'choose_username.dart';
import 'interests.dart';

class ChooseProfilePicture extends StatefulWidget {
  const ChooseProfilePicture({super.key});
  static const routeName = '/ChooseProfilePicture';

  @override
  State<ChooseProfilePicture> createState() => _ChooseProfilePictureState();
}

class _ChooseProfilePictureState extends State<ChooseProfilePicture> {
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;

  @override
  Widget build(BuildContext context) {
    Future<void> takephoto() async {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
      );
      setState(() {
        if (pickedFile != null) {
          _imageFile = File(pickedFile.path);
        }
      });
    }

    Future<void> chooseImage() async {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
      );
      setState(() {
        if (pickedFile != null) {
          _imageFile = File(pickedFile.path);
        }
      });
    }

    void submit(ctx) {
      print('sending data to back end');
      Navigator.of(ctx).pop();
    }

    final mediaQuery = MediaQuery.of(context);
    final dynamic appBar =
        buildAppBar(text: 'Skip', function: () => skip(context));
    final heightScreen = (mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top);
    final widthScreen = (mediaQuery.size.width);
    final padding = heightScreen * 0.03;
    return Scaffold(
      appBar: appBar,
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: padding,
                      left: padding,
                      bottom: heightScreen * 0.01,
                    ),
                    child: const Text(
                      'Set Your Profile Picture',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: heightScreen * 0.03,
                    ),
                    child: const Text(
                      'This is how people will see you on Reddit.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: heightScreen * 0.03,
                    ),
                    child: const Text(
                      '(You can Change it later if you\'d like.)',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: heightScreen * 0.7,
                    child: Center(
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: (_imageFile != null)
                                ? Image.file(
                                    _imageFile!,
                                    fit: BoxFit.cover,
                                    width: widthScreen * 0.7,
                                  )
                                : CircleAvatar(
                                    radius: widthScreen * 0.4,
                                    backgroundColor: Colors.white,
                                    backgroundImage: const AssetImage(
                                      'assets/images/defaultuser.png',
                                    ),
                                  ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: EdgeInsets.only(
                                bottom: heightScreen * 0.1,
                                right: heightScreen * 0.1,
                              ),
                              child: InkWell(
                                onTap: () => showModalBottomSheet<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SizedBox(
                                      height: heightScreen * 0.2,
                                      child: BottomSheetProfilePicture(
                                          takephoto, chooseImage),
                                    );
                                  },
                                ),
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.teal,
                                  size: heightScreen * widthScreen * 0.0002,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: heightScreen * 0.02),
                child: ElevatedButton(
                  onPressed: () => submit(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Save and Continue',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void skip(context) {
  Navigator.of(context).pop();
}

void submit(String kind, ctx) {
  print('sending data to back end');
  Navigator.of(ctx).pop();
  print('---------------------' + kind + '-------------------');
}
