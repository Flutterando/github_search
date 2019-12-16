import 'package:desafio_github/app/app_bloc.dart';
import 'package:desafio_github/app/app_widget.dart';
import 'package:desafio_github/app/pages/dados_perfil/dados_perfil_module.dart';
import 'package:desafio_github/app/pages/github_page/github_page_module.dart';
import 'package:desafio_github/app/pages/usuarios/usuarios_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends MainModule {
  static Inject get to => Inject<AppModule>.of();

  @override
  List<Bind> get binds => [
        Bind((i) => AppBloc()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  @override
  List<Router> get routers => [
        Router("/", module: UsuariosModule()),
        Router("/githubpage", module: GithubPageModule()),
        Router("/dadosperfil", module: DadosPerfilModule()),
      ];
}
