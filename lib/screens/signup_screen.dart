import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marvel/resources/auth_methods.dart';
import 'package:marvel/responsive/mobile_screen_layout.dart';
import 'package:marvel/responsive/responsive_layout_screen.dart';
import 'package:marvel/responsive/web_screen_layout.dart';
import 'package:marvel/screens/login_screen.dart';
import 'package:marvel/utils/colors.dart';
import 'package:marvel/utils/utils.dart';
import 'package:marvel/widgets/text_field_input.dart';
import 'package:image_picker/image_picker.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      bio: _bioController.text,
      file: _image!,
    );

    if (res != 'success') {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
                  mobileScreenLayout: Mobilescreentayout(),
                  webScreenLayout: Webscreentayout(),
                )),
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  void navigateToLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(child: Container(), flex: 2),
            //svg image
            SvgPicture.asset(
              'assets/ic_instagram.svg',
              color: primaryColor,
              height: 64,
            ),
            const SizedBox(height: 64),
            // circular widget to accept and show our selected file
            Stack(children: [
              _image != null
                  ? CircleAvatar(
                      radius: 64,
                      backgroundImage: MemoryImage(_image!),
                    )
                  : const CircleAvatar(
                      radius: 64,
                      backgroundImage: NetworkImage(
                          'data:image/jpeg;base64,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'),
                    ),
              Positioned(
                bottom: -10,
                left: 80,
                child: IconButton(
                  onPressed: selectImage,
                  icon: const Icon(
                    Icons.add_a_photo,
                  ),
                ),
              )
            ]),
            const SizedBox(height: 24),
            //text field input for username
            TextFieldInput(
              hintText: 'Enter Your Username',
              textInputType: TextInputType.text,
              textEditingController: _usernameController,
            ),
            const SizedBox(height: 24),
            //text field input for email
            TextFieldInput(
              hintText: 'Enter Your Email',
              textInputType: TextInputType.emailAddress,
              textEditingController: _emailController,
            ),
            const SizedBox(height: 24),
            //text field input for password
            TextFieldInput(
              hintText: 'Enter Your Password',
              textInputType: TextInputType.text,
              textEditingController: _passwordController,
              isPass: true,
            ),
            const SizedBox(height: 24),
            //text field input for bio
            TextFieldInput(
              hintText: 'Enter Your bio',
              textInputType: TextInputType.text,
              textEditingController: _bioController,
            ),
            const SizedBox(height: 24),
            //button login
            InkWell(
              onTap: signUpUser,
              child: Container(
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : const Text("Sign Up"),
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  color: blueColor,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Flexible(child: Container(), flex: 2),

            //Transitioning to sign up
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                child: const Text("Dont have an account?"),
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
              ),
              GestureDetector(
                onTap: navigateToLogin,
                child: Container(
                  child: const Text(
                    ' Login ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
              )
            ])
          ],
        ),
      ),
    ));
  }
}
