
import 'package:sqlflite/data/local_data_source.dart';
import 'package:sqlflite/domain/repository/todo_repository.dart';

late final TodoRepository repository;

Future<void> serviceLocator() async {
  LocalDataSource dataSource = LocalDataSourceImpl();

  repository = TodoRepositoryImpl(dataSource: dataSource);
}
