import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';

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
  final catsAPI = <Category>[
    Category(desc: 'Orbita', id: 1, produtorId: 1, subCategorias: [
      Category(
        id: 2,
        desc: 'nome 2',
      ),
      Category(
        id: 3,
        desc: 'nome 3',
      ),
      Category(
        id: 4,
        desc: 'nome 4',
      ),
      Category(
        id: 5,
        desc: 'nome 5',
      )
    ]),
    Category(desc: 'Categoria2', id: 1, produtorId: 1, subCategorias: [
      Category(
        id: 2,
        desc: 'nome 2',
      ),
      Category(
        id: 3,
        desc: 'nome 3',
      ),
      Category(
        id: 4,
        desc: 'nome 4',
      ),
      Category(
        id: 5,
        desc: 'nome 5',
      )
    ]),
    Category(desc: 'categoria3', id: 1, produtorId: 1, subCategorias: [
      Category(
        id: 2,
        desc: 'nome 2',
      ),
      Category(
        id: 3,
        desc: 'nome 3',
      ),
      Category(
        id: 4,
        desc: 'nome 4',
      ),
      Category(
        id: 5,
        desc: 'nome 5',
      )
    ])
  ];
  final selecteds = [].obs;
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

class _MyHomePageState extends State<MyHomePage> {
  MyController? controller;
  @override
  Widget build(BuildContext context) {
    controller = Get.put(MyController());
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: controller!.catsAPI.length,
                  itemBuilder: (_, __) => Container(
                        height: 150,
                        width: Get.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ExpandablePanel(
                              header: Padding(
                                padding: const EdgeInsets.only(
                                  left: 8.0,
                                ),
                                child: Text(
                                  controller!.catsAPI[__].desc!,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              theme: ExpandableThemeData(
                                  hasIcon: true,
                                  fadeCurve: Curves.easeInOut,
                                  tapHeaderToExpand: true,
                                  iconColor: Colors.red,
                                  iconSize: 32.0),
                              controller:
                                  ExpandableController(initialExpanded: false),
                              collapsed: Container(
                                height: 100,
                                child: Column(children: [
                                  MaterialButton(
                                    onPressed: () => controller!
                                        .expandController.expanded = true,
                                    color: Colors.yellow,
                                    child: Text('Exibir categorias'),
                                  ),
                                ]),
                              ),
                              expanded: Container(
                                height: 500.0, // lista de categoria card
                                width: Get.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('${controller!.catsAPI[__].desc}'),
                                    MaterialButton(
                                      onPressed: () => controller!
                                          .expandController.expanded = true,
                                      color: Colors.yellow,
                                      child: Text('Ocultar categorias'),
                                    ),
                                    MaterialButton(
                                        onPressed: () =>
                                            controller!.selectedCategories),
                                    Expanded(
                                      child: ListView.builder(
                                          // lista de subcategorias
                                          itemCount: controller!.catsAPI[__]
                                              .subCategorias!.length,
                                          itemBuilder: (c, index) => Container(
                                                height: 60,
                                                child: Obx(
                                                  () => GestureDetector(
                                                    onTap: () => controller!
                                                        .selectCat(controller!
                                                                .catsAPI[__]
                                                                .subCategorias![
                                                            index]),
                                                    child: Container(
                                                        // margin: EdgeInsets.symmetric(horizontal: 5),
                                                        width: 130,
                                                        height: 40,
                                                        decoration:
                                                            const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          25)),
                                                          color: Colors.grey,
                                                        ),
                                                        margin: const EdgeInsets
                                                            .all(5),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        child: Text(
                                                          '${controller!.catsAPI[__].subCategorias![index].desc}',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color: controller!
                                                                      .selectedCategories
                                                                      .contains(controller!
                                                                          .catsAPI[
                                                                              __]
                                                                          .subCategorias![index])
                                                                  ? Colors.white
                                                                  : Colors.black),
                                                        )),
                                                  ),
                                                ),
                                              )),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
            ),
          ],
        ),
      ),
    );
  }
}

class Categorias {
  String? nome;
  int? id;

  Categorias({this.id, this.nome});
}

// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

List<Category> categoryFromJson(String str) =>
    List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

String categoryToJson(List<Category> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
  Category({
    this.id,
    this.desc,
    this.parentId,
    this.produtorId,
    this.subCategorias,
  });

  int? id;
  String? desc;
  int? parentId;
  int? produtorId;
  List<Category>? subCategorias;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        desc: json["desc"],
        parentId: json["parent_id"] == null ? null : json["parent_id"],
        produtorId: json["produtor_id"],
        subCategorias: json["sub_categorias"] == null
            ? null
            : List<Category>.from(
                json["sub_categorias"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "desc": desc,
        "parent_id": parentId == null ? null : parentId,
        "produtor_id": produtorId,
        "sub_categorias": subCategorias == null
            ? null
            : List<dynamic>.from(subCategorias!.map((x) => x.toJson())),
      };
}
