import 'package:fast_work_app_empleador/models/work_model.dart';
import 'package:fast_work_app_empleador/models/works_type_model.dart';
import 'package:fast_work_app_empleador/services/data_get_services.dart';
import 'package:fast_work_app_empleador/services/data_post_services.dart';
import 'package:fast_work_app_empleador/services/preferencias_usuario/preferencias_usuario.dart';
import 'package:fast_work_app_empleador/utils/colors_utils.dart';
import 'package:fast_work_app_empleador/utils/show_scaffold_message.dart';
import 'package:fast_work_app_empleador/utils/small_components.dart';
import 'package:fast_work_app_empleador/widgets/buttons/button_riased_gradient_widget.dart';
import 'package:fast_work_app_empleador/widgets/buttons/select_button_widget.dart';
import 'package:fast_work_app_empleador/widgets/text/text_widget.dart';
import 'package:fast_work_app_empleador/widgets/textinputs/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker_view/flutter_picker_view.dart';

class AddWorks extends StatefulWidget {
  @override
  _AddWorksState createState() => _AddWorksState();
}

class _AddWorksState extends State<AddWorks> {
  String _typeName = "";
  String _localTypeSelected = "-1";
  String _title = "";
  String _image = "";
  String _description = "";
  String _price = "";
  String _place = "";
  String _placeDescription = "";
  WorksData _dataWorks;
  DataGetServices _dataGetServices = DataGetServices();
  DataPostService _dataPostService = DataPostService();
  final PreferenciasUsuario _preferenciasUsuario = PreferenciasUsuario();
  bool _load = true;
  bool _loadPost = false;
  List<Map<String, dynamic>> _localPlaces = [];
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      _dataWorks = await _dataGetServices.getWorks();
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
      SizedBox(
        height: 35,
      ),
      Row(children: [
        TextScalableWidget("Crear Trabajo",
            context: context,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Spacer()
      ]),
      GlobalInputtextField(
        obscure: false,
        onChanged: (value) {
          setState(() {
            _image = value;
          });
        },
        text: 'Imagen',
        textinputType: TextInputType.text,
        textStyle: null,
      ),
      GlobalInputtextField(
        obscure: false,
        onChanged: (value) {
          setState(() {
            _title = value;
          });
        },
        text: 'Título',
        textinputType: TextInputType.text,
        textStyle: null,
      ),
      SizedBox(
        height: 5,
      ),
      GlobalInputtextField(
        obscure: false,
        onChanged: (value) {
          setState(() {
            _description = value;
          });
        },
        text: 'Descripción',
        textStyle: null,
        textinputType: TextInputType.text,
      ),
      SizedBox(
        height: 5,
      ),
      GlobalInputtextField(
        obscure: false,
        onChanged: (value) {
          setState(() {
            _price = value;
          });
        },
        text: 'Valor en Cop',
        textinputType: TextInputType.number,
        textStyle: null,
      ),
      _selectButtonTypeWork(),
      SizedBox(
        height: 5,
      ),
      GlobalInputtextField(
        obscure: false,
        onChanged: (value) {
          setState(() {
            _place = value;
          });
        },
        text: 'Lugar',
        textinputType: TextInputType.text,
        textStyle: null,
      ),
      SizedBox(
        height: 5,
      ),
      GlobalInputtextField(
        obscure: false,
        onChanged: (value) {
          setState(() {
            _placeDescription = value;
          });
        },
        text: 'Descripción Lugar',
        textinputType: TextInputType.text,
        textStyle: null,
      ),
      RaisedGradientButton(
        gradient: LinearGradient(
          colors: _place.isNotEmpty && _placeDescription.isNotEmpty
              ? <Color>[secondaryColor, mainColor]
              : <Color>[grey, grey],
        ),
        child: TextScalableWidget(
          'AÑADIR',
          context: context,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        onPressed: _place.isNotEmpty && _placeDescription.isNotEmpty
            ? () {
                var _object = {"place": "", "place_description": ""};
                _object["place"] = _place;
                _object["place_description"] = _placeDescription;
                _localPlaces.add(_object);
                setState(() {
                  _place = "";
                  _placeDescription = "";
                });
              }
            : null,
      ),
      Container(
        height: 90,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _localPlaces.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: grey.withOpacity(0.3),
                    height: 90,
                    width: 300,
                    child: Column(
                      children: [
                        Spacer(),
                        TextScalableWidget(
                          _localPlaces[index]["place"],
                          context: context,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        TextScalableWidget(
                          _localPlaces[index]["place_description"],
                          context: context,
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
      SizedBox(
        height: 60,
      ),
      !_loadPost
          ? RaisedGradientButton(
              gradient: LinearGradient(
                colors: _validateForm()
                    ? <Color>[secondaryColor, mainColor]
                    : <Color>[grey, grey],
              ),
              child: TextScalableWidget(
                'CREAR TRABAJO',
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

                      setState(() {
                        _loadPost = false;
                      });

                      Map<String, dynamic> response =
                          await _dataPostService.createWork(
                              WorkyModel(
                                image: _image,
                                title: _title,
                                description: _description,
                                price: _price,
                                type: _localTypeSelected,
                                state: "created",
                              ),
                              _localPlaces,
                              {
                            "name": _preferenciasUsuario.name,
                            "profile_photo": _preferenciasUsuario.profilePhoto,
                            "id": _preferenciasUsuario.id
                          });
                      if (response['ok']) {
                        Navigator.pop(context);
                        showLocalScaffoldMessage(
                          message: response['user_message'],
                          context: context,
                        );
                      } else {
                        showLocalScaffoldMessage(
                          message: response['user_message'],
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

  Widget _selectButtonTypeWork() {
    if (_load) {
      return progressCircularBar();
    } else {
      return Container(
        child: SelectButton(
            enable: true,
            widthState: 0.69,
            title: _localTypeSelected == "-1" ? 'Selecciona Tipo' : _typeName,
            section: (int index) {
              return _dataWorks.data.length;
            },
            itemBuilder: (int section, int row) {
              return TextScalableWidget(
                '${_dataWorks.data[row].data.name}',
                context: context,
              );
            },
            selectedItem: _dataWorks.data
                .map((e) => e.data.name)
                .toList()
                .indexOf(_localTypeSelected),
            onConfirm: (PickerController pickerController) {
              int selectedIndex = pickerController.selectedRowAt(section: 0);
              _localTypeSelected = _dataWorks.data[selectedIndex].id;
              _typeName = _dataWorks.data[selectedIndex].data.name;
              setState(() {});
            }),
      );
    }
  }

  bool _validateForm() {
    if (_title.isNotEmpty &&
        _description.isNotEmpty &&
        _price.isNotEmpty &&
        _localTypeSelected != "-1" &&
        _localPlaces.length >= 2 &&
        _image.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
