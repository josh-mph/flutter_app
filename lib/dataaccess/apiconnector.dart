
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiConnector {
  var baseUrl = "https://shtechno.co.za/vieta/";
  var operation = "";
  var jsonBody = "";
  SharedPreferences preference;

  ApiConnector(var operation, var jsonBody) {
    this.operation = operation;
    this.jsonBody = jsonBody;
  }

  Future<Object> postData() async {
      final response = await http.post(
        this.baseUrl+this.operation,
        headers: {"content-type": "application/json"},
        body: this.jsonBody
      );
      final responseJson = response.body;

      return responseJson;
    }
}
