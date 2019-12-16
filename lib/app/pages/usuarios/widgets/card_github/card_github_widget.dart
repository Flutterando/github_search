import 'package:desafio_github/app/pages/dados_perfil/dados_perfil_module.dart';
import 'package:desafio_github/app/pages/usuarios/models/github_model.dart';
import 'package:flutter/material.dart';

class CardGithubWidget extends StatelessWidget {
  final GithubModel githubModel;
  final Function hideButtom;
  final Function showButtom;

  const CardGithubWidget(
      {Key key, this.githubModel, this.hideButtom, this.showButtom})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Column(
        children: <Widget>[
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(githubModel.avatarUrl),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            githubModel?.name,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
          Container(
              width: MediaQuery.of(context).size.width * .7,
              child: RaisedButton(
                onPressed: () async {
                  hideButtom();
                  await Navigator.pushNamed(
                    context,
                    "/dadosperfil",
                    arguments: githubModel,
                  );
                  showButtom();
                },
                child: Text(
                  "Ver Perfil",
                  style: TextStyle(
                      color: Theme.of(context).primaryTextTheme.button.color),
                ),
                color: Theme.of(context).primaryColor,
              ))
        ],
      ),
    );
  }
}
