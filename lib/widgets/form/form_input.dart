class FormInput {
  FormInput({
    required this.name,
    required this.label,
    required this.type,
    required this.value,
    required this.isRequired,
    this.options,
  });

  String name;
  dynamic value;
  String label;
  Type type;
  bool isRequired;
  List<Option>? options;
}

class Option {
  Option({
    required this.label,
    required this.value,
  });

  String label;
  String value;
}

enum Type {
  text,
  dropdown,
  textArea,
  phone,
  number,
  checkBox,
  radio,
  date,
}
