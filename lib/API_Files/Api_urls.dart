class ApiUrls {
  // static String base_url = "http://192.168.29.188:8090/v1/api";
  // static String base_url = "https://roamifyservices.onrender.com/v1/api";
  static String base_url = "http://35.154.251.208:8090/v1/api";
  // static String base_url = "http://192.168.164.66:8090/v1/api";
  // static String base_url = "http://172.16.9.140:8090/v1/api";
  static String login_url = "$base_url/auth/login";
  static String register_url = "$base_url/auth/signup";
  static String getuserdata_url = "$base_url/user/getuserbytoken";
  static String updateuserdata_url = "$base_url/user/update";
        
  static String explore_tour_url = "$base_url/tour/explore-tours";
  static String get_tour_cities_url = "$base_url/tour/get-cities";
  static String get_tour_images_url = "$base_url/tour/get-images";
  static String book_tour_url = "$base_url/tour/book-package";
  static String tour_members_url = "$base_url/tour/get-tour-members";
  static String tour_agent_url = "$base_url/tour/get-agent";
  static String create_tour_url = "$base_url/user/create-tour-packages";
  static String getbooked_tour_url = "$base_url/tour/get-boooked-tours";
  static String getcreated_tour_url = "$base_url/tour/get-created-tours";
  static String delete_tour_url = "$base_url/tour/delete-tours";
  static String search_tour_url = "$base_url/tour/search-tour-bycity";
}
