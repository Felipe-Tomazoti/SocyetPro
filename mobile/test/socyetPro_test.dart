import 'package:flutter_test/flutter_test.dart';
import 'package:socyet_pro/enums/campo_enum.dart';
import 'package:socyet_pro/models/arena_model.dart';
import 'package:socyet_pro/models/campo_model.dart';
import 'package:socyet_pro/models/login_model.dart';
import 'package:socyet_pro/services/arena_service.dart';
import 'package:socyet_pro/services/login_service.dart';

void main() {
  test("criação de arena", () {
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

  test("criação de usuário de login", () {
    LoginModel login =
        LoginModel(email: "felipecesar005@gmail.com", pwd: "fefe123");

    expect(login.email, "felipecesar005@gmail.com");
    expect(login.pwd, "fefe123");
  });

  test("criação de arena com json-server", () async {
    ArenaService arenaService = ArenaService();
    ArenaModel arenaMock = ArenaModel(
        nome: "Sumare Socyet",
        cnpj: "132.132.123/0001-20",
        telefone: "(44) 99173-8254");
    arenaMock.campos.add(CampoModel(campo: Categoria.amador));
    final response = await arenaService.post(arenaMock);
    final id = response['id'];
    ArenaModel arenaBack = await arenaService.getById(id);

    expect(arenaBack.nome, arenaMock.nome);
    expect(arenaBack.cnpj, arenaMock.cnpj);
    expect(arenaBack.telefone, arenaMock.telefone);
    expect(arenaBack.campos.length, 1);
  });

  test("criação de usuário de login com json-server", () {
    LoginService loginService = LoginService();
  });
}
