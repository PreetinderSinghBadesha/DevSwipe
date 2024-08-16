class ProjectModel {
  String userId;
  List<String> lang;
  String? description;
  DateTime startDate;
  DateTime? closingDate;
  int members;
  String issuer;
  String projectName;
  String? githubLink;
  String imageUrl;
  int likes;
  String? readme;

  ProjectModel({
    required this.userId,
    required this.lang,
    this.description,
    required this.startDate,
    this.closingDate,
    this.members = 1,
    required this.issuer,
    required this.projectName,
    this.githubLink,
    required this.imageUrl,
    this.likes = 0,
    this.readme,
  });

  ProjectModel.fromJson(Map<String, Object?> json)
      : userId = json['userId'] as String,
        lang = (json['lang'] as List<dynamic>).map((e) => e as String).toList(),
        description = json['description'] as String?,
        startDate = DateTime.parse(json['startDate'] as String),
        closingDate = json['closingDate'] != null
            ? DateTime.parse(json['closingDate'] as String)
            : null,
        members = json['members'] as int? ?? 1,
        issuer = json['issuer'] as String,
        projectName = json['projectName'] as String,
        githubLink = json['githubLink'] as String?,
        imageUrl = json['imageUrl'] as String,
        likes = json['likes'] as int? ?? 0,
        readme = json['readme'] as String?;

  Map<String, Object?> toJson() {
    return {
      'userId': userId,
      'lang': lang,
      'description': description,
      'startDate': startDate.toIso8601String(),
      'closingDate': closingDate?.toIso8601String(),
      'members': members,
      'issuer': issuer,
      'projectName': projectName,
      'githubLink': githubLink,
      'imageUrl': imageUrl,
      'likes': likes,
      'readme': readme,
    };
  }
}
