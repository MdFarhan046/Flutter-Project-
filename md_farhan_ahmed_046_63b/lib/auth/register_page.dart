import 'package:flutter/material.dart';
import 'package:md_farhan_ahmed_046_63b/auth/login_page.dart';
import 'package:md_farhan_ahmed_046_63b/widget/input_field.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  TextEditingController cpasscontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final _supabase = Supabase.instance.client;

  void register() async {
    String name = namecontroller.text.trim();
    String email = emailcontroller.text.trim();
    String password = passcontroller.text.trim();
    setState(() {
      _isLoading = true;
    });
    try {
      print("try");
      final authResponse = await _supabase.auth.signUp(
        email: email,
        password: password,
      );
      print("Auth: ${authResponse.user}");
      final user = authResponse.user;
      if (user != null) {
        print("User: $user");
        await _supabase.from('profiles').insert({
          'id': user.id, // Link to auth.users
          'name': name,
          'email': email,
        });
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Registered Successfully!!")));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } on AuthApiException catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message)));
    }
    namecontroller.clear();
    emailcontroller.clear();
    passcontroller.clear();
    cpasscontroller.clear();
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
        title: Text("RegisterPage"),
      ),

      body: Center(
        child: SizedBox(
          height:500,
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
                    SizedBox(height: 10),
                    InputField(
                      controller: namecontroller,
                      obsecureText: false,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Field cannot be empty";
                        } else if (!RegExp(r'^[a-zA-Z .]+$').hasMatch(value)) {
                          return "Enter a valid name!!";
                        }
                        return null;
                      },

                      prefixIcon: Icon(Icons.person),
                      hintText: "Enter Name",
                      labelText: "Name",
                    ),
                    SizedBox(height: 15),

                    InputField(
                      controller: emailcontroller,
                      obsecureText: false,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Field cannot be empty";
                        } else if (!RegExp(
                          r'^[a-z]+([.]?[a-z0-9]+)*@[a-z]+\.com$',
                        ).hasMatch((value))) {
                          return "Enter a valid Email";
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
                      obsecureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Field cannot be empty";
                        } else if (!RegExp(
                          r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*]).{6,}$',
                        ).hasMatch((value))) {
                          return "Enter a Strong password";
                        }
                        return null;
                      },
                      prefixIcon: Icon(Icons.key),
                      hintText: "Enter Password",
                      labelText: "Password",
                    ),
                    SizedBox(height: 15),

                    InputField(
                      controller: cpasscontroller,
                      obsecureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Field cannot be empty";
                        }
                        if (passcontroller.text != cpasscontroller.text) {
                          return "password and confirm password does't match";
                        }
                        return null;
                      },

                      prefixIcon: Icon(Icons.key),
                      hintText: "Enter Confirm Password",
                      labelText: "Confirm Password",
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          register();
                        }
                      },
                      child: _isLoading
                          ? CircularProgressIndicator()
                          : Text("Register"),
                    ),
                    SizedBox(height: 10),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return LoginPage();
                            },
                          ),
                        );
                      },
                      child: Text("Already have an account?Login"),
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
