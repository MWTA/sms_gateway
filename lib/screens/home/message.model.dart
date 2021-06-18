class Message {
  Message({
    required this.id,
    required this.phone,
    required this.message,
    required this.status,
  });

  String id;
  String phone;
  String message;
  String status;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"],
        phone: json["phone"],
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "phone": phone,
        "message": message,
        "status": status,
      };
}
