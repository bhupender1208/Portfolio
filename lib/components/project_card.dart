import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/models/project_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectCard extends StatefulWidget {
  final ProjectModel project;

  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovering = false;

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);

    if (!await launchUrl(uri, mode: LaunchMode.platformDefault)) {
      debugPrint("Could not launch $url");
    }
  }

  void _showFullImage(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.85),
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(20),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              InteractiveViewer(
                minScale: 0.5,
                maxScale: 4.0,
                child: Image.asset(widget.project.image, fit: BoxFit.contain),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.black.withValues(alpha: 0.65),
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.close_rounded),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovering = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovering = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(0, _isHovering ? -7 : 0, 0),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: _isHovering
                ? primary.withValues(alpha: 0.45)
                : Theme.of(context).dividerColor.withValues(alpha: 0.20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: _isHovering ? 0.12 : 0.05),
              blurRadius: _isHovering ? 30 : 15,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProjectImage(),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(
                    MediaQuery.of(context).size.width < 400 ? 20 : 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.project.title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        widget.project.description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          height: 1.6,
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.65),
                        ),
                      ),
                      const SizedBox(height: 18),
                      Wrap(
                        spacing: 7,
                        runSpacing: 7,
                        children: widget.project.technologies.map((technology) {
                          return _TechnologyBadge(title: technology);
                        }).toList(),
                      ),
                      const Spacer(),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {
                                _openUrl(widget.project.githubUrl);
                              },
                              icon: const FaIcon(
                                FontAwesomeIcons.github,
                                size: 17,
                              ),
                              label: const Text("Code"),
                            ),
                          ),
                          if (widget.project.liveUrl != null) ...[
                            const SizedBox(width: 10),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  _openUrl(widget.project.liveUrl!);
                                },
                                icon: const Icon(
                                  Icons.open_in_new_rounded,
                                  size: 17,
                                ),
                                label: const Text("Live Demo"),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProjectImage() {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 700;

    final imageHeight = width < 400
        ? 220.0
        : width < 700
        ? 240.0
        : 260.0;

    return Container(
      height: imageHeight,
      width: double.infinity,
      color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.04),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Image.asset(widget.project.image, fit: BoxFit.contain),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              color: _isHovering
                  ? Colors.black.withValues(alpha: 0.03)
                  : Colors.transparent,
            ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    _showFullImage(context);
                  },
                  child: Center(
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: isMobile || _isHovering ? 1 : 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.70),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.zoom_in_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(width: 7),
                            Text(
                              "View Screenshot",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TechnologyBadge extends StatelessWidget {
  final String title;

  const _TechnologyBadge({required this.title});

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: primary,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
