import 'package:desafio_github/app/pages/usuarios/repositories/github_repository.dart';
import 'package:desafio_github/app/pages/usuarios/usuarios_bloc.dart';
import 'package:desafio_github/app/pages/usuarios/usuarios_page.dart';
import 'package:desafio_github/app/pages/usuarios/widgets/card_github/card_github_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

class UsuariosModule extends ChildModule {
  static Inject get to => Inject<UsuariosModule>.of();

  @override
  List<Bind> get binds => [
        Bind((i) => CardGithubBloc()),
        Bind((i) => UsuariosBloc(i.get())),
        Bind((i) => GithubRepository(i.get())),
        Bind((i) => Dio()),
      ];

  @override
  List<Router> get routers => [
        Router("/", child: (context, args) => UsuariosPage()),
      ];
}
