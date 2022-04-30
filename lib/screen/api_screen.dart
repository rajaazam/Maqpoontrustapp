import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:maqpoon_trust/models/data_model.dart';
import 'package:maqpoon_trust/providers/provider_data_api.dart';
import 'package:maqpoon_trust/screen/welcome_screen.dart';

import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ key}) : super(key: key);
  

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    //initState to perform all task before page loads...
    super.initState();
    Future.microtask(() async => {
          Provider.of<ProviderClass>(context, listen: false)
              .apiCall(), //provider to call API and update data....
        });
  }

  @override



  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Consumer<ProviderClass>(
            //Consumer widget rebuilds any widgets below it whenever notifyListeners() gets called.
            builder: (context, myModel, child) {
              return Text(myModel.count.toString());
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.navigation),
          backgroundColor: Colors.green,
          onPressed: () {
            // Provider.of<ProviderClass>(context, listen: false).count += 1;
            
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => WelcomeScreen()));
            //navigate to page to increase count...
          },
        ),
        body: Consumer<ProviderClass>(builder: (context, myModel, child) {
          //The Consumer widget rebuilds any widgets below it whenever notifyListeners() gets called.
          return ListView.builder(
            itemCount: myModel.post == null
                ? 0
                : myModel.post.length, //length according to data present
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: ListTile(
                  leading:
                  // Container(
                  //   child: Consumer<ProviderClass>(builder:
                  //    (context,mydata,child){
                  //      Image.network(mydata.uri);
                  //    }
                     
                    
                  //    ),
                  // ),
                  //   Container(child:Consumer<ProviderClass>(
                  //   builder: (context, myModel, child){

                  //     return myModel.im
                  //   },
                  // )
                  // ),
                  //FlutterLogo(),
                  const CircleAvatar(
                  backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSssNCG4dNeWSCM4WhMd37l32POwonImo1hTw&usqp=CAU',
                  
                  ), 
                  ),
                 title: 
                  Text(Provider.of<ProviderClass>(context, listen: false)
                      .post[index]
                      .title),
                      subtitle:Text(Provider.of<ProviderClass>(context, listen: false)
                      .post[index]
                      .id.toString()), 
                  trailing: Icon(Icons.more_vert),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}

// class MyModel extends ChangeNotifier {
//   late Image _image;
//   set image(Image value) {
//     _image = value;
//     notifyListeners();
//   }
//   Image get image => _image;
