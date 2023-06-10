
import 'package:mongo_dart/mongo_dart.dart' show Db, DbCollection;

class DBConnection {

  static String restaurantsDataBaseName = 'sample_restaurants';
  static String dataBaseName = 'sample_restaurants';
  static String mongoURL = 'mongodb://atlas-sql-647d4b35ee2b2a15c222280f-wqsst.a.query.mongodb.net/${dataBaseName}?ssl=true&authSource=admin';
  static String mongoURL2 = 'mongodb://atlas-sql-647d4b35ee2b2a15c222280f-wqsst.a.query.mongodb.net/${dataBaseName}?ssl=true&authSource=admin';
  late Db _db;

  static late DBConnection _instance = DBConnection();

  final String _getConnectionString = mongoURL;

  static getInstance(){
    return _instance;
  }

  Future<Db> getConnection() async{
    // if (_db == null){
      try {
        _db = await Db.create(_getConnectionString);
        await _db.open();
      } catch(e){
        print(e);
      }
    // }
    return _db;
  }

  closeConnection() {
    _db.close();
  }
}