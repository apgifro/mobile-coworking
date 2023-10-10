import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conta'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 10, 18, 5),
            child: Container(
              height: 70,
              child: TextFormField(
                initialValue: FirebaseAuth.instance.currentUser?.email,
                enabled: false,
                decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.account_circle)),
              ),
            ),
          ),
          GestureDetector(
            child: Container(
              height: 45,
              padding: const EdgeInsets.fromLTRB(20, 0, 18, 0),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.logout),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Sair',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                  Icon(Icons.chevron_right),
                ],
              ),
            ),
            onTap: () {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Deseja sair?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () {
                        try {
                          FirebaseAuth.instance.signOut();
                          Get.showSnackbar(
                            const GetSnackBar(
                              title: 'Sair',
                              message: 'Você saiu',
                              duration: Duration(seconds: 3),
                            ),
                          );
                          Get.offNamed('/login');
                        } catch (e) {
                          Get.showSnackbar(
                            const GetSnackBar(
                              title: 'Sair',
                              message: 'Erro ao sair',
                              duration: Duration(seconds: 3),
                            ),
                          );
                        }
                      },
                      child: const Text('Sair',
                          style: TextStyle(color: Colors.redAccent)),
                    ),
                  ],
                ),
              );
            },
          ),
          GestureDetector(
            child: Container(
              height: 45,
              padding: const EdgeInsets.fromLTRB(20, 0, 18, 0),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.delete_outline,
                        color: Colors.redAccent,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Excluir',
                          style:
                              TextStyle(fontSize: 15, color: Colors.redAccent),
                        ),
                      ),
                    ],
                  ),
                  Icon(Icons.chevron_right),
                ],
              ),
            ),
            onTap: () {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text(
                    'Excluir sua conta?',
                  ),
                  content: const Text('Essa ação não pode ser desfeita.'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () {
                        try {
                          FirebaseAuth.instance.currentUser?.delete();
                          Get.showSnackbar(
                            const GetSnackBar(
                              title: 'Excluir conta',
                              message: 'Sua conta foi excluída',
                              duration: Duration(seconds: 3),
                            ),
                          );
                          Get.offNamed('/login');
                        } catch (e) {
                          Get.showSnackbar(
                            const GetSnackBar(
                              title: 'Excluir conta',
                              message: 'Erro ao excluir',
                              duration: Duration(seconds: 3),
                            ),
                          );
                        }
                      },
                      child: const Text('Excluir',
                          style: TextStyle(color: Colors.redAccent)),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
