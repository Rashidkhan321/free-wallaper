



class AppExceptions implements Exception{


  final _message;
  final _prefix;
  AppExceptions([this._message, this._prefix]);
   String toString(){

     return '$_message $_prefix';
   }



}
class  RequestTimeout extends AppExceptions{

  RequestTimeout([String?message]):super(message,'Request time out is expired');

}
class InternetException extends AppExceptions{
  InternetException([String ? message]):super(message, 'no Internet Connection');


}
class ServerSideException extends AppExceptions{
  ServerSideException([String?message]):super(message,'The Servser is Down');

}

