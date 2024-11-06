import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:socyet_pro/enums/campo_enum.dart';
import 'package:socyet_pro/models/arena_model.dart';
import 'package:socyet_pro/models/campo_model.dart';
import 'package:socyet_pro/models/login_model.dart';
import 'package:socyet_pro/screens/login_screen.dart';
import 'package:socyet_pro/services/arena_service.dart';
import 'package:socyet_pro/services/login_service.dart';
import 'package:http/http.dart' as http;

class MockArenaService extends Mock implements ArenaService {}
class HttpClientMock extends Mock implements http.Client {}
class MockLoginService extends Mock implements LoginService {}

void main() {
  final mockLoginService = MockLoginService();
  late HttpClientMock httpClientMock;
  late ArenaService arenaService;
  late String url;
  
  setUpAll(() {
    url = 'http://localhost:3000/arena';
    httpClientMock = HttpClientMock();
    arenaService = ArenaService(client: httpClientMock);
    registerFallbackValue(Uri.parse(url));
  });

  test("criação de arena - Unitário", () {
    ArenaModel arena = ArenaModel(
        nome: "Sumare Socyet",
        cnpj: "132.132.123/0001-20",
        telefone: "(44) 99173-8254");
    arena.campos.add(CampoModel(campo: Categoria.amador));

    expect(arena.campos.length, 1);
    expect(arena.nome, "Sumare Socyet");
    expect(arena.cnpj, "132.132.123/0001-20");
    expect(arena.telefone, "(44) 99173-8254");
  });

  test("criação de usuário de login - Unitário", () {
    LoginModel login =
        LoginModel(email: "felipecesar005@gmail.com", pwd: "fefe123");

    expect(login.email, "felipecesar005@gmail.com");
    expect(login.pwd, "fefe123");
  });

   test('deve validar o método GET e retornar uma lista de arenas - Mocktail com HTTP', () async {
    when(() => httpClientMock.get(Uri.parse(url))).thenAnswer(
      (_) async => http.Response(
        jsonEncode([
          {
            'id': '1',
            'nome': 'Arena Socyet',
            'cnpj': '12345678000199',
            'telefone': '(44) 99999-9999',
            'campos': []
          },
          {
            'id': '2',
            'nome': 'Arena Pro',
            'cnpj': '98765432000111',
            'telefone': '(44) 88888-8888',
            'campos': []
          },
        ]),
        200,
      ),
    );

    var result = await arenaService.getAll();

    expect(result, isA<List<ArenaModel>>());
    expect(result.length, 2);
    expect(result[0].nome, 'Arena Socyet');
    expect(result[1].cnpj, '98765432000111');

    verify(() => httpClientMock.get(Uri.parse(url))).called(1);
  });

  test("criação de arena - Mocktail", () async {
    final mockArenaService = MockArenaService();

    ArenaModel arenaMock = ArenaModel(
        nome: "Sumare Socyet",
        cnpj: "132.132.123/0001-20",
        telefone: "(44) 99173-8254");
    arenaMock.campos.add(CampoModel(campo: Categoria.amador));

    final fakeId = "123";

    when(() => mockArenaService.post(arenaMock))
        .thenAnswer((_) async => {'id': fakeId});

    when(() => mockArenaService.getById(fakeId))
        .thenAnswer((_) async => arenaMock);

    final response = await mockArenaService.post(arenaMock);
    final id = response['id'];

    ArenaModel arenaBack = await mockArenaService.getById(id);

    expect(arenaBack.nome, arenaMock.nome);
    expect(arenaBack.cnpj, arenaMock.cnpj);
    expect(arenaBack.telefone, arenaMock.telefone);
    expect(arenaBack.campos.length, 1);
    expect(id, fakeId);
    verify(() => mockArenaService.post(arenaMock)).called(1);
    verify(() => mockArenaService.getById(fakeId)).called(1);
  });

  test("criação de usuário de login - Mocktail", () {
    final mockLoginService = MockLoginService();

    LoginModel loginModel =
        LoginModel(email: "felipecesar005@gmail.com", pwd: "fefe123");

    final fakeId = "123";

    when(() => mockLoginService.update(fakeId, loginModel)).thenAnswer(
        (_) async =>
            {"status": 202, "message": "Atualização feita com sucesso!"});

    when(() => mockLoginService.delete(fakeId)).thenAnswer(
        (_) async => {"status": 204, "message": "Exclusão feita com sucesso!"});

    mockLoginService.update(fakeId, loginModel).then((response) {
      expect(response["status"], 202);
      expect(response["message"], "Atualização feita com sucesso!");
    });

    mockLoginService.delete(fakeId).then((response) {
      expect(response["status"], 204);
      expect(response["message"], "Exclusão feita com sucesso!");
    });

    verify(() => mockLoginService.update(fakeId, loginModel)).called(1);
    verify(() => mockLoginService.delete(fakeId)).called(1);
  });

  testWidgets('Renderização inicial da tela de login',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (_) => LoginModel.vazio(),
          child: const Login(),
        ),
      ),
    );

    expect(find.text('SocyetPro'), findsOneWidget);
    expect(find.text('Bem-vindo ao SocyetPro!'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('Validação do campo de e-mail vazio',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (_) => LoginModel.vazio(),
          child: const Login(),
        ),
      ),
    );

    await tester.enterText(find.byType(TextField).first, '');
    await tester.enterText(find.byType(TextField).last, 'senha123');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(find.text('O e-mail não pode ser vazio'), findsOneWidget);
  });

  testWidgets('Validação do campo de senha vazio', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (_) => LoginModel.vazio(),
          child: const Login(),
        ),
      ),
    );

    await tester.enterText(find.byType(TextField).first, 'usuario@teste.com');
    await tester.enterText(find.byType(TextField).last, '');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(find.text('A senha não pode ser vazia'), findsOneWidget);
  });
}
