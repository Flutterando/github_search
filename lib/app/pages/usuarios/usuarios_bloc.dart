import 'dart:convert';

import 'package:desafio_github/app/pages/usuarios/repositories/github_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hydrated/hydrated.dart';

import 'models/github_list_model.dart';
import 'models/github_model.dart';

class UsuariosBloc extends Disposable {
  final GithubRepository githubRepository;

  var textController = TextEditingController();

  UsuariosBloc(this.githubRepository);

  var usuarios$ = HydratedSubject<List<GithubModel>>("usuarios",
      seedValue: <GithubModel>[],
      hydrate: (String s) => s == null ? <GithubModel>[] : (json.decode(s) as List).map((item) => GithubModel.fromJson(item)).toList(),
      persist: (users) => json.encode(users.map((user) => user.toJson()).toList()));

  Future<List<GithubListModel>> searchGithub(String searchText) async {
    return await githubRepository.getListOfGithub(searchText);
  }

  Future addUser(GithubListModel user) async {
    var items = usuarios$.value;

    var usuario = await githubRepository.getUserInfos(user.login);

    items.add(usuario);
    usuarios$.add(items);
  }

  @override
  void dispose() {
    usuarios$.close();
  }
}
