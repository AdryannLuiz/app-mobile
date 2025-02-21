import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(MaterialApp(home: PlanetasApp(), debugShowCheckedModeBanner: false));
}

class Planeta {
  int? id;
  String nome;
  double distancia;
  double tamanho;
  String? apelido;

  Planeta({
    this.id,
    required this.nome,
    required this.distancia,
    required this.tamanho,
    this.apelido,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'distancia': distancia,
      'tamanho': tamanho,
      'apelido': apelido,
    };
  }
}

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('planetas.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE planetas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        distancia REAL NOT NULL,
        tamanho REAL NOT NULL,
        apelido TEXT
      )
    ''');
  }

  Future<int> insertPlaneta(Planeta planeta) async {
    final db = await instance.database;
    return await db.insert('planetas', planeta.toMap());
  }

  Future<List<Planeta>> fetchPlanetas() async {
    final db = await instance.database;
    final result = await db.query('planetas');
    return result
        .map(
          (json) => Planeta(
            id: json['id'] as int?,
            nome: json['nome'] as String,
            distancia: json['distancia'] as double,
            tamanho: json['tamanho'] as double,
            apelido: json['apelido'] as String?,
          ),
        )
        .toList();
  }

  Future<int> updatePlaneta(Planeta planeta) async {
    final db = await instance.database;
    return await db.update(
      'planetas',
      planeta.toMap(),
      where: 'id = ?',
      whereArgs: [planeta.id],
    );
  }

  Future<int> deletePlaneta(int id) async {
    final db = await instance.database;
    return await db.delete('planetas', where: 'id = ?', whereArgs: [id]);
  }
}

class PlanetasApp extends StatefulWidget {
  @override
  _PlanetasAppState createState() => _PlanetasAppState();
}

class _PlanetasAppState extends State<PlanetasApp> {
  late Future<List<Planeta>> planetas;

  @override
  void initState() {
    super.initState();
    planetas = DatabaseHelper.instance.fetchPlanetas();
  }

  Future<void> _refresh() async {
    final updatedPlanetas = await DatabaseHelper.instance.fetchPlanetas();
    setState(() {
      planetas = Future.value(updatedPlanetas);
    });
  }

  void _mostrarFormulario(BuildContext context, {Planeta? planeta}) {
    final nomeController = TextEditingController(text: planeta?.nome ?? '');
    final distanciaController = TextEditingController(
      text: planeta?.distancia.toString() ?? '',
    );
    final tamanhoController = TextEditingController(
      text: planeta?.tamanho.toString() ?? '',
    );
    final apelidoController = TextEditingController(
      text: planeta?.apelido ?? '',
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(planeta == null ? 'Adicionar Planeta' : 'Editar Planeta'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nomeController,
                  decoration: InputDecoration(labelText: …
[15:25, 21/02/2025] Jimmy: // lib/main.dart

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(MaterialApp(home: PlanetasApp(), debugShowCheckedModeBanner: false));
}

class Planeta {
  int? id;
  String nome;
  double distancia;
  double tamanho;
  String? apelido;

  Planeta({
    this.id,
    required this.nome,
    required this.distancia,
    required this.tamanho,
    this.apelido,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'distancia': distancia,
      'tamanho': tamanho,
      'apelido': apelido,
    };
  }
}

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelp…