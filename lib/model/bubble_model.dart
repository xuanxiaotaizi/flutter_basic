import 'package:appdemo/model/user_model.dart';

class Bubble {
  final int type;
  final int timestamp;
  final User user;
  final String body;
  bool isSelf;
  String imgUrl;
  String videoUrl;
  String videoPoster;
  String audioUrl;
  int audioTime;
  
  Bubble.init(this.type,this.timestamp,this.user,this.body)
  :isSelf = _getIsSelf(user);

  Bubble.audio(this.type,this.timestamp,this.user,this.body,this.audioTime,this.audioUrl)
  :isSelf = _getIsSelf(user);

  Bubble.video(this.type,this.timestamp,this.user,this.body,this.videoUrl,this.videoPoster)
  :isSelf = _getIsSelf(user);

  static bool _getIsSelf(User user){
    return true;
  }
}