import 'package:sms_gateway/widgets/form/form_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:sms_gateway/widgets/button.dart';

class AppForm extends StatelessWidget {
  final double separatorHeight = 20.0;
  final formKey = GlobalKey<FormBuilderState>();
  final Function onSubmit;
  final List<FormInput> inputs;

  AppForm({
    Key? key,
    required this.onSubmit,
    required this.inputs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: formKey,
      initialValue: {
        for (var i = 0; i < inputs.length; i++)
          '${inputs[i].name}': inputs[i].value,
      },
      autovalidateMode: AutovalidateMode.always,
      child: _buildForm(context),
    );
  }

  Widget _buildForm(BuildContext context) {
    List<Widget> form = [];
    for (var i = 0; i < inputs.length; i++) {
      List<String? Function(dynamic)> validators = [];

      if (inputs[i].isRequired) {
        validators.add(FormBuilderValidators.required(context));
      }
      switch (inputs[i].type.toString()) {
        case 'dropdown':
          form.add(
            FormBuilderDropdown(
              name: inputs[i].name,
              style: _inputStyle(),
              decoration: _inputDecoration(labelText: inputs[i].label),
              // initialValue: 'Male',
              hint: Text('Select ${inputs[i].label}'),
              validator: FormBuilderValidators.compose(validators),
              items: [
                for (var j = 0; j < inputs[i].options!.length; j++)
                  {
                    "value": inputs[i].options![j].value,
                    "label": inputs[i].options![j].label
                  },
              ]
                  .map((option) => DropdownMenuItem(
                      value: option['value'],
                      child: Text(option['label'] ?? '')))
                  .toList(),
            ),
          );
          break;
        case 'text':
          form.add(
            FormBuilderTextField(
              name: inputs[i].name,
              style: _inputStyle(),
              validator: FormBuilderValidators.compose(validators),
              decoration: _inputDecoration(labelText: inputs[i].label),
            ),
          );
          break;
        case 'date':
          form.add(
            FormBuilderDateTimePicker(
              name: inputs[i].name,
              style: _inputStyle(),
              inputType: InputType.date,
              validator: FormBuilderValidators.compose(
                  [FormBuilderValidators.required(context)]),
              format: DateFormat("dd-MM-yyyy"),
              decoration: _inputDecoration(labelText: inputs[i].label),
            ),
          );
          break;
        default:
          form.add(
            FormBuilderTextField(
              name: inputs[i].name,
              style: _inputStyle(),
              validator: FormBuilderValidators.compose(validators),
              decoration: _inputDecoration(labelText: inputs[i].label),
            ),
          );
      }
      form.add(
        SizedBox(
          height: separatorHeight,
        ),
      );
    }
    form.add(
      Button(
        title: 'Submit',
        blockButton: true,
        onPress: () {
          formKey.currentState!.save();
          if (formKey.currentState!.validate()) {
            onSubmit(formKey.currentState!.value);
          }
        },
      ),
    );
    return Column(children: form);
  }

  TextStyle _inputStyle() {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w300,
      color: Colors.black,
    );
  }

  InputDecoration _inputDecoration({
    String? labelText,
    String? hintText,
    String? helpText,
    Icon? prefixIcon,
    String? prefixText = ' ',
    String? suffixText,
  }) {
    return InputDecoration(
      border: const OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xff255b96)),
      ),
      hintText: hintText,
      helperText: helpText,
      labelText: labelText,
      prefixIcon: prefixIcon,
      prefixText: prefixText,
      suffixText: suffixText,
      suffixStyle: const TextStyle(color: Colors.green),
      labelStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w300,
      ),
    );
  }
}
