import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Interceptor{
  Interceptor();

  String? hiveToken;
  String? token;



  Future getToken() async { //function to set access tokens to default variables to be used later
    SharedPreferences pref = await SharedPreferences.getInstance(); // initiating the local storage to access data

    token = pref.getString('token'); //setting data for registration token coming from Firebase Auth for basic authentication
    hiveToken = pref.getString('access_token'); //setting hive token coming from Hivesigner for Hive operations, can also be from Keychain

  }


  Future getRequest({required String url}) async { // API skeleton to access private API's get requests
    await getToken().then((value) async{
      Dio dio = Dio(BaseOptions(headers: {
        "Authorization": "Bearer $token",
        'access-token': '$hiveToken'
      }));

      CancelToken cancel = CancelToken();

      try{
        await dio.get(url, cancelToken: cancel).then((value){
          if(value.statusCode == 200){
            return value;
          }else{
            print(value.statusCode);
          }
        });
      }catch(e){
        print(e);
      }
    });
  }

  Future postRequest({required String url, required FormData formData}) async { // Skeleton to access Private post API calls
    await getToken().then((value) async{
      Dio dio = Dio(BaseOptions(headers: {
        "Authorization": "Bearer $token",
        'access-token': '$hiveToken'
      }));

      CancelToken cancel = CancelToken();

      try{
        await dio.post(url, data: formData, cancelToken: cancel).then((value) {
          if(value.statusCode == 200){
            return value;
          }else{
            print(value.statusCode);
          }
        });
      }catch(e){
        print(e);
      }

    });
  }

}