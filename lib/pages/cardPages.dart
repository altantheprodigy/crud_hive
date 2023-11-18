

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/card_controller.dart';
import '../model/card.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({Key? key}) : super(key: key);

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  final controller = Get.put(CardController());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController saldoController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    saldoController.dispose();
    imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CRUD"),
      ),
      body: GetBuilder<CardController>(
        builder: (cont) =>
            ListView.builder(
              itemCount: cont.cardsCount,
              itemBuilder: (context, index) {
                if (cont.cardsCount > 0) {
                  card? kartu = cont.observableBox.getAt(index);
                  return Column(
                    children: [
                      Text(kartu?.saldo ?? "blank"),
                      Text(kartu?.name ?? "N/A"),
                      Image.asset("images/" + (kartu?.image ?? "")),

                      IconButton(
                        onPressed: () {
                          addEditCard(index: index, kartu: kartu);
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {
                          cont.deleteNote(index: index);
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  );
                } else {
                  return const Center(
                    child: Text("List is Empty"),
                  );
                }
              },
            ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addEditCard();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  addEditCard({int? index, card? kartu}) {
    showDialog(
      context: context,
      builder: (context) {
        if (kartu != null) {
          nameController.text = kartu.name ?? '';
          saldoController.text = kartu.saldo ?? '';
          imageController.text = kartu.image ?? '';
        } else {
          nameController.clear();
          saldoController.clear();
          imageController.clear();
        }
        return Material(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(hintText: "Card Name"),
                    controller: nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(hintText: "Saldo"),
                    controller: saldoController,
                    maxLines: 5,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(hintText: "Images"),
                    controller: imageController,
                    maxLines: 5,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () {
                      bool? isValidated = formKey.currentState?.validate();
                      if (isValidated == true) {
                        String titleText = nameController.text;
                        String saldoText = saldoController.text;
                        String imgText = imageController.text;

                        if (index != null) {
                          controller.updateNote(
                            index: index,
                            kartu: card(
                              name: titleText,
                              saldo: saldoText,
                              image: imgText,
                            ),
                          );
                        } else {
                          controller.createNote(
                            kartu: card(
                              name: titleText,
                              saldo: saldoText,
                              image: imgText,
                            ),
                          );
                        }
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Enter valid values"),
                          ),
                        );
                      }
                    },
                    child: const Text("Submit"),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
