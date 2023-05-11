import 'package:ex7/view_model/emergency_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmergencyDialog extends StatefulWidget {
  const EmergencyDialog({Key? key}) : super(key: key);

  @override
  State<EmergencyDialog> createState() => _EmergencyDialogState();
}

class _EmergencyDialogState extends State<EmergencyDialog> {
  final sosController = TextEditingController();

  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    sosController.text = Provider.of<EmergencyViewModel>(context).sosBase;
    return Consumer<EmergencyViewModel>(
        builder: (context, viewModel, child) => AlertDialog(
              title: const Text("Update SOS message"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                      "Write your new SOS message. You can fill in your actual location using: @loc"),
                  Form(
                      key: key,
                      child: TextFormField(
                        controller: sosController,
                        decoration: const InputDecoration(labelText: "Sos message"),
                        validator: (value) => (value == null || value == "")
                            ? "Sos message can't be empty"
                            : null,
                      )
                  )
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    if (key.currentState!.validate()) {
                      viewModel.changeSos(sosController.text);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Save"),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                )
              ],
            ));
  }
}
