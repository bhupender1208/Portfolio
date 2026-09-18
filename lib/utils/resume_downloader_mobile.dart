import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio/utils/app_links.dart';

Future<void> downloadResume(String url) async {
  final uri = Uri.parse(AppLinks.resumeOnline);

  final success = await launchUrl(
    uri,
    mode: LaunchMode.externalApplication,
  );

  if (!success) {
    throw Exception('Could not open resume');
  }
}