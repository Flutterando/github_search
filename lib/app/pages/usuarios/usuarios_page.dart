import 'package:desafio_github/app/pages/usuarios/usuarios_module.dart';
import 'package:desafio_github/app/pages/usuarios/widgets/card_github/card_github_widget.dart';
import 'package:desafio_github/app/shared/componenents/button_animation/button_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:select_dialog/select_dialog.dart';

import 'models/github_list_model.dart';
import 'models/github_model.dart';
import 'usuarios_bloc.dart';

class UsuariosPage extends StatefulWidget {
  final String title;
  const UsuariosPage({Key key, this.title = "Usuarios"}) : super(key: key);

  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> with ButtonAnimation {
  UsuariosBloc bloc = UsuariosModule.to.get<UsuariosBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder<List<GithubModel>>(
          stream: bloc.usuarios$.stream,
          builder: (context, snapshot) {
            return ListView.separated(
              padding: EdgeInsets.only(top: 60),
              controller: scrollController,
              itemCount: snapshot?.data?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return CardGithubWidget(
                  hideButtom: () => hideButtom(),
                  showButtom: () => showButtom(),
                  githubModel: snapshot.data.reversed.elementAt(index),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 0,
                );
              },
              // children: <Widget>[
              // Column(
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Row(
              //         children: [
              //           Expanded(
              //             child: TextField(
              //               controller: bloc.textController,
              //               decoration: InputDecoration(
              //                   fillColor: Colors.grey.withOpacity(.2),
              //                   filled: true,
              //                   border: InputBorder.none),
              //             ),
              //           ),
              //           SizedBox(
              //             width: 10,
              //           ),
              //           RaisedButton(
              //             color: Theme.of(context).primaryColor,
              //             child: Icon(
              //               Icons.add,
              //               color: Colors.white,
              //             ),
              //             onPressed: () {},
              //           )
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
              // ],
            );
          }),
    );
  }

  @override
  void onAddButtomTap() async {
    hideButtom();
    await SelectDialog.showModal<GithubListModel>(
      context,
      onFind: (searchText) async {
        if (searchText == null || searchText == "") searchText = "a";
        return await bloc.searchGithub(searchText);
      },
      itemBuilder: (_, item, isSelected) {
        return ListTile(
          title: Text(item.login),
          subtitle: Text(item.gistsUrl),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(item.avatarUrl),
          ),
        );
      },
      onChange: (user) {
        bloc.addUser(user);
      },
    );

    showButtom();
  }
}
