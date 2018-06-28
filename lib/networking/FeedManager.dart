class FeedManger {
  static const String BASE_SERVICE = 'https://api.github.com/users/';
  static const String rec = "jamesoanta/received_events";


  void receivedEvents(String userName, authManager) {
    String call = 'https://api.github.com/users/${userName}/received_events';
  }

}