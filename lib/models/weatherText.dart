class WeatherText {
  String? main;
  String? description;
  String? icon;
  

  WeatherText({this.main, this.description, this.icon});

  // receiving data from server
  factory WeatherText.fromMap(map) {
    return WeatherText(
      main: map['main'],
      description: map['description'],
      icon: map['icon'],
    );
  }

factory WeatherText.fromJson( Map<String, dynamic> json) => WeatherText(
    main: json['main'],
    description: json['description'],
    icon: json['icon'],
  );
 
  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'main': main,
      'description': description,
      'icon': icon,
    };
    
  }
  Map<String, dynamic> toJson() => {
    "main": main,
    'description': description,
    "icon": icon,
  };
}