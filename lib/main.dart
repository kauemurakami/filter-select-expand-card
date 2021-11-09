import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class MyController extends GetxController {
  showcats() => showcategorias.value = !showcategorias.value;

  final categoriasAPI = <Categorias>[
    Categorias(id: 1, nome: 'NOME1'),
    Categorias(id: 2, nome: 'NOME2'),
    Categorias(id: 3, nome: 'NOME3'),
    Categorias(id: 4, nome: 'NOME4'),
    Categorias(id: 5, nome: 'NOME5'),
    Categorias(id: 6, nome: 'NOME6'),
    Categorias(id: 7, nome: 'NOME7'),
  ];
  final showcategorias = false.obs;
  final selectedCategories = [].obs;
  final expandController = ExpandableController(initialExpanded: false);
  selectCat(e) {
    if (selectedCategories.contains(e)) {
      var i = selectedCategories.indexOf(e);
      selectedCategories.removeAt(i);
    } else {
      selectedCategories.add(e);
    }
  }
}

class Categorias {
  String? nome;
  int? id;

  Categorias({this.id, this.nome});
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  MyController? controller;
  @override
  Widget build(BuildContext context) {
    controller = Get.put(MyController());
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: Get.height,
          width: Get.width,
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: Get.width / 2,
            color: Colors.black.withOpacity(.5),
            child: ExpandablePanel(
              header: const Padding(
                padding: EdgeInsets.only(left: 8.0, top: 8.0),
                child: Text(
                  'Teste',
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              collapsed: Container(
                height: 50,
                child: MaterialButton(
                  color: Colors.blue,
                  onPressed: () => controller!.expandController.expanded = true,
                  child: const Text(
                    'Exibir categorias',
                  ),
                ),
              ),
              theme: ExpandableThemeData(
                  hasIcon: true,
                  fadeCurve: Curves.easeInOut,
                  iconColor: Colors.yellow,
                  iconSize: 32.0),
              expanded: Container(
                height: 200,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 50,
                      child: MaterialButton(
                        color: Colors.blue,
                        onPressed: () =>
                            controller!.expandController.expanded = false,
                        child: const Text(
                          'Ocultar categorias',
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Wrap(
                          spacing: -1,
                          direction: Axis.vertical,
                          children: controller!.categoriasAPI
                              .map(
                                (element) => Obx(
                                  () => GestureDetector(
                                    onTap: () => controller!.selectCat(element),
                                    child: Container(
                                        // margin: EdgeInsets.symmetric(horizontal: 5),
                                        width: 130,
                                        height: 40,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25)),
                                          color: Colors.grey,
                                        ),
                                        margin: const EdgeInsets.all(5),
                                        padding: const EdgeInsets.all(5),
                                        child: Text(
                                          element.nome!,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: controller!
                                                      .selectedCategories
                                                      .contains(element)
                                                  ? Colors.white
                                                  : Colors.black),
                                        )),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              controller: controller!.expandController,
            ),
          ),
        ),
      ),
    );
  }
}
