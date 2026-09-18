import 'package:web/web.dart' as web;

Future<void> downloadResume(String url) async { 
   final anchor = web.HTMLAnchorElement()
    ..href = url
    ..download = 'Bhupender_Flutter_Developer.pdf'
    ..style.display = 'none';

  web.document.body?.append(anchor);

  anchor.click();

  anchor.remove();
}