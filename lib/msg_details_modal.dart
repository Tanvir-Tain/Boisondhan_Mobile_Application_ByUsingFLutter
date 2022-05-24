import 'dart:convert';

List<MsgDetailsModal> msgDetailsModalFromJson(String str) => List<MsgDetailsModal>.from(json.decode(str).map((x) => MsgDetailsModal.fromJson(x)));

String msgDetailsModalToJson(List<MsgDetailsModal> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MsgDetailsModal {
    MsgDetailsModal({
        this.msg,
        this.senderId,
        this.recvId,
        this.msgType,
        this.userId,
    });

    String msg;
    String senderId;
    String recvId;
    String msgType;
    String userId;

    factory MsgDetailsModal.fromJson(Map<String, dynamic> json) => MsgDetailsModal(
        msg: json["msg"],
        senderId: json["senderID"],
        recvId: json["recvID"],
        msgType: json["msgType"],
        userId: json["userID"],
    );

    Map<String, dynamic> toJson() => {
        "msg": msg,
        "senderID": senderId,
        "recvID": recvId,
        "msgType": msgType,
        "userID": userId,
    };
}
