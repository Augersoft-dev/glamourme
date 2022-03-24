// import 'package:flutter/material.dart';
// import 'package:glamourme/view/authentication/launcherScreen/launcher_screen.dart';
// import 'package:glamourme/view/theme/theme.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Glamourme',
//       theme: customTheme(),
//       home: LauncherScreen(),
//     );
//   }
// }


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glamourme/utils/style.dart';
import 'package:glamourme/view/onboarding/onboarding.dart';
import 'package:glamourme/view/theme/theme.dart';
// import 'package:glamourme/model/onboarding_content.dart';
// import 'package:glamourme/view/authentication/authentication_bloc.dart';
// import 'package:glamourme/view/onboarding/onboarding.dart';

// import 'utils/constants.dart';
// import 'view/authentication/launcherScreen/launcher_screen.dart';
// import 'view/.loading_cubit.dart';

// void main() => runApp(MultiRepositoryProvider(
//       providers: [
//         RepositoryProvider(create: (_) => AuthenticationBloc()),
//         RepositoryProvider(create: (_) => LoadingCubit()),
//       ],
//       child: const MyApp(),
//     ));

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> with WidgetsBindingObserver {
  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show error message if initialization failed
    if (_error) {
      return MaterialApp(
          home: Scaffold(
        body: Container(
          color: Colors.white,
          child: Center(
              child: Column(
            children: const [
              Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 25,
              ),
              SizedBox(height: 16),
              Text(
                'Failed to initialise firebase!',
                style: TextStyle(color: Colors.red, fontSize: 25),
              ),
            ],
          )),
        ),
      ));
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return Container(
        color: Colors.white,
        child: const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      );
    }

    return MaterialApp(
      theme: customTheme(),
        // theme: ThemeData(
        //     snackBarTheme: const SnackBarThemeData(
        //         contentTextStyle: TextStyle(color: Colors.white)),
        //     colorScheme: ColorScheme.fromSwatch()
        //         .copyWith(secondary:  Color(primaryColor))),
        debugShowCheckedModeBanner: false,
        color: primaryColor,
        home:  OnboardingPage());
  }

  @override
  void initState() {
    super.initState();
    initializeFlutterFire();
  }
}
