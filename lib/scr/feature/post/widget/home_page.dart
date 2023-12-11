import 'package:circle_flags/circle_flags.dart';
import 'package:converted/scr/common/services/api_services.dart';
import 'package:converted/scr/feature/post/data/repository.dart';
import 'package:converted/scr/feature/post/model/converted_model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ApiRepository repository;
  List<ConvertedModel>? convertedList;
  late TextEditingController controller1;
  late TextEditingController controller2;

  void getAllCurrency() async {
    convertedList = await repository.getAllModel();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    controller1 = TextEditingController();
    controller2 = TextEditingController();
    repository = PostRepository(APIService());
    getAllCurrency();
  }

  String value1 = "USD";
  String rate1 = "";
  String rate2 = "";

  @override
  Widget build(BuildContext context) {
    final sizeH=MediaQuery.of(context).size.height;
    final sizeW=MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFFEAEAFE),
        body: convertedList == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: Column(
                  children: [
                    const SizedBox(height: 60),
                    const Text(
                      "Currency Converter",
                      style: TextStyle(
                          color: Colors.indigo,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Check live rates, set rate alerts,receive\n               notifications and more",
                      style: TextStyle(color: Colors.grey.shade500),
                    ),
                    const SizedBox(height: 40),
                    Card(
                      elevation: 20,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: SizedBox(
                        height: 280,
                        width: 330,
                        child: DecoratedBox(
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 30),
                                const Text(
                                  "Amount",
                                  style: TextStyle(fontSize: 10),
                                ),
                                Row(
                                  children: [
                                    DropdownButton(
                                      underline: const SizedBox.shrink(),
                                      value: value1 ,
                                      icon: const RotatedBox(
                                        quarterTurns: 1,
                                        child: Icon(Icons.chevron_right),
                                      ),
                                      items: convertedList!.map(
                                        (e) {
                                          String currency = e.ccy!;
                                          rate1 = e.rate!;
                                          String currencyShort = currency
                                              .substring(0, 2)
                                              .toLowerCase();
                                          return DropdownMenuItem(
                                            value: currency,
                                            child: SizedBox(
                                              // height: 123,
                                              width: 123,
                                              child: ListTile(
                                                contentPadding: EdgeInsets.zero,
                                                leading: CircleFlag(
                                                  currencyShort,
                                                  size: 43,
                                                ),
                                                title: Text(currency),
                                              ),
                                            ),
                                          );
                                        },
                                      ).toList(),
                                      onChanged: (String? value) {
                                        value1 = value!;
                                        setState(() {});
                                      },
                                    ),
                                    const SizedBox(width: 20),
                                    SizedBox(
                                      width: 140,
                                      height: 45,
                                      child: TextField(
                                        controller: controller1,
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          for (int i = 0; i < convertedList!.length; i++) {
                                            if (convertedList?[i].ccy == value1) {
                                              double rate=double.tryParse(convertedList?[i].rate ?? "0") ?? 0;
                                              double amount1=double.tryParse(controller1.text)??0;
                                              double convertedAmount=amount1*rate;
                                              controller2.text=convertedAmount.toStringAsFixed(2);
                                            }
                                          }
                                          setState(() {});
                                        },
                                        maxLines: 1,
                                        minLines: 1,
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.zero,
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    const SizedBox(width: 130),
                                    SizedBox(
                                      height: 40,
                                      width: 40,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: Colors.indigo),
                                        child: const Image(
                                          image: AssetImage(
                                              "assets/images/belgi.png"),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  "Converted Amount",
                                  style: TextStyle(fontSize: 10),
                                ),
                                Row(
                                  children: [
                                   const SizedBox(
                                     height: 45,
                                     width: 45,
                                     child: DecoratedBox(
                                       decoration: BoxDecoration(
                                         borderRadius: BorderRadius.all(Radius.circular(100)),
                                         color: Colors.blueGrey
                                       ),
                                       child: Image(image: AssetImage("assets/images/uzb.png")),
                                     ),
                                   ),
                                    const SizedBox(width: 18),
                                    const Text("UZB",style: TextStyle(fontSize: 16),),
                                    const SizedBox(width: 72),
                                    SizedBox(
                                      height: 45,
                                      width: 140,
                                      child: TextField(
                                        controller: controller2,
                                       enabled: false,
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.zero,
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Column(
                      children: [
                        Text(
                          "Indicative Exchange Rate",
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                        const SizedBox(height: 10),
                         Text("$value1 ${controller1.text} = ${controller2.text} So'm",style: const TextStyle(fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
