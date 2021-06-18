import 'package:sms_gateway/widgets/form/form_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:sms_gateway/widgets/button.dart';

class AppForm extends StatefulWidget {
  final Function onSubmit;
  final List<FormInput> inputs;
  AppForm({
    Key? key,
    required this.onSubmit,
    required this.inputs,
  }) : super(key: key);

  @override
  _AppFormState createState() => _AppFormState();
}

class _AppFormState extends State<AppForm> {
  final double separatorHeight = 20.0;
  final formKey = GlobalKey<FormBuilderState>();

  _AppFormState();

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: formKey,
      initialValue: {
        for (var i = 0; i < widget.inputs.length; i++)
          '${widget.inputs[i].name}': widget.inputs[i].value,
      },
      autovalidateMode: AutovalidateMode.always,
      child: _buildForm(context),
    );
  }

  Widget _buildForm(BuildContext context) {
    List<Widget> form = [];
    for (var i = 0; i < widget.inputs.length; i++) {
      List<String? Function(dynamic)> validators = [];

      if (widget.inputs[i].isRequired) {
        validators.add(FormBuilderValidators.required(context));
      }
      switch (widget.inputs[i].type) {
        case Type.dropdown:
          form.add(
            FormBuilderDropdown(
              name: widget.inputs[i].name,
              style: _inputStyle(),
              decoration: _inputDecoration(labelText: widget.inputs[i].label),
              hint: Text('Select ${widget.inputs[i].label}'),
              validator: FormBuilderValidators.compose(validators),
              items: widget.inputs[i].options
                  .map(
                    (option) => DropdownMenuItem(
                      value: option.value,
                      child: Text(
                        option.label,
                      ),
                    ),
                  )
                  .toList(),
            ),
          );
          break;
        case Type.text:
          form.add(
            FormBuilderTextField(
              name: widget.inputs[i].name,
              style: _inputStyle(),
              validator: FormBuilderValidators.compose(validators),
              decoration: _inputDecoration(labelText: widget.inputs[i].label),
            ),
          );
          break;
        case Type.phone:
          form.add(
            FormBuilderTextField(
              name: widget.inputs[i].name,
              style: _inputStyle(),
              validator: FormBuilderValidators.compose(validators),
              decoration: _inputDecoration(labelText: widget.inputs[i].label),
              keyboardType: TextInputType.phone,
            ),
          );
          break;
        case Type.number:
          form.add(
            FormBuilderTextField(
              name: widget.inputs[i].name,
              style: _inputStyle(),
              validator: FormBuilderValidators.compose(validators),
              decoration: _inputDecoration(labelText: widget.inputs[i].label),
              keyboardType: TextInputType.number,
            ),
          );
          break;
        case Type.date:
          form.add(
            FormBuilderDateTimePicker(
              name: widget.inputs[i].name,
              style: _inputStyle(),
              inputType: InputType.date,
              validator: FormBuilderValidators.compose(
                  [FormBuilderValidators.required(context)]),
              format: DateFormat("dd-MM-yyyy"),
              decoration: _inputDecoration(labelText: widget.inputs[i].label),
            ),
          );
          break;
        default:
          form.add(
            FormBuilderTextField(
              name: widget.inputs[i].name,
              style: _inputStyle(),
              validator: FormBuilderValidators.compose(validators),
              decoration: _inputDecoration(labelText: widget.inputs[i].label),
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
            widget.onSubmit(formKey.currentState!.value);
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
