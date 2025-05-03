class AppStrings {
  static final AppStrings _instance = AppStrings._internal();

  factory AppStrings() {
    return _instance;
  }

  AppStrings._internal();

  static const userListTitle = 'User List';
  static const currentLocationTitle = 'Current Locations :';
  static const userTitle = 'User :';
  static const uploadImage = 'Upload Image';
  static const camera = 'Camera';
  static const gallery = 'Gallery';
  static const loadUsersError = 'Failed to load users. Please try again.';
  static const retry = 'Retry';
  static const address = 'Address: ';
  static const latitude = 'Latitude: ';
  static const longitude = 'Longitude: ';
}
