import 'package:lawyerapp/components/customtextfield.dart';
import 'package:lawyerapp/components/dropdownitem.dart';
import 'package:lawyerapp/models/user.dart';
import 'package:flutter/material.dart';
import 'package:lawyerapp/components/Roundbutton.dart';
import 'package:lawyerapp/components/title.dart';
import 'package:lawyerapp/constants/colours.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';

class Regstration extends StatefulWidget {
  @override
  _RegstrationState createState() => _RegstrationState();
}

class _RegstrationState extends State<Regstration> {
  final mailcontroller = TextEditingController(),
      usernamecontroller = TextEditingController(),
      phonecontroller = TextEditingController(),
      confirmpasswordcontroller = TextEditingController(),
      passwordcontroller = TextEditingController(),
      ssid = TextEditingController(),
      licencnumber = TextEditingController(),
      address = TextEditingController();

  String lawfield, city, area;

  final _formKey = GlobalKey<FormState>();

  bool isobsecurepass = true, isobsecureCpass = true;
  String password;
  List<String> areas() {
    return ["maadi", "new cairo", "helwan"];
    // return ["roshdy", "sidi gaber"];
    // return city == "cairo"
    //     ? ["maadi", "new cairo", "helwan"]
    //     : city == "alexandria"
    //         ? ["roshdy"]
    //         : [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: k_backgroundcolor,
      body: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Tiltle(),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 80),
                      child: CustomTextfield(
                        label: "Username",
                        validator: 0,
                        controller: usernamecontroller,
                        hint: "Write your username",
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 80),
                      child: CustomTextfield(
                        label: "Email",
                        validator: 1,
                        controller: mailcontroller,
                        hint: "Write yor email",
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 80),
                      child: CustomTextfield(
                        label: "Phone number",
                        validator: 3,
                        controller: phonecontroller,
                        hint: "Write yor phone number",
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Dropdownmenu(
                      value: lawfield,
                      onchange: (val) {
                        setState(() {
                          lawfield = val;
                        });
                      },
                      items: [
                        'Admiralty',
                        'Bankruptcy',
                        'Business',
                        'Civil Rights'
                      ],
                      hint: "select law field",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Dropdownmenu(
                      value: city,
                      onchange: (val) {
                        setState(() {
                          city = val;
                        });
                      },
                      items: ['cairo', 'alexandria'],
                      hint: "select your city",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Dropdownmenu(
                      value: area,
                      items: areas(),
                      onchange: (val) {
                        setState(() {
                          area = val;
                        });
                      },
                      hint: "select your area",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 80),
                      child: CustomTextfield(
                        label: "Address",
                        validator: 0,
                        controller: address,
                        hint: "Write yor Address",
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 80),
                      child: CustomTextfield(
                        label: "ssid",
                        validator: 0,
                        controller: ssid,
                        hint: "Write yor ssid",
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 80),
                      child: CustomTextfield(
                        label: "licencenumber",
                        validator: 0,
                        controller: licencnumber,
                        hint: "Write yor licencenumber",
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 80),
                      child: CustomTextfield(
                        isobscure: isobsecurepass,
                        suffix: GestureDetector(
                          onTap: () {
                            setState(() {
                              isobsecurepass = !isobsecurepass;
                            });
                          },
                          child: Icon(
                            Icons.remove_red_eye,
                            color: k_primarycolor,
                            size: 20,
                          ),
                        ),
                        label: "Password",
                        validator: 2,
                        controller: passwordcontroller,
                        hint: "Write yor password",
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 80),
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          cursorColor: k_primarycolor,
                          style: TextStyle(color: Colors.white),
                          onChanged: (val) => password = val,
                          controller: confirmpasswordcontroller,
                          obscureText: isobsecureCpass,
                          decoration: new InputDecoration(
                              suffix: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isobsecureCpass = !isobsecureCpass;
                                  });
                                },
                                child: Icon(
                                  Icons.remove_red_eye,
                                  color: k_primarycolor,
                                  size: 20,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: k_primarycolor)),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: k_primarycolor),
                                //  when the TextFormField in unfocused
                              ),
                              hintText: "Confirm your password",
                              labelText: "Confirm password",
                              labelStyle: TextStyle(
                                color: textcolor,
                              ),

                              // suffix: ,
                              hintStyle: const TextStyle(color: textcolor)),
                          validator: (val) =>
                              MatchValidator(errorText: "Passwords don't match")
                                  .validateMatch(confirmpasswordcontroller.text,
                                      passwordcontroller.text),
                        )),
                    SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Regestrationsnackbutton(
                      formKey: _formKey,
                      mailcontroller: mailcontroller,
                      passwordcontroller: passwordcontroller,
                      usernamecontroller: usernamecontroller,
                      phonecontroller: phonecontroller,
                      ssid: ssid,
                      licence: licencnumber,
                      lawfield: lawfield,
                      address: address,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Regestrationsnackbutton extends StatelessWidget {
  const Regestrationsnackbutton({
    Key key,
    @required GlobalKey<FormState> formKey,
    @required this.mailcontroller,
    @required this.passwordcontroller,
    @required this.usernamecontroller,
    @required this.phonecontroller,
    this.ssid,
    this.licence,
    this.lawfield,
    this.address,
    this.city,
    this.area,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController mailcontroller;
  final TextEditingController passwordcontroller;
  final TextEditingController usernamecontroller;
  final TextEditingController phonecontroller;
  final TextEditingController ssid;
  final TextEditingController licence;
  final TextEditingController address;

  final String lawfield, city, area;

  @override
  Widget build(BuildContext context) {
    return Roundbutton(
      func: () async {
        if (_formKey.currentState.validate()) {
          User loginuser = User(
              email: mailcontroller.text,
              password: passwordcontroller.text,
              name: usernamecontroller.text,
              phonenumber: phonecontroller.text,
              ssid: ssid.text,
              address: address.text,
              licencenumber: licence.text,
              lawfield: lawfield,
              city: city,
              area: area);
          await loginuser.register(context);
        } else {
          HapticFeedback.mediumImpact();
          Future.delayed(Duration(milliseconds: 50), () {
            // 5s over, navigate to a new page
            HapticFeedback.mediumImpact();
          });
        }
      },
      label: "Register",
    );
  }
}
