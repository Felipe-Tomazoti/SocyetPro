import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:socyet_pro/enums/campo_enum.dart';
import 'package:socyet_pro/models/arena_model.dart';
import 'package:socyet_pro/models/campo_model.dart';
import 'package:socyet_pro/models/login_model.dart';
import 'package:socyet_pro/services/arena_service.dart';
import 'package:socyet_pro/services/login_service.dart';

class MockArenaService extends Mock implements ArenaService {}

class MockLoginService extends Mock implements LoginService {}

void main() {
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
}
