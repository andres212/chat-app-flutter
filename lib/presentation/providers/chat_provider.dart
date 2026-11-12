import 'package:flutter/material.dart';
import 'package:yes_no_app/config/helpers/GetAPI.dart';
import 'package:yes_no_app/domain/entities/message.dart';

class ChatProvider extends ChangeNotifier {

  final ScrollController chatScrollController = ScrollController();
  final GetYesNoAnswer getYesNoAnswer = GetYesNoAnswer();

  List<Message> messageList = [];


  // Función
  Future<void> sendMessage(String text) async {

    if (text.isEmpty) return;

    if (text.endsWith('?')) {
      herReplay();
    }
    
    mineReplay(text);

    notifyListeners();
    moveScrollToBottom();
  }

  Future<void> mineReplay(String text) async {
    final newMessage = Message(text: text, fromWho: FromWho.mine);
    messageList.add(newMessage);
  }

  Future<void> herReplay() async {
    final herMessage = await getYesNoAnswer.getAnswer();

    messageList.add(herMessage);
    notifyListeners();

    moveScrollToBottom();
  }

  // Función que permite mover el scroll al final de la pantalla
  Future<void> moveScrollToBottom() async {

    await Future.delayed(Duration(milliseconds: 100));

    chatScrollController.animateTo(
      chatScrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut
    );
  }

}