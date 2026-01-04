class ApiUrls {
  static const String login = 'accounts/token/';
  static const String register = 'accounts/verification_session/';
  static const String verifyRegister = 'accounts/verification_session/';
  static const String restPassword = 'accounts/reset_password_verification/';
  static const String verifyResetPassword =
      'accounts/reset_password_verification/';
  static const String confirmResetPassword = 'accounts/reset_password/confirm/';

  // ------------- Home Api URls -------------
  static const String banner = 'config/banners/';
  static const String category = 'services/categories/';
  static const String filterProvider = 'services/service_providers/';
  static const String getAllServices = 'services/services/';
  static const String applyService = 'services/apply_service/';
  static const String ignoreService = 'services/services/';

  // ------------- Profile Api URls -------------
  static const String profile = 'accounts/profile/';
  static const String providerProfile = 'services/service_providers/';
  static const String providerProjects = 'services/service_provider_projects/';
  static const String providerRates = 'accounts/rate_user/';
  static const String updateProfile = 'accounts/profile/';
  static const String updateProfileRole = 'accounts/update_role/';

  // ------------- Service Api URls -------------
  static const String country = 'config/countries/';
  static const String city = 'config/cities/';
  static const String area = 'config/areas/';
  static const String createService = 'services/services/';
  static const String bookProvider = 'services/services/book_provider/';
  static const String meService = 'services/me/services/';
  static const String serviceApplier = 'services/apply_service/';
  static const String applierAcceptance = 'services/update_apply/';
  static const String completeService = 'services/complete_service_request/';
  static const String createProject = 'services/service_provider_projects/';
  static const String rateUser = 'accounts/rate_user/';
  static const String cancleService = 'services/me/services/';
  static const String blocUser = 'accounts/block_user/';
  static const String reportUser = 'accounts/report_user/';
  static const String addUsertoFavourite = 'accounts/favorites/';
  static const String reportResons = 'config/report_reasons/';
  static const String getTerms = 'config/terms_conditions/';
  static const String getMyRequests = 'services/complete_service_request/';
  static const String actionRequest = 'services/complete_service_request/';
  // ------------- Notification Api URls -------------
  static const String notification = 'notifications/list_notifications/';

  // ------------- Setting Api URls -------------
  static const String getReports = 'config/report_reasons/';
  static const String getBlocLists = 'accounts/block_user/';
  static const String unBlcUser = 'accounts/block_user/';
  static const String getFavLists = 'accounts/favorites/';
  static const String unFavService = 'accounts/favorites/';

  // ------------- Chat Api URls -------------
  static const String createChat = 'chat/create_room/';
  static const String getChatMessage = 'chat/room_messages/';
}
