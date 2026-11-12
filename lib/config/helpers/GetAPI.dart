import 'package:dio/dio.dart';
import 'package:yes_no_app/domain/entities/message.dart';
import 'package:yes_no_app/infrastructure/models/yes-no-model.dart';

class GetYesNoAnswer {
  final _dio = Dio();

  Future<Message> getAnswer() async {
    final response = await _dio.get('https://yesno.wtf/api');

    final converterModel = YesNoModel.fromJson(response.data);

    return converterModel.toMessageEntity();
  }

  Message mapperObjectToHerMessage(YesNoModel converterModel) {
    return Message(
      text: converterModel.answer,
      fromWho: FromWho.hers,
      imageUrl: converterModel.image,
    );
  }
}
