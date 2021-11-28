import 'package:fast_work_app_empleador/gobal/global_endpoints.dart';
import 'package:fast_work_app_empleador/models/documents_data_model.dart';
import 'package:fast_work_app_empleador/models/genders_data_model.dart';
import 'package:fast_work_app_empleador/models/vechicles_data_model.dart';
import 'package:dio/dio.dart';
import 'package:fast_work_app_empleador/models/works_ready_user.dart';
import 'package:fast_work_app_empleador/models/works_type_model.dart';
import 'package:fast_work_app_empleador/services/preferencias_usuario/preferencias_usuario.dart';

class DataGetServices {
  Dio _dioGet = new Dio();
  final PreferenciasUsuario _preferenciasUsuario = PreferenciasUsuario();
  Future<VechiclesData> getVehicles() async {
    try {
      final Response resp = await _dioGet.get(endPoint + vehicles);
      Map<String, dynamic> decodeResp = resp.data;
      if (decodeResp['message'] == "OK") {
        return VechiclesData.fromJson(decodeResp);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<DocumentsData> getDocuments() async {
    try {
      final Response resp = await _dioGet.get(endPoint + documents);
      Map<String, dynamic> decodeResp = resp.data;

      if (decodeResp['message'] == "OK") {
        return DocumentsData.fromJson(decodeResp);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<GendersData> getGenders() async {
    try {
      final Response resp = await _dioGet.get(endPoint + gendersData);
      Map<String, dynamic> decodeResp = resp.data;

      if (decodeResp['message'] == "OK") {
        return GendersData.fromJson(decodeResp);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<WorksData> getWorks() async {
    try {
      final Response resp = await _dioGet.get(endPoint + worksTypeData);
      Map<String, dynamic> decodeResp = resp.data;

      if (decodeResp['message'] == "OK") {
        return WorksData.fromJson(decodeResp);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<WorksReadyModel> getMyReadyWorks() async {
    try {
      _dioGet.options.headers['user_id'] = _preferenciasUsuario.id;
      final Response resp = await _dioGet.get(endPoint + readyWorks);
      Map<String, dynamic> decodeResp = resp.data;

      if (decodeResp['message'] == "OK") {
        return WorksReadyModel.fromJson(decodeResp);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<WorksReadyModel> getMyFinishWorks() async {
    try {
      _dioGet.options.headers['user_id'] = _preferenciasUsuario.id;
      final Response resp = await _dioGet.get(endPoint + getworksFinishedWork);
      Map<String, dynamic> decodeResp = resp.data;

      if (decodeResp['message'] == "OK") {
        return WorksReadyModel.fromJson(decodeResp);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
