class TaskModels {
  final String id;
  final String title;
  final String description;
  final List<String> attachmentUrls;

  TaskModels({
    required this.id,
    required this.title,
    required this.description,
    required this.attachmentUrls,
  });
}
