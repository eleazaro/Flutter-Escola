import 'package:flutter_escola/core/error_handling/core_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_escola/course/domain/entities/matricula_entity.dart';
import 'package:flutter_escola/course/domain/interfaces/imatricula_repository.dart';
import 'package:flutter_escola/course/error_handling/exceptions.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class MatriculaRepository implements IMatriculaRepository {
  @override
  Future<Either<CoreFailure, List<MatriculaEntity>>> getMatriculaByIdCurso(
      {required int idCurso}) async {
    final List<MatriculaEntity> matriculas = [];
    var url = Uri.http('10.0.2.2:3000', '/matricula/curso/$idCurso');

    try {
      final result = await http.get(url);
      if (result.statusCode != 200) {
        return throw GetMatriculaCursoException(StackTrace.current,
            'GetMatriculaCurso', "StatusCode: ${result.statusCode}");
      }

      var jsonResponse =
          convert.jsonDecode(result.body) as Map<String, dynamic>;
      var data = jsonResponse['data'];

      for (var matricula in data) {
        matriculas.add(MatriculaEntity.fromJson(matricula));
      }

      return Right(matriculas);
    } catch (exception, stacktrace) {
      return Left(throw GetMatriculaCursoException(
          stacktrace, 'GetMatriculaCurso', exception));
    }
  }
}