

import 'package:flutter/material.dart';
import 'package:maqpoon_trust/providers/all_categories_provider.dart';
import 'package:maqpoon_trust/providers/donate_now_provider.dart';
import 'package:maqpoon_trust/providers/provider_data_api.dart';
import 'package:maqpoon_trust/providers/request_for_help_provider.dart';
import 'package:maqpoon_trust/providers/request_records_provider.dart';
import 'package:maqpoon_trust/providers/sign_in_provider.dart';
import 'package:maqpoon_trust/screen/api_screen.dart';
import 'package:maqpoon_trust/screen/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';


void main() {
  runApp(
    MultiProvider(
      providers: providers,
      child: const MyApp(),
    ),
  );
}

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<SignInProvider>(create: (_) => SignInProvider()),
  ChangeNotifierProvider<RequestForHelpProvider>(create: (_) => RequestForHelpProvider()),
  ChangeNotifierProvider<AllCategoriesProvider>(create: (_) => AllCategoriesProvider()),
  ChangeNotifierProvider<DonateNowProvider>(create: (_) => DonateNowProvider()),
  ChangeNotifierProvider<RequestRecordsProvider>(create: (_) => RequestRecordsProvider()),
  ChangeNotifierProvider<ProviderClass>(create: (_)=>ProviderClass())
];


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Al-Khidmat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Sora',
      ),
      home: const 
      //HomeScreen()
       SplashScreen(),
      //home: const WelcomeScreen(),
    );
  }
}

