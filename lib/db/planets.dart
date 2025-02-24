class Planets{
  //const String sql = """
  //    create table planets(
  //    id integer primary key autoincrement not null,
  //    name as text not null,
  //    sunDistance real not null,
  //    radio real not null,
  //    moons integer not null
  //    )
  // """;

  int? id, moons;
  String? name;
  double? sunDistance, radio;

  Planets(this.id, this.name, this.sunDistance, this.radio, this.moons);

  Planets.deMap(Map<String, dynamic> map){
    id = map["id"];
    moons = map["moons"];
    name = map["name"];
    sunDistance = map["sunDistance"];
    radio = map["radio"];
  }
  Map<String, dynamic> toMap(){
    return{
      "id":id,
      "name":name,
      "sunDistance":sunDistance,
      "radio":radio,
      "moons":moons
    };
  }
}