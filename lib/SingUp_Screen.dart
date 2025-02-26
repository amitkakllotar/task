import 'package:flutter/material.dart';
import 'package:task/ChatScreen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  String? selectedCountry;
  String? selectedState;
  String? selectedCity;
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Sing Up",style: TextStyle(fontSize: 40,fontWeight: FontWeight.w700,color: Color(0xFF438E96),fontFamily:"Trajan Pro" ),),
              Text("Please enter your credentials to proceed ",style: TextStyle(color: Color(0xFF3A4750),fontSize: 16),),
              buildLabel("Full Name"),
              buildTextField(fullNameController, "Enter your full name"),

              buildLabel("Phone"),
              buildTextField(phoneController, "Enter your phone number", keyboardType: TextInputType.phone),

              buildLabel("Email"),
              buildTextField(emailController, "Enter your email", keyboardType: TextInputType.emailAddress),

              buildLabel("Password"),
              buildTextField(passwordController, "Enter your password", obscureText: true),

              buildLabel("Address"),
              buildTextField(addressController, "Address Line 1\nAddress Line 2\nAddress Line 3", maxLines: 3),

              buildLabel("Country"),
              buildDropdown(["India", "USA", "UK"], (value) => setState(() => selectedCountry = value), selectedCountry),

              buildLabel("State"),
              buildDropdown(["Select State"], (value) => setState(() => selectedState = value), selectedState),

              buildLabel("City"),
              buildDropdown(["Select City"], (value) => setState(() => selectedCity = value), selectedCity),

              buildLabel("Postal Code"),
              buildTextField(postalCodeController, "Enter postal code", keyboardType: TextInputType.number),

              buildLabel("My Date of Birth"),
              buildDatePicker(),

              buildLabel("Gender"),
              buildGenderSelection(),

              SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: () {
                    setState(() {

                    });
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return ChatScreen();
                      },));
                      print("Form Submitted");
                    }
                  },

                  child: Container(
                    decoration: BoxDecoration(color:Color(0xFF3B757F), borderRadius: BorderRadius.circular(10)),
                      height: 50,
                      width: double.infinity,
                      child: Center(child: Text("CREATE ACCOUNT", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700,color: Colors.white)))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 7),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: "Schyler",
          color: Color(0xFF3B757F),
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
  Widget buildTextField(TextEditingController controller, String hintText, {TextInputType keyboardType = TextInputType.text, bool obscureText = false, int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      decoration: InputDecoration(
        filled: true,
        fillColor: controller.text.isEmpty ? Colors.white : Color(0xFFDDEDF6),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0x40696969)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xff438e96), width: 2.0),
        ),
        hintText: hintText,
      ),
      onChanged: (value) => setState(() {}),
      validator: (value) => value!.isEmpty ? "Please enter $hintText" : null,
    );
  }

  Widget buildDropdown(List<String> items, ValueChanged<String?> onChanged, String? selectedValue) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
      ),
      items: items.map((String value) => DropdownMenuItem(value: value, child: Text(value))).toList(),
      onChanged: onChanged,
    );
  }

  Widget buildDatePicker() {
    return TextFormField(
      controller: dobController,
      readOnly: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Select Date",
        suffixIcon: IconButton(
          icon: Icon(Icons.calendar_today),
          onPressed: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (pickedDate != null) {
              setState(() {
                dobController.text = "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
              });
            }
          },
        ),
      ),
      validator: (value) => value!.isEmpty ? "Please select your date of birth" : null,
    );
  }

  Widget buildGenderSelection() {
    return Row(
      children: [
        Radio<String>(
          value: "Male",
          groupValue: selectedGender,
          onChanged: (value) => setState(() => selectedGender = value),
        ),
        Text("Male"),
        SizedBox(width: 10),
        Radio<String>(
          value: "Female",
          groupValue: selectedGender,
          onChanged: (value) => setState(() => selectedGender = value),
        ),
        Text("Female"),
        SizedBox(width: 10),
        Radio<String>(
          value: "Prefer not to say",
          groupValue: selectedGender,
          onChanged: (value) => setState(() => selectedGender = value),
        ),
        Text("Prefer not to say"),
      ],
    );
  }
}
