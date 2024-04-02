import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key});

  final user = FirebaseAuth.instance.currentUser!;

  // sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  // Method to handle booking appointment
  // void bookAppointment(BuildContext context) {
  //   // Implement your logic to handle booking appointment
  //   // For example, you can navigate to a new screen where users can book appointments
  //   // Navigator.push(context, MaterialPageRoute(builder: (context) => AppointmentBookingScreen()));
  // }
  bookAppointment(String docId, String docName, String docNum, context) async {
    if (formkey.currentState!.validate()) {
      try {
        isLoading(true);
        var store = FirebaseFirestore.instance.collection('appointments').doc();
        await store.set({
          'appBy': FirebaseAuth.instance.currentUser?.uid,
          'appDay': appDayController.text,
          'appTime': appTimeController.text,
          'appName': appNameController.text,
          'appMobile': appMobileController.text,
          'appMsg': appMessageController.text,
          'appWith': docId,
          'appDocName': docName,
          'appDocNum': docNum,
        });
        isLoading(false);
        VxToast.show(context, msg: "Appointment is booked sucessfully");
        Get.back();
      } catch (e) {
        VxToast.show(context, msg: "$e");
      }
    }
  }

  String? validdata(value) {
    if (value!.isEmpty) {
      return 'please fill this';
    }
    RegExp emailRefExp = RegExp(r'^.{3,}$');
    if (!emailRefExp.hasMatch(value)) {
      return 'Enter valid data';
    }
    return null;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: Icon(Icons.logout),
          ),
          IconButton(
            onPressed: () => bookAppointment(context),
            icon: Icon(Icons.event_note), // You can change the icon as per your requirement
          ),
        ],
      ),
      body: Center(
        child: Text(
          "LOGGED IN AS: " + user.email!,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
