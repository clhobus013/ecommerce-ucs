import 'dart:developer';

import 'package:ecommerce/models/Rate.dart';
import 'package:ecommerce/models/product.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const arquivoDoBancoDeDados = 'ecommerce.db';
  static const arquivoDoBancoDeDadosVersao = 1;

  static const table = 'products';
  static const columnId = 'id';
  static const columnTitle = 'title';
  static const columnPrice = 'price';
  static const columnDescription = 'description';
  static const columnCategory = 'category';
  static const columnImage = 'image';
  static const columnRatingRate = 'ratingRate';
  static const columnRatingCount = 'ratingCount';

  static late Database _bancoDeDados;

  iniciarBD() async {
    String caminhoBD = await getDatabasesPath();
    String path = join(caminhoBD, arquivoDoBancoDeDados);

    _bancoDeDados = await openDatabase(path,
        version: arquivoDoBancoDeDadosVersao, onCreate: funcaoCriacaoBD);
  }

  Future funcaoCriacaoBD(Database db, int version) async {
    await db.execute('''
        CREATE TABLE $table (
          $columnId INTEGER PRIMARY KEY,
          $columnTitle TEXT NOT NULL,
          $columnPrice REAL NOT NULL,
          $columnDescription TEXT,
          $columnCategory TEXT,
          $columnImage TEXT,
          $columnRatingRate REAL,
          $columnRatingCount INTEGER
        )
      ''');
  }

  Future<int> inserir(Map<String, dynamic> row) async {
    await iniciarBD();

    log("INSERIR BD");
    log(row.toString());

    return await _bancoDeDados.insert(table, row);
  }

  Future<int> deletarTodos() async {
    await iniciarBD();
    return _bancoDeDados.delete(table);
  }

  Future<List<Product>> getProducts() async {
    await iniciarBD();

    final List<Map<String, Object?>> pessoasNoBanco =
        await _bancoDeDados.query(table);

    return [
      for (final {
            columnId: pId as int,
            columnTitle: pTitle as String,
            columnPrice: pPrice as num,
            columnDescription: pDescription as String,
            columnCategory: pCategory as String?,
            columnImage: pImage as String,
            columnRatingRate: pRatingRate as num,
            columnRatingCount: pRatingCount as int,
          } in pessoasNoBanco)
        Product(
            id: pId,
            title: pTitle,
            price: pPrice,
            description: pDescription,
            category: pCategory,
            image: pImage,
            rating: Rate(rate: pRatingRate, count: pRatingCount)),
    ];
  }

  Future<int?> getCountProducts() async {
    await iniciarBD();

    var raw = await _bancoDeDados.rawQuery('SELECT COUNT (*) from $table');

    int? count = Sqflite.firstIntValue(raw);
    return count;
  }
}
