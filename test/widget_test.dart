// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:transporte_app/main.dart';

/// Testes de widget do fluxo inicial da aplicação.
void main() {
  /// Garante que a tela de login seja carregada ao iniciar o app.
  testWidgets('Exibe tela de login ao iniciar o app',
      (WidgetTester tester) async {
    await tester.pumpWidget(const TransporteApp());

    expect(find.text('ROTA'), findsOneWidget);
    expect(find.text('Entrar'), findsOneWidget);
  });
}
