import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_ecommerce_app/core/routes/app_routes.dart';
import 'package:mini_ecommerce_app/features/auth/log_in/logic/cubit/login_cubit.dart';
import 'package:mini_ecommerce_app/features/auth/log_in/logic/state/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _validationMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context, LoginState state) {
    if (state is LoginLoading) {
      return;
    }

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final validationMessage = _validationMessageFor(email, password);

    if (validationMessage != null) {
      setState(() => _validationMessage = validationMessage);
      return;
    }

    if (_validationMessage != null) {
      setState(() => _validationMessage = null);
    }

    context.read<LoginCubit>().login(email: email, password: password);
  }

  String? _validationMessageFor(String email, String password) {
    if (email.isEmpty && password.isEmpty) {
      return 'Email and password are required';
    }
    if (email.isEmpty) {
      return 'Email is required';
    }
    if (password.isEmpty) {
      return 'Password is required';
    }
    return null;
  }

  void _onStateChanged(BuildContext context, LoginState state) {
    switch (state) {
      case LoginSuccess():
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login successful')),
        );
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      case LoginError(:final message):
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      case LoginInitial():
      case LoginLoading():
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (_) => LoginCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Login')),
        body: BlocConsumer<LoginCubit, LoginState>(
          listener: _onStateChanged,
          builder: (context, state) {
            final isLoading = state is LoginLoading;

            return SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(labelText: 'Email'),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(labelText: 'Password'),
                      onSubmitted: isLoading
                          ? null
                          : (_) => _submit(context, state),
                    ),
                    if (_validationMessage != null) ...[
                      const SizedBox(height: 12),
                      Text(
                        _validationMessage!,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.error,
                        ),
                      ),
                    ],
                    const SizedBox(height: 24),
                    FilledButton(
                      onPressed: isLoading
                          ? null
                          : () => _submit(context, state),
                      child: isLoading
                          ? SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: theme.colorScheme.primary,
                              ),
                            )
                          : const Text('Login'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
