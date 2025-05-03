class Apis {
  static final Apis _instance = Apis._internal();

  factory Apis() {
    return _instance;
  }

  Apis._internal();

  static String baseUrl = "https://reqres.in/api/";


}
