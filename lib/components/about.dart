import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio/utils/app_links.dart';
import 'package:portfolio/utils/resume_downloader.dart';

class About extends StatefulWidget {
  final VoidCallback? onViewProjects;

  const About({super.key, this.onViewProjects});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  bool _isImageHovering = false;

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);

    if (!await launchUrl(uri, mode: LaunchMode.platformDefault)) {
      debugPrint("Could not launch $url");
    }
  }

  Future<void> _downloadResume() async {
    final resumeUrl = Uri.base.resolve(AppLinks.resume).toString();

    await downloadResume(resumeUrl);
  }
@override
Widget build(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  final isMobile = width < 1050;

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 650),
        padding: EdgeInsets.symmetric(
      horizontal: isMobile ? 24 : 70,
      vertical: isMobile ? 50 : 80,
    ),
      child: isMobile
          ? Column(
              children: [
                _buildProfileImage(),
                const SizedBox(height: 45),
                _buildIntroduction(context, isMobile: true),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 6,
                  child: _buildIntroduction(context, isMobile: false),
                ),

                const SizedBox(width: 60),

                Expanded(flex: 4, child: Center(child: _buildProfileImage())),
              ],
            ),
    );
  }

  Widget _buildIntroduction(BuildContext context, {required bool isMobile}) {
    final textTheme = Theme.of(context).textTheme;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 720),
      child: Column(
        crossAxisAlignment: isMobile
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              "👋 Hello, I'm",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),

          const SizedBox(height: 18),

          Text(
            "Bhupender",
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
            style: textTheme.displayMedium?.copyWith(
              fontSize: isMobile ? 42 : 58,
              fontWeight: FontWeight.w800,
              height: 1.1,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            "Flutter & Mobile App Developer",
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
            style: textTheme.headlineSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 22),

          Text(
            "I build responsive, user-friendly and scalable mobile "
            "applications using Flutter and Dart. I enjoy turning ideas "
            "into clean, functional applications and working with "
            "Firebase, REST APIs and modern mobile development tools.",
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
            style: textTheme.bodyLarge?.copyWith(
              height: 1.8,
              fontSize: 16,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.72),
            ),
          ),

          const SizedBox(height: 26),

          Wrap(
            alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
            spacing: 10,
            runSpacing: 10,
            children: const [
              _TechBadge(title: "Flutter"),
              _TechBadge(title: "Dart"),
              _TechBadge(title: "Firebase"),
              _TechBadge(title: "REST APIs"),
              _TechBadge(title: "Git"),
            ],
          ),

          const SizedBox(height: 32),

          Wrap(
            alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
            spacing: 12,
            runSpacing: 12,
            children: [
              ElevatedButton.icon(
                onPressed: widget.onViewProjects,
                icon: const Icon(Icons.visibility_outlined),
                label: const Text("View Projects"),
              ),

              OutlinedButton.icon(
                onPressed: _downloadResume,
                icon: const Icon(Icons.download_rounded),
                label: const Text("Download Resume"),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _SocialButton(
                icon: FontAwesomeIcons.github,
                tooltip: "GitHub",
                onPressed: () {
                  _openUrl(AppLinks.github);
                },
              ),

              const SizedBox(width: 12),

              _SocialButton(
                icon: FontAwesomeIcons.linkedinIn,
                tooltip: "LinkedIn",
                onPressed: () {
                  _openUrl(AppLinks.linkedin);
                },
              ),

              const SizedBox(width: 12),

              _SocialButton(
                icon: Icons.email_outlined,
                tooltip: "Email",
                onPressed: () {
                  _openUrl("mailto:bhupender00012@gmail.com");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileImage() {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isImageHovering = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isImageHovering = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.identity()
          ..scaleByDouble(
            _isImageHovering ? 1.03 : 1.0,
            _isImageHovering ? 1.03 : 1.0,
            _isImageHovering ? 1.03 : 1.0,
            1.0,
          ),
        transformAlignment: Alignment.center,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: 0.18),
              blurRadius: _isImageHovering ? 35 : 25,
              spreadRadius: 4,
            ),
          ],
        ),
        child: ClipOval(
          child: Image.asset(
            "assets/images/profile.jpeg",
            width: 280,
            height: 280,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class _TechBadge extends StatelessWidget {
  final String title;

  const _TechBadge({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.20),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.w500,
          fontSize: 13,
        ),
      ),
    );
  }
}

class _SocialButton extends StatefulWidget {
  final Object icon;
  final String tooltip;
  final VoidCallback onPressed;

  const _SocialButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            isHovering = true;
          });
        },
        onExit: (_) {
          setState(() {
            isHovering = false;
          });
        },
        child: AnimatedScale(
          scale: isHovering ? 1.12 : 1,
          duration: const Duration(milliseconds: 200),
          child: IconButton(
            onPressed: widget.onPressed,
            icon: widget.icon is FaIconData
                ? FaIcon(widget.icon as FaIconData)
                : Icon(widget.icon as IconData),
            iconSize: 22,
            style: IconButton.styleFrom(
              backgroundColor: isHovering
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.08),
              foregroundColor: isHovering
                  ? Colors.white
                  : Theme.of(context).colorScheme.primary,
              padding: const EdgeInsets.all(14),
            ),
          ),
        ),
      ),
    );
  }
}
