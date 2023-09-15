import 'package:converted/scr/feature/post/model/converted_model.dart';
import 'package:converted/scr/feature/post/widget/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/services/api_services.dart';
import '../data/repository.dart';

class PostView extends StatefulWidget {
  const PostView({Key? key, required this.ccy, this.date,required this.rate}) : super(key: key);
  final String ccy;
  final String? date;
  final String rate;

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  late ApiRepository repository;
  ConvertedModel? convertedModel;

  @override
  void initState() {
    super.initState();
    repository = PostRepository(APIService());
    getOneCurrency();
  }

  void getOneCurrency() async {
    convertedModel =
        await repository.getCurrencyByCcy(ccy: widget.ccy, date: widget.date,rate:widget.rate);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: convertedModel == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(15),
              child: ListView(
                children: [
                  Text("${convertedModel!.ccy}"),
                ],
              ),
            ),
    );
  }
}
