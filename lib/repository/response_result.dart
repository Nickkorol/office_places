import 'package:sqflite/sqflite.dart';

class ResponseResult<T> {
  ResponseResult._();

  factory ResponseResult.success(T data) = Success<T>;
  factory ResponseResult.dbError(DatabaseException error) = DBError<T>;
}

class Success<T> extends ResponseResult<T> {
  final T data;
  Success(this.data) : super._();
}

class DBError<T> extends ResponseResult<T> {
  final DatabaseException error;
  DBError(this.error) : super._();

  int? getErrorMessage() {
    return error.getResultCode();
  }
}
