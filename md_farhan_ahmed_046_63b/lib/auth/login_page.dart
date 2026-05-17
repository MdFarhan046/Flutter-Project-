import 'package:flutter/material.dart';
import 'package:md_farhan_ahmed_046_63b/auth/register_page.dart';
import 'package:md_farhan_ahmed_046_63b/home_page.dart';
import 'package:md_farhan_ahmed_046_63b/widget/input_field.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final _supabase = Supabase.instance.client;

  void login() async {
    String email = emailcontroller.text.trim();
    String password = passcontroller.text.trim();
    setState(() {
      _isLoading = true;
    });
    try {
      await _supabase.auth.signInWithPassword(email: email, password: password);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
      emailcontroller.clear();
      passcontroller.clear();
    } on AuthApiException catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message)));
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 99, 90),
        centerTitle: true,
        title: Text("LoginPage"),
      ),

      body: Center(
        child: SizedBox(
          height: 450,
          width: 350,
          child: Card(
            color: const Color.fromARGB(255, 0, 99, 90),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
                // autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    InputField(
                      controller: emailcontroller,
                      obsecureText: false,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (emailcontroller.text.isEmpty) {
                          return "Field cannot be empty";
                        } else if (!RegExp(
                          r'^[a-z]+([_.]?[a-z0-9]+)*@(gmail|yahoo)\.com$',
                        ).hasMatch(value)) {
                          return "Enter a valid E-mail Address";
                         }
                        return null;
                      },
                      prefixIcon: Icon(Icons.email),
                      hintText: "Enter Email",
                      labelText: "Email",
                    ),
                    SizedBox(height: 15),
                    InputField(
                  
                      controller: passcontroller,
                      obsecureText:true,
                      keyboardType: TextInputType.visiblePassword,
                      
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Field cannot be empty";
                        }
                        
                        return null;
                      },
                      prefixIcon: Icon(Icons.key),
                      hintText: "Enter Password",
                      labelText: "Password",
                    ),
                    SizedBox(height: 10),

                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          login();
                        }
                      },
                      child: _isLoading
                          ? CircularProgressIndicator()
                          : Text("Login"),
                    ),
                   

                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return RegisterPage();
                            },
                          ),
                        );
                      },
                      child: Text("Don't have an account?Register"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
