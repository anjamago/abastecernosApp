import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class HttpBase {
  http.Client client = new http.Client();
  String pathApi;

  HttpBase() {
    this.pathApi = 'https://abastecernosapi.humc.co/api/';
  }

  Future postApi(String uri, dynamic data) async {
    

    http.Response response = await client.post(
      '${this.pathApi}$uri',
      body: json.encode(data),
    );
    

    return response;
  }

  Future postFile(String uri, Map<String, dynamic> data) async {
    var request =
        new http.MultipartRequest("POST", Uri.parse('${this.pathApi}$uri'));
    final file = data['photo'];
    data['photo'] = data['photo'].path.toString();
    request.fields['store_id'] = data['store_id'].toString();
    request.fields['description'] = data['description'];


    final mimeTypeData =
        lookupMimeType(file.path, headerBytes: [0xFF, 0xD8]).split('/');
    final itemFile = await http.MultipartFile.fromPath(
      'photo',
      file.path,
      contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
    );
    request.files.add(itemFile);

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      print(response.body.toString());

      if (response.statusCode != 200) {
        return null;
      }
      final List<dynamic> responseData = json.decode(response.body);
      return responseData;
    } catch (e) {
      return null;
    }
  }

  Future<http.Response> getApi(String uri) async {
    
    http.Response response = await client.get(
      '${this.pathApi}$uri',
    );

    return  response;
  }
}
