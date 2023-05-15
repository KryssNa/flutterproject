import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hunger_cravings/Reviews/reviews.dart';
import 'package:hunger_cravings/dashboard/screens/changepassword.dart';
import 'package:hunger_cravings/delivery_address/delivery_time.dart';
import 'package:hunger_cravings/profileScreen/update.dart';
import 'package:hunger_cravings/services/notification_service.dart';
import 'package:hunger_cravings/viewmodel/auth_view_model.dart';
import 'package:hunger_cravings/viewmodel/global_ui_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:hunger_cravings/dashboard/screens/home.dart';
import 'package:hunger_cravings/loading/loading.dart';
import 'package:hunger_cravings/loginpage/forgetpassword.dart';
import 'package:hunger_cravings/loginpage/register_screen.dart';
import 'package:hunger_cravings/profileScreen/ContactDetails.dart';
import 'package:hunger_cravings/dashboard/screens/firestore/add_address.dart';
import 'package:hunger_cravings/dashboard/screens/firestore/database.dart';
import 'package:hunger_cravings/dashboard/screens/firestore/edit_address.dart';
import 'package:hunger_cravings/loginpage/login.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'dashboard/screens/location_screens.dart';
import 'dashboard/screens/orderConfirm.dart';
import 'dashboard/screens/orderDetail.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: FirebaseOptions(
      //   apiKey: "AIzaSyDZopgwT3FXAHhsTs2c78yk-dw92lnnEK8",
      //   appId: "1:350617005648:web:64921c07aa521069b4ab55",
      //   messagingSenderId: "350617005648",
      //   projectId: "my-app-name-3d643",
      // ),
      );
  NotificationService.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GlobalUIViewModel()),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
      ],
      child: GlobalLoaderOverlay(
        useDefaultLoading: false,
        overlayWidget: Center(
          child: Image.asset(
            "assets/images/loader.gif",
            height: 100,
            width: 100,
          ),
        ),
        child: Consumer<GlobalUIViewModel>(builder: (context, loader, child) {
          if (loader.isLoading) {
            context.loaderOverlay.show();
          } else {
            context.loaderOverlay.hide();
          }
          return MaterialApp(
              title: 'Hunger Craving',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(primaryColor: Colors.black),
              initialRoute: "/LoadingScreen",
              routes: {
                "/LoadingScreen": (BuildContext context) => LoadingScreen(),
                "/forgotpassword": (BuildContext context) => ForgotScreen(),
                "/login": (BuildContext context) => LoginScreens(),
                "/register": (BuildContext context) => RegisterScreen(),
                "/profile": (BuildContext context) => MyProfile(),
                "/editProfile": (BuildContext context) => ProfileScreen(),
                "/deliveryTime": (BuildContext context) => DeliveryTime(),
                "/home": (BuildContext context) => Home(),
                "/address": (BuildContext context) => AddAddressScreen(),
                "/edit-address": (BuildContext context) => EditAddressScreen(),
                "/database": (BuildContext context) => FirebaseDatabaseScreen(),
                "/changePassword": (BuildContext context) => ChangePassword(),
                "/feedbacks": (BuildContext context) => Feedbacks(),
                "/check": (BuildContext context) => CheckoutScreen(),
                "/map": (BuildContext context) => LocationScreen(),
                "/history": (BuildContext context) => OrderHistoryDetail(),
              });
        }),
      ),
    );
  }
}
