import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(backgroundColor: Colors.deepPurpleAccent,
   foregroundColor: const Color.fromARGB(255, 252, 251, 250),
   // title: Text("Homepage"),
     //leading: Icon(Icons.home),
     title: Align(
        alignment: Alignment.center,
        child: Text("HomePage"),
     ),
     actions: [
      //IconButton(onPressed:(){}, icon: Icon(Icons.settings)),
      IconButton(onPressed:(){},icon:Icon(Icons.notifications),tooltip: "Notifications",),
      IconButton(onPressed:(){}, icon: Icon(Icons.person),tooltip: "Profile",),
     
     ],
    ),
     floatingActionButton: FloatingActionButton(
      onPressed:() {},
      backgroundColor: Colors.deepPurpleAccent,
      foregroundColor: Colors.white,
      tooltip:"Add Something",
      child: Icon(Icons.add),
      ),
      drawer: NavigationDrawer(
        
        children: [
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(
               color:Colors.blueGrey,
          ),
          accountName: Text("Name"), 
          accountEmail: Text("Email"),
          ),
          ListTile(
            leading: Icon(Icons.home_outlined),
            title: Text("HomePage"),onTap:(){},
            ),
            ListTile(
              leading: Icon(Icons.person),
              title:Text("ProfilePage"),
              onTap:() {},
            ),
            ListTile(
               leading:Icon(Icons.security),
               title:Text("Security & Privacy"),
               onTap:(){},
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title:Text("Settings"),
              onTap:(){},
            ),
            ListTile(
               leading:Icon(Icons.logout),
               title:Text("Logout"),
               onTap:(){},
            ),
      ]),
      body:Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Hello World",style: TextStyle(fontSize: 30,color: Colors.redAccent)),
              Text("Welcome to Flutter",style: TextStyle(color:Colors.amber,fontSize:15)),
              Container(
                height: 300,
                width: 300,
                alignment: Alignment.center,
        
               // padding: EdgeInsets.all(20),
               padding: EdgeInsets.fromLTRB(30, 40, 10, 60),
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  border: Border.all(color:Colors.tealAccent,width: 3),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  //shape: BoxShape.circle,
        
                ),
                child:Text("I am Container!!",
                 style:TextStyle(
                   color:Colors.black,
                   fontSize: 25,
                 )),
                
              )
        
            ],
        
        
        ),
      )
    );
   
  }

}