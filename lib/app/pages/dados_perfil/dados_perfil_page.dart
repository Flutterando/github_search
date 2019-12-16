import 'package:desafio_github/app/pages/dados_perfil/models/repos_model.dart';
import 'package:desafio_github/app/pages/github_page/github_page_module.dart';
import 'package:desafio_github/app/pages/usuarios/models/github_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'dados_perfil_bloc.dart';
import 'dados_perfil_module.dart';

class DadosPerfilPage extends StatefulWidget {
  final GithubModel model;

  const DadosPerfilPage({Key key, this.model}) : super(key: key);

  @override
  _DadosPerfilPageState createState() => _DadosPerfilPageState();
}

class _DadosPerfilPageState extends State<DadosPerfilPage>
    with InjectMixin<DadosPerfilModule> {
  DadosPerfilBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = DadosPerfilModule.to.get({"model": widget.model});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dados Perfil"),
      ),
      body: StreamBuilder<GithubModel>(
          stream: bloc.githubModel$,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            var githubModel = snapshot.data;

            return StreamBuilder<List<RepoModel>>(
                stream: bloc.repoModel$,
                builder: (context, snapshotRepo) {
                  if (!snapshotRepo.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return ListView.separated(
                    padding: EdgeInsets.all(20),
                    itemCount: snapshotRepo.data.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      var repo = snapshotRepo.data;

                      if (index == 0) {
                        return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              SizedBox(
                                height: 30,
                              ),
                              CircleAvatar(
                                radius: 40,
                                backgroundImage:
                                    NetworkImage(githubModel.avatarUrl),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                githubModel?.name,
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                githubModel?.bio ?? "Nao informado",
                                style: TextStyle(color: Colors.black54),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                githubModel?.blog ?? "Nao informado",
                                style: TextStyle(color: Colors.black54),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                            ]);
                      }

                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            "/githubpage",
                            arguments: repo[index - 1].htmlUrl,
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .disabledColor
                                  .withOpacity(.1),
                              borderRadius: BorderRadius.circular(10)),
                          child: ListTile(
                            title: Text(repo[index - 1].name),
                            subtitle: Text(repo[index - 1].url),
                            trailing: Icon(Icons.arrow_forward_ios),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 10,
                      );
                    },
                  );
                });
          }),
    );
  }
}
