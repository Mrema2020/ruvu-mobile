import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ruvu_app/auth/login.dart';

import '../screens/home_page.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordController2 = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String _errorMessage = '';

  void _showError(String errorMessage) {
    setState(() {
      _errorMessage = errorMessage;
    });
  }

  void _clearError() {
    setState(() {
      _errorMessage = '';
    });
  }

  void _handleSignUp() async {
    _clearError();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      // Navigate to the home screen
      Navigator.of(context).push(MaterialPageRoute(builder:(context) => HomePage()));
    } catch (e) {
      _showError(_errorMessage);
    }
  }

  bool _obscuredText = true;
  bool _obscuredText2 = true;

  _toggle(){
    setState(() {
      _obscuredText = !_obscuredText;
    });
  }

  _toggle2(){
    setState(() {
      _obscuredText2 = !_obscuredText2;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/ruvu_river.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.linearToSrgbGamma()
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sign Up'),
          centerTitle: true,
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20,),
              CircleAvatar(
                radius: 50,
                child: Icon(Icons.person,
                  size: 50,
                ),
              ),
              const SizedBox(height: 20,),
              const Text('Create Account To Continue',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 20,),
              Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      if (_errorMessage.isNotEmpty)
                        Text(
                          _errorMessage,
                          style: const TextStyle(color: Colors.red),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                            enabledBorder:  OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black, width: 1.5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueGrey, width: 1.5),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(),
                            enabledBorder:  OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black, width: 1.5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueGrey, width: 1.5),
                            ),
                            suffixIcon: IconButton(
                                onPressed: (){
                                  _toggle();
                                },
                                icon: Icon(
                                    _obscuredText ? Icons.visibility : Icons.visibility_off
                                )),
                          ),
                          obscureText: _obscuredText,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          controller: _passwordController2,
                          decoration:InputDecoration(
                            labelText: 'Repeat Password',
                            border: OutlineInputBorder(),
                            enabledBorder:  OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black, width: 1.5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueGrey, width: 1.5),
                            ),
                            suffixIcon: IconButton(
                                onPressed: (){
                                  _toggle2();
                                },
                                icon: Icon(
                                    _obscuredText2 ? Icons.visibility : Icons.visibility_off
                                )),
                          ),
                          obscureText: _obscuredText2,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please repeat password';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _handleSignUp,
                        child: const Text('Sign Up'),
                      ),
                      const SizedBox(height: 20,),
                      const Text('Already have Account?',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black
                        ),
                      ),
                      const SizedBox(height: 0,),
                      TextButton(onPressed: (){
                        //Navigator.of(context).push(MaterialPageRoute(builder:(context) => LoginScreen()));
                        Navigator.pop(context);
                      }, child: const Text('Login',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900
                        ),
                      ))
                    ],
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
