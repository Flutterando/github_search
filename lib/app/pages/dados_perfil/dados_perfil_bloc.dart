import 'package:flutter_modular/flutter_modular.dart';
import 'package:desafio_github/app/pages/dados_perfil/models/repos_model.dart';
import 'package:desafio_github/app/pages/dados_perfil/repositories/dados_perfil_repository.dart';
import 'package:desafio_github/app/pages/usuarios/models/github_model.dart';
import 'package:rxdart/rxdart.dart';

class DadosPerfilBloc extends Disposable {
  final GithubModel githubModel;
  final DadosPerfilRepository dadosPerfilRepository;
  DadosPerfilBloc(this.githubModel, this.dadosPerfilRepository) {
    githubModel$.add(githubModel);
    dadosPerfilRepository
        .getDadosPerfil(githubModel.reposUrl)
        .then((dadosPerfil) {
      repoModel$.add(dadosPerfil);
    });
  }

  BehaviorSubject<GithubModel> githubModel$ = BehaviorSubject<GithubModel>();

  BehaviorSubject<List<RepoModel>> repoModel$ = BehaviorSubject<List<RepoModel>>();

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    githubModel$.close();
    repoModel$.close();
  }
}
