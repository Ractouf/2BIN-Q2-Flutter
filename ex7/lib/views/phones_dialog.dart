import 'package:ex7/view_model/emergency_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhonesDialog extends StatefulWidget {
  const PhonesDialog({Key? key}) : super(key: key);

  @override
  State<PhonesDialog> createState() => _PhonesDialogState();
}

class _PhonesDialogState extends State<PhonesDialog> {
  final phoneController = TextEditingController();

  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<EmergencyViewModel>(
      builder: (context, viewModel, child) => AlertDialog(
        title: const Text("Manage SOS recipients"),
        content: SizedBox(
          width: 600,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: viewModel.phonesSos.length,
                  itemBuilder: (context, index) {
                    var phone = viewModel.phonesSos[index];
                    return ListTile(
                      title: Text(phone),
                      trailing: IconButton(
                        icon: const Icon(Icons.access_alarm),
                        onPressed: () => viewModel.deltePhoneSos(phone),
                      ),
                    );
                  },
                ),
              ),
              Form(
                key: key,
                child: TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                      labelText: "New recipient phone number"),
                  validator: (value) => (value == null || value == "")
                      ? "Phone can't be empty"
                      : null,
                ),
              )
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (key.currentState!.validate()) {
                viewModel.addPhoneSos(phoneController.text);
              }
            },
            child: const Text("Save"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          )
        ],
      ),
    );
  }
}
