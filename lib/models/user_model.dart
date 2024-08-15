import 'package:jobify/models/project_model.dart';

class UserModel {
  String github;
  String linkedin;
  Map<String, ProjectModel>? projects;
  int numberProjects;
  String? readme;

  UserModel({
    required this.github,
    required this.linkedin,
    this.projects,
    this.numberProjects = 0, 
    this.readme,
  });

  UserModel.fromJson(Map<String, Object?> json)
      : github = json['Github'] as String,
        linkedin = json['Linkedin'] as String,
        projects = (json['Projects'] as Map<String, dynamic>?)?.map(
          (key, value) => MapEntry(
            key,
            ProjectModel.fromJson(value as Map<String, Object?>),
          ),
        ),
        numberProjects = json['NumberProjects'] as int? ?? 0,
        readme = json['Readme'] as String?; 

  Map<String, Object?> toJson() {
    return {
      'Github': github,
      'Linkedin': linkedin,
      'Projects': projects?.map((key, value) => MapEntry(key, value.toJson())),
      'NumberProjects': numberProjects, 
      'Readme': readme,
    };
  }
}
