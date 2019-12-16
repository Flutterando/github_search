import 'package:desafio_github/app/pages/dados_perfil/repositories/dados_perfil_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'dados_perfil_bloc.dart';
import 'dados_perfil_page.dart';

class DadosPerfilModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => DadosPerfilBloc(i.params["model"], i.get())),
        Bind((i) => DadosPerfilRepository(i.get())),
        Bind((i) => Dio()),
      ];

  static Inject get to => Inject<DadosPerfilModule>.of();

  @override
  List<Router> get routers => [
        Router(
          "/",
          child: (context, args) => DadosPerfilPage(model: args.data),
          transition: TransitionType.rotate,
        ),
      ];
}
