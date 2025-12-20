class Urls {
  static const String _baseUrl = 'http://35.73.30.144:2005/api/v1';
  static String registrationUrl = '$_baseUrl/Registration';
  static String loginUrl = '$_baseUrl/Login';
  static String createTask = '$_baseUrl/createTask';
  static String taskStatusCount = '$_baseUrl/taskStatusCount';
  static String taskListUrl(String status) => '$_baseUrl/listTaskByStatus/$status';
 
  static String changeStatus(String taskId,String status) => '$_baseUrl/updateTaskStatus/$taskId/$status';
  static String deleteUrl(String taskId) => '$_baseUrl/deleteTask/$taskId';
}