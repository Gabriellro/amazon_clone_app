import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../exceptions/_export_exceptions.dart';
import '../providers/_export_providers.dart';

enum AuthMode { singIn, singUp }

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  AuthMode _authMode = AuthMode.singIn;
  bool _isLoading = false;

  // ignore: prefer_final_fields
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  bool _isSingIn() => _authMode == AuthMode.singIn;
  bool _isSingUp() => _authMode == AuthMode.singUp;

  void _switchAuthMode() {
    setState(() => _isSingIn()
        ? _authMode = AuthMode.singUp
        : _authMode = AuthMode.singIn);
  }

  void _showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          'Ocorreu um Erro',
          style: TextStyle(color: Colors.black),
        ),
        content: Text(
          msg,
          style: const TextStyle(color: Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  Future<void> _submitForm() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    setState(() => _isLoading = true);

    _formKey.currentState?.save();

    AuthProvider authProvider = Provider.of(context, listen: false);

    try {
      if (_isSingIn()) {
        await authProvider.singIn(
          _authData['email']!,
          _authData['password']!,
        );
      } else {
        await authProvider.singUp(
          _authData['email']!,
          _authData['password']!,
        );
      }
    } on AuthException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog('Ocorreu um erro inesperado!');
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _isSingIn() ? "Fazer login" : "Criar conta",
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  label: Text("Email ou numero de telefone celular"),
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (_email) {
                  final email = _email ?? '';
                  return email.trim().isEmpty || !email.contains('@')
                      ? 'Informe um email valido!'
                      : null;
                },
                onSaved: (email) => _authData['email'] = email ?? '',
              ),
              SizedBox(height: size.height * 0.02),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: "Senha",
                  hintText: 'Pelo menos 6 caracteres',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                validator: (_password) {
                  final password = _password ?? '';
                  return password.isEmpty || password.length < 6
                      ? 'Informe uma senha valida!'
                      : null;
                },
                onSaved: (password) => _authData['password'] = password ?? '',
              ),
              SizedBox(height: size.height * 0.02),
              if (_isSingUp())
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text("Confirmar Senha"),
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  validator: _isSingIn()
                      ? null
                      : (_confirmPassoword) {
                          final passoword = _confirmPassoword ?? '';
                          return passoword != _passwordController.text
                              ? 'Senhas informadas não conferem!'
                              : null;
                        },
                ),
              SizedBox(height: size.height * 0.02),
              Center(
                child: _isLoading == true
                    ? const CircularProgressIndicator()
                    : SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 36,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.amber[700],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () => _submitForm(),
                          child: Text(
                            _authMode == AuthMode.singIn
                                ? "Continuar"
                                : "Registrar",
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
              ),
            ],
          ),
          Column(
            children: [
              const Text(
                "Ao continuar, você concorda com as Condições de Uso da Amazon. Por favor verifique a Notificação de Privacidade, Notificação de Cookies e a Notificação de Anúncios Baseados em Interesse.",
              ),
              SizedBox(height: size.height * 0.03),
              Row(
                children: [
                  const Expanded(child: Divider()),
                  const SizedBox(width: 10),
                  Text(_isSingIn()
                      ? 'Novo na Amazon?'
                      : "Você já tem uma conta?"),
                  const SizedBox(width: 10),
                  const Expanded(child: Divider()),
                ],
              ),
              SizedBox(height: size.height * 0.03),
              Center(
                child: SizedBox(
                  width: size.width,
                  height: 36,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () => _switchAuthMode(),
                    child: Text(
                      _isSingIn() ? "Criar sua conta da Amazon" : "Fazer login",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
