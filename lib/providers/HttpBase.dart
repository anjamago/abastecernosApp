import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';


class HttpBase {
  http.Client client = new http.Client();
  String pathApi;

  HttpBase() {
    this.pathApi = 'https://abastecernosapi.humc.co/api/';
  }

  Future postApi(String uri, dynamic data) async {
    final header = {
      'Accept': 'application/json',
      'Content-type': 'application/json',
    };

    http.Response response = await client.post(
      '${this.pathApi}$uri',
      headers: header,
      body: json.encode(data),
    );

    return response;
  }

/*   Future postFronDataApi(
      String uri, data, Map<String, String> errors, String tk) async {
    var request =
        new http.MultipartRequest("POST", Uri.parse('${this.pathApi}$uri'));
    request.headers['Authorization'] = 'Bearer $tk';

    request.fields['id'] = data['id'];
    request.fields['name'] = data['name'];
    request.fields['last_name'] = data['last_name'];
    request.fields['addres'] = data['addres'];
    request.fields['password'] = data['password'];
    request.fields['confir_password'] = data['confir_password'];
    request.fields['number'] = data['number'];
    request.fields['sex'] = data['sex'];
    request.fields['birthdate'] = data['birthdate'];

    try {
      final streamedResponse = await request.send();

      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode != 200) {
        return null;
      }
      final Map<String, dynamic> responseData = json.decode(response.body);

      return responseData;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future postApiForm(String uri, Map<String, dynamic> data, String tk) async {
    var request =
        new http.MultipartRequest("POST", Uri.parse('${this.pathApi}$uri'));
    request.headers['Authorization'] = 'Bearer $tk';
    final file = data['file'];
    data['file'] = data['file'].path.toString();
    request.fields['id_qr'] = data['id_qr'].toString();
    request.fields['radicado'] = data['radicado'];
    request.fields['mensaje'] = json.encode(data);
    request.fields['formulario'] = 'true';
    request.fields['anonimo'] = '0';

    final mimeTypeData =
        lookupMimeType(file.path, headerBytes: [0xFF, 0xD8]).split('/');
    final itemFile = await http.MultipartFile.fromPath(
      'file',
      file.path,
      contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
    );
    request.files.add(itemFile);

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode != 200) {
        return null;
      }
      final List<dynamic> responseData = json.decode(response.body);
      return responseData;
    } catch (e) {
      return null;
    }
  }
 */
  Future<http.Response> getApi(String uri) async {
    
    http.Response response = await client.get(
      '${this.pathApi}$uri',
    );

    return  response;
  }
}
