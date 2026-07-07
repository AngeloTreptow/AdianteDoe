import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // App Check: atesta que as requisições vêm do app legítimo (Play Integrity).
  // Passos manuais pendentes (só funcionam depois de configurados no console):
  //   1. Firebase Console → App Check: registrar o app Android com o SHA-256
  //      do certificado de assinatura.
  //   2. Google Play Console → App integrity → Play Integrity API: vincular
  //      ao projeto do Firebase.
  // O enforcement (bloqueio de requisições sem token) NÃO está ativo — ele é
  // ligado por serviço no Firebase Console (App Check → APIs → Cloud
  // Firestore), e só deve ser ativado após validar as métricas no modo de
  // monitoramento. Não é configurado nas regras do Firestore.
  try {
    await FirebaseAppCheck.instance.activate(
      // Em debug o Play Integrity não atesta builds locais; usa o provider de
      // debug (o token aparece no logcat e é cadastrado no Firebase Console)
      providerAndroid: kDebugMode
          ? const AndroidDebugProvider()
          : const AndroidPlayIntegrityProvider(),
    );
  } catch (e) {
    // App Check é camada extra: se falhar, o app segue funcionando
    debugPrint('Falha ao ativar o App Check: $e');
  }

  // Login anônimo transparente: sem tela, botão ou menção de "login" na UI.
  // A sessão persiste entre aberturas do app, então o signIn só acontece na
  // primeira execução. As regras do Firestore exigem auth para denunciar.
  if (FirebaseAuth.instance.currentUser == null) {
    try {
      await FirebaseAuth.instance
          .signInAnonymously()
          // Timeout curto para não segurar a splash se a rede estiver ruim;
          // o reportItem tenta autenticar de novo quando necessário
          .timeout(const Duration(seconds: 5));
    } catch (e) {
      // Sem crash e sem bloquear o fluxo de doação: só a denúncia depende
      // de auth, e ela mostra o próprio erro se continuar sem sessão
      debugPrint('Falha no login anônimo: $e');
    }
  }

  runApp(const AdianteDoeApp());
}

class AdianteDoeApp extends StatelessWidget {
  const AdianteDoeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AdianteDoe+',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
        // Placeholders (hintText) em cinza claro: o padrão do M3 é escuro
        // demais e se confunde com o texto digitado pelo usuário
        inputDecorationTheme: InputDecorationThemeData(
          hintStyle: TextStyle(color: Colors.grey[400]),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}