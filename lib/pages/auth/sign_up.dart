import 'package:fast_work_app_empleador/models/documents_data_model.dart';
import 'package:fast_work_app_empleador/models/genders_data_model.dart';
import 'package:fast_work_app_empleador/models/users_data_model.dart';
import 'package:fast_work_app_empleador/pages/home/home_page.dart';
import 'package:fast_work_app_empleador/services/data_get_services.dart';
import 'package:fast_work_app_empleador/services/data_post_services.dart';
import 'package:fast_work_app_empleador/utils/colors_utils.dart';
import 'package:fast_work_app_empleador/utils/show_scaffold_message.dart';
import 'package:fast_work_app_empleador/utils/small_components.dart';
import 'package:fast_work_app_empleador/utils/validators.dart';
import 'package:fast_work_app_empleador/widgets/buttons/button_riased_gradient_widget.dart';
import 'package:fast_work_app_empleador/widgets/buttons/select_button_widget.dart';
import 'package:fast_work_app_empleador/widgets/text/text_widget.dart';
import 'package:fast_work_app_empleador/widgets/textinputs/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker_view/flutter_picker_view.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _genderName = "";
  String _typeName = "";
  String _localGenderSelected = "-1";
  String _localTypeSelected = "-1";
  final Validators _validators = Validators();
  String _name = "";
  String _email = "";
  String _password = "";
  String _numberDocuemnt = "";
  String _phoneNumber = "";
  String _description = "";
  DocumentsData _dataDocument;
  GendersData _dataGenders;
  DataGetServices _dataGetServices = DataGetServices();
  DataPostService _dataPostService = DataPostService();
  bool _load = true;
  bool _loadPost = false;
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      _dataDocument = await _dataGetServices.getDocuments();
      _dataGenders = await _dataGetServices.getGenders();
      setState(() {
        _load = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: _createForm(_size),
      )),
    );
  }

  Widget _createForm(Size size) {
    final List<Widget> _listOfItems = _listOfWidgets(size, context);

    return ListView.builder(
        //physics: NeverScrollableScrollPhysics(),
        itemCount: _listOfItems.length,
        itemBuilder: (context, index) {
          return _listOfItems[index];
        });
  }

  List<Widget> _listOfWidgets(Size size, BuildContext context) {
    return [
      SizedBox(
        height: 5,
      ),
      Row(children: [
        GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back)),
        Spacer()
      ]),
      Container(
        height: 55,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.contain, image: AssetImage("assets/logo.png"))),
      ),
      SizedBox(
        height: 5,
      ),
      TextScalableWidget(
        "EMPLEADOR",
        context: context,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.bold, color: mainColor),
      ),
      GlobalInputtextField(
        obscure: false,
        onChanged: (value) {
          setState(() {
            _name = value;
          });
        },
        text: 'Nombre',
        textinputType: TextInputType.text,
        textStyle: null,
      ),
      SizedBox(
        height: 20,
      ),
      GlobalInputtextField(
        obscure: false,
        onChanged: (value) {
          setState(() {
            _email = value;
          });
        },
        text: 'Email',
        textStyle: null,
        textinputType: TextInputType.emailAddress,
      ),
      SizedBox(
        height: 20,
      ),
      GlobalInputtextField(
        obscure: true,
        onChanged: (value) {
          setState(() {
            _password = value;
          });
        },
        text: 'Contraseña',
        textinputType: null,
        textStyle: null,
      ),
      Row(children: [
        Flexible(flex: 1, child: _selectButtonDocument()),
        SizedBox(
          width: 10,
        ),
        Flexible(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.only(top: 14.4),
            child: GlobalInputtextField(
              obscure: false,
              onChanged: (value) {
                setState(() {
                  _numberDocuemnt = value;
                });
              },
              text: 'Documento',
              textinputType: TextInputType.phone,
              textStyle: null,
            ),
          ),
        ),
      ]),
      SizedBox(
        height: 10,
      ),
      _selectButtonGender(),
      SizedBox(
        height: 25,
      ),
      GlobalInputtextField(
        obscure: false,
        onChanged: (value) {
          setState(() {
            _phoneNumber = value;
          });
        },
        text: 'Celular',
        textinputType: TextInputType.phone,
        textStyle: null,
      ),
      SizedBox(
        height: 20,
      ),
      GlobalInputtextField(
        obscure: false,
        onChanged: (value) {
          setState(() {
            _description = value;
          });
        },
        text: 'Descripción',
        textinputType: TextInputType.text,
        textStyle: null,
      ),
      SizedBox(
        height: 20,
      ),
      !_loadPost
          ? RaisedGradientButton(
              gradient: LinearGradient(
                colors: _validateForm()
                    ? <Color>[secondaryColor, mainColor]
                    : <Color>[grey, grey],
              ),
              child: TextScalableWidget(
                'CREAR CUENTA',
                context: context,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              onPressed: _validateForm()
                  ? () async {
                      setState(() {
                        _loadPost = true;
                      });
                      Map<String, dynamic> response =
                          await _dataPostService.createUser(UserData(
                              id: null,
                              name: _name,
                              email: _email,
                              password: _password,
                              type: "Empleador",
                              gender: _genderName,
                              documentType: _localTypeSelected,
                              document: _numberDocuemnt,
                              phone: _phoneNumber,
                              description: _description,
                              vehicle: " ",
                              status: "Activo",
                              profilePhoto:
                                  "https://1.bp.blogspot.com/-iF0a06Cs4Kc/YQEy3CPXLzI/AAAAAAAAF9Y/7UYoTKUl6uw7ElGbMzS-o_L1co5vAOQUgCLcBGAsYHQ/s870/Screenshot_20210728-112932_1.png"));
                      setState(() {
                        _loadPost = false;
                      });

                      if (response['ok']) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                            (route) => false);
                      } else {
                        showLocalScaffoldMessage(
                          message: response['mensaje'],
                          context: context,
                        );
                      }
                    }
                  : null,
            )
          : Center(child: CircularProgressIndicator()),
      SizedBox(
        height: 20,
      ),
      TextScalableWidget(
        "Al crear una cuenta en FastWork aceptas todos los términos de uso",
        context: context,
        textAlign: TextAlign.center,
      )
    ];
  }

  Widget _selectButtonDocument() {
    if (_load) {
      return progressCircularBar();
    } else {
      return Container(
        child: SelectButton(
            enable: true,
            widthState: 0.1,
            title: _localGenderSelected == "-1" ? 'TD' : _genderName,
            section: (int index) {
              return _dataDocument.data.length;
            },
            itemBuilder: (int section, int row) {
              return TextScalableWidget(
                '${_dataDocument.data[row].data.shortName}',
                context: context,
              );
            },
            selectedItem: _dataDocument.data
                .map((e) => e.data.name)
                .toList()
                .indexOf(_localGenderSelected),
            onConfirm: (PickerController pickerController) {
              int selectedIndex = pickerController.selectedRowAt(section: 0);
              _localGenderSelected = _dataDocument.data[selectedIndex].id;
              _genderName = _dataDocument.data[selectedIndex].data.shortName;
              setState(() {});
            }),
      );
    }
  }

  Widget _selectButtonGender() {
    if (_load) {
      return progressCircularBar();
    } else {
      return Container(
        child: SelectButton(
            enable: true,
            widthState: 0.69,
            title: _localTypeSelected == "-1" ? 'Selecciona Género' : _typeName,
            section: (int index) {
              return _dataGenders.data.length;
            },
            itemBuilder: (int section, int row) {
              return TextScalableWidget(
                '${_dataGenders.data[row].data.name}',
                context: context,
              );
            },
            selectedItem: _dataGenders.data
                .map((e) => e.data.name)
                .toList()
                .indexOf(_localTypeSelected),
            onConfirm: (PickerController pickerController) {
              int selectedIndex = pickerController.selectedRowAt(section: 0);
              _localTypeSelected = _dataGenders.data[selectedIndex].id;
              _typeName = _dataGenders.data[selectedIndex].data.name;
              setState(() {});
            }),
      );
    }
  }

  bool _validateForm() {
    if (_name.isNotEmpty &&
        _validators.validateEmail(_email) &&
        _validators.validatePassword(_password) &&
        _localGenderSelected != "-1" &&
        _numberDocuemnt.isNotEmpty &&
        _phoneNumber.length >= 10 &&
        _description.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
