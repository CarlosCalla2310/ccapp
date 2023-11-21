import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ccapp/data.dart';
import 'package:ccapp/data_provider.dart';
import 'package:ccapp/item.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    final dataProvider = context.watch<DataProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('<<R E C O R D A T O R I O S>>'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: dataProvider.dataList.length,
                  itemBuilder: (context, index) {
                    final Data data = dataProvider.dataList[index];
                    return Item(
                      data: data,
                      onEditPressed: () => _editReminder(data, context, dataProvider),
                      onDeletePressed: () => dataProvider.delete(data.id!),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addReminder(context, dataProvider);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addReminder(BuildContext context, DataProvider dataProvider) {
    showDialog(
        context: context,
        builder: (context) {
          String title = "";
          String description = "";
          return AlertDialog(
            title: const Text('Nuevo Recordatorio'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (value) {
                    title = value;
                  },
                  decoration: const InputDecoration(labelText: "Título"),
                ),
                TextField(
                  onChanged: (value) {
                    description = value;
                  },
                  decoration: const InputDecoration(labelText: "Descripción"),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancelar')),
              TextButton(
                  onPressed: () {
                    dataProvider.add(Data(title: title, description: description));
                    Navigator.of(context).pop();
                  },
                  child: const Text('Agregar')),
            ],
          );
        });
  }

  void _editReminder(Data data, BuildContext context, DataProvider dataProvider) {
    final TextEditingController titleController = TextEditingController(text: data.title);
    final TextEditingController descriptionController = TextEditingController(text: data.description);
    showDialog(
        context: context,
        builder: (context) {
          String title = data.title;
          String description = data.description;
          return AlertDialog(
            title: const Text('Actualizar Recordatorio'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  onChanged: (value) {
                    title = value;
                  },
                  decoration: const InputDecoration(labelText: "Título"),
                ),
                TextField(
                  controller: descriptionController,
                  onChanged: (value) {
                    description = value;
                  },
                  decoration: const InputDecoration(labelText: "Descripción"),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancelar')),
              TextButton(
                  onPressed: () {
                    dataProvider.edit(Data(id: data.id, title: title, description: description));
                    Navigator.of(context).pop();
                  },
                  child: const Text('Guardar')),
            ],
          );
        });
  }
}
