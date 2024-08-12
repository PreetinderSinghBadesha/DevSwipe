class UserModel {
  String github;
  String linkedin;

  UserModel({
    required this.github,
    required this.linkedin,
  });

  UserModel.fromJson(Map<String, Object?> json)
      : this(
          
          github: json["Github"]! as String,
          linkedin: json["Linkedin"]! as String,
        );

  Map<String, Object?> toJson() {
    return {
      'Github': github,
      'Linkedin': linkedin,
    };
  }
}