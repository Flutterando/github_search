import 'package:desafio_github/app/pages/github_page/github_page_bloc.dart';
import 'package:desafio_github/app/pages/github_page/github_page_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class GithubPageModule extends ChildModule {
  static Inject get to => Inject<GithubPageModule>.of();

  @override
  List<Bind> get binds => [
        Bind((i) => GithubPageBloc()),
      ];

  @override
  List<Router> get routers => [
        Router("/", child: (context, args) => GithubPagePage(args.data)),
      ];
}
