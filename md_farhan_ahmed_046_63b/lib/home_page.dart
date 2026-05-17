import 'package:flutter/material.dart';
import 'package:md_farhan_ahmed_046_63b/auth/login_page.dart';
import 'package:md_farhan_ahmed_046_63b/bmi_page.dart';
import 'package:md_farhan_ahmed_046_63b/calculator_page.dart';
import 'package:md_farhan_ahmed_046_63b/converter_page.dart';
import 'package:md_farhan_ahmed_046_63b/dictonary_page.dart';
import 'package:md_farhan_ahmed_046_63b/note_page.dart';
import 'package:md_farhan_ahmed_046_63b/stop_watch.dart';
import 'package:md_farhan_ahmed_046_63b/upload_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    final _supabase = Supabase.instance.client;

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: const Color.fromARGB(255, 252, 251, 250),
        centerTitle: true,
        title: Text("Utility App"),
        actions: [
        
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications),
            tooltip: "Notifications",
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.person),
            tooltip: "Profile",
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   backgroundColor: Colors.deepPurpleAccent,
      //   foregroundColor: Colors.white,
      //   tooltip: "Add Something",
      //   child: Icon(Icons.add),
      // ),
      drawer: NavigationDrawer(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.blueGrey),
            accountName: Text("Name"),
            accountEmail: Text("Email"),
          ),
          ListTile(
            leading: Icon(Icons.home_outlined),
            title: Text("HomePage"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("ProfilePage"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.security),
            title: Text("Security & Privacy"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            onTap: () {
                _supabase.auth.signOut() ;
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
            },
            
          ),
        ],
      ),
    
  body: Padding(
  padding: const EdgeInsets.all(12),

  child: GridView.count(

    crossAxisCount: 3,

    crossAxisSpacing: 10,
    mainAxisSpacing: 10,

    children: [

      buildButton(
        context,
        "Calculator",
        Icons.calculate,
        Colors.orange,
        CalculatorPage(),
      ),

      buildButton(
        context,
        "BMI",
        Icons.monitor_weight,
        Colors.purple,
        BmiPage(),
      ),
      buildButton(
        context,
        "Dictonary",
        Icons.menu_book,
        const Color.fromARGB(255, 94, 39, 176),
        DictionaryPage(),
      ),

      buildButton(context, 
      "StopWatch",
       Icons.timer,
       Colors.teal,
       StopwatchPage()
       
      ),

      buildButton(
        context,
        "Converter",
        Icons.currency_exchange,
        Colors.green,
        ConverterPage(),
      ),

      buildButton(
        context,
        "Notes",
        Icons.note,
        Colors.blue,
        NotePage(),
      ),

       buildButton(
        context,
        "Upload",
        Icons.upload,
        Colors.redAccent,
        UploadPage(),
      ),

    

    ],
  ),
  
),

    );

    
  }
   Widget buildButton(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    Widget page,
    ) {

  return ElevatedButton(

    onPressed: () {

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => page,
        ),
      );

    },

    style: ElevatedButton.styleFrom(

      backgroundColor: color,

      foregroundColor: Colors.white,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),

      elevation: 8,

      padding: const EdgeInsets.all(15),

    ),

    child: Column(

      mainAxisAlignment: MainAxisAlignment.center,

      children: [

        Icon(
          icon,
          size: 55,
        ),

        const SizedBox(height: 15),

        Text(
          title,

          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

      ],
    ),
  );
}}
