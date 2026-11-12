import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yes_no_app/domain/entities/message.dart';
import 'package:yes_no_app/presentation/providers/chat_provider.dart';
import 'package:yes_no_app/presentation/widgets/index.dart';

class ChatScreen extends StatelessWidget {

  const ChatScreen({super.key});
  final String imgUrl = 'https://th.bing.com/th/id/OIP.jQc294WED8p75DlIKBgMNAHaE8?w=288&h=192&c=7&r=0&o=7&pid=1.7&rm=3';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.symmetric( horizontal: 10 ),
          child: CircleAvatar(
            backgroundImage: NetworkImage(imgUrl),
          )
        ),
        title: Text('Arroz Chino'),
        centerTitle: false,
      ),
      body: _ChatView()
    );
  }
}

/** 
 * Container Chat
 */
class _ChatView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final chatProvider = context.watch<ChatProvider>();

    return SafeArea(
      child: Column(
        children: [
          Expanded(child: ListView.builder(
            controller: chatProvider.chatScrollController,
            itemCount: chatProvider.messageList.length,
            itemBuilder: (context, index) {
              final message = chatProvider.messageList[index];

              return (message.fromWho == FromWho.mine)
                ?  MyMessageBubble( message: message, )
                :  HerMessageBubble( message: message );
            },
          )),
          MessageFieldBox(
            onValue: (value) => chatProvider.sendMessage(value),
            // onValue: chatProvider.sendMessage,
          )
        ],
      ),
    );
  }
}


/* Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: Center(
          child: FilledButton(
            onPressed:() {},
            child: const Text('Click Me')
          ),
        ),
      ),*/