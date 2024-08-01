import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/user_provider.dart';
import 'screens/user_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return ChangeNotifierProvider(
      // Initialize the UserProvider to manage state
      create: (context) => UserProvider(),
      child: MaterialApp(
        title: 'User List App',
        theme: ThemeData(
          primarySwatch: Colors.blue, // Set the color of the app
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const UserListPage(), // Set the default screen
      ),
    );
  }
}
