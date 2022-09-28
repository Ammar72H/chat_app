class Message {
  static const String CollectionName = 'Messages';

  String id;
  String roomId;
  String content;
  int dateTime;
  String senderId;
  String senderName;

  Message(
      {this.id = '',
      required this.roomId,
      required this.content,
      required this.dateTime,
      required this.senderId,
      required this.senderName});

  Message.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          roomId: json['roomId'],
          content: json['content'],
          dateTime: json['dateTime'],
          senderId: json['senderId'],
          senderName: json['senderName'],
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'roomId': roomId,
      'content': content,
      'dateTime': dateTime,
      'senderId': senderId,
      'senderName': senderName,
    };
  }
}
