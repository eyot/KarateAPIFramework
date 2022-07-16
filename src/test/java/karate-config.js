function fn() {
  karate.configure('connectTimeout', 5000);
  karate.configure('readTimeout', 5000);
  var config = { baseUrl: 'https://reqres.in/api/'};
  return config;
}