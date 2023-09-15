import 'dart:convert';

import 'package:converted/scr/common/constants/api_const.dart';
import 'package:converted/scr/common/services/api_services.dart';
import 'package:converted/scr/feature/post/model/converted_model.dart';

abstract interface class ApiRepository {
  const ApiRepository();

  Future<List<ConvertedModel>> getAllModel();
  Future<ConvertedModel> getCurrencyByCcy({required String ccy, String? date, required String rate});

}

class PostRepository implements ApiRepository {
  final APIService apiService;

  const PostRepository(this.apiService);

  // Hamma ma'lumotni olish
  @override
  Future<List<ConvertedModel>> getAllModel() async {
    String response = await apiService.request(APIConst.allusersPath);

    // jsonDecode(response) => dynamic as List
    // List.from(Iterable<dynamic> list) => List<dynamic>
    // List<Map<String, Object?>>.from(Iterable<dynamic> list) => List<Map<String, Object?>> list
    // list.map((e) => ConvertedModel.fromJson(e)).toList();

    return List<Map<String, Object?>>.from(jsonDecode(response) as List)
        .map(ConvertedModel.fromJson)
        .toList();
  }

  @override
  Future<ConvertedModel> getCurrencyByCcy({required String ccy, String? date,required String rate})async {
    String response = await apiService.request(APIConst.getCurrencyByCcy(ccy: ccy, date: date,rate:rate));

    // jsonDecode(response) => dynamic as List
    // List.from(Iterable<dynamic> list) => List<dynamic>
    // List<Map<String, Object?>>.from(Iterable<dynamic> list) => List<Map<String, Object?>> list

    // return  ConvertedModel.fromJson(list.first);
    return ConvertedModel.fromJson( List<Map<String, Object?>>.from(jsonDecode(response) as List).first);

  }

}


/*
[
  {
  "user": "user",
  "age": 22,
  }
]
 */
