import 'package:flutter_modular/flutter_modular.dart';
import 'package:desafio_github/app/pages/dados_perfil/models/repos_model.dart';
import 'package:dio/dio.dart';

class DadosPerfilRepository extends Disposable {
  final Dio client;

  DadosPerfilRepository(this.client);

  Future getDadosPerfil(String url) async {
    final response = await client.get(url);
    return (response.data as List).map((data) => RepoModel.fromJson(data)).toList();
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
