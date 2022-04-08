class WeatherModel {
  double? temp;
  double? feels_like;
  double? temp_min;
  double? temp_max;
  int? pressure;
  int? humidity;
  

  WeatherModel({this.temp, this.feels_like, this.temp_min,  this.temp_max, this.pressure, this.humidity});

  // receiving data from server
  factory WeatherModel.fromMap(map) {
    return WeatherModel(
      temp: map['temp'],
      feels_like: map['feels_like'],
      temp_min: map['temp_min'],
      temp_max: map['temp_max'],
      pressure: map['pressure'],
      humidity: map['humidity'],
    );
  }

factory WeatherModel.fromJson( Map<String, dynamic> json) => WeatherModel(
     temp :json["temp"] ,
    feels_like :json["feels_like"] ,
    temp_min :json["temp_min"] ,
    temp_max :json["temp_max"],
    pressure :json["pressure"],
    humidity :json["humidity"],
  );
 
  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'temp': temp,
      'feels_like': feels_like,
      'temp_min': temp_min,
      'temp_max': temp_max,
      'pressure': pressure,
      'humidity': humidity,
    };
    
  }
  Map<String, dynamic> toJson() => {
    "temp": temp,
    'feels_like': feels_like,
    "temp_min": temp_min,
    "temp_max": temp_max,
    "pressure": pressure,
    'humidity':humidity,
  };
}