import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio/utils/app_links.dart';

class Contact extends StatelessWidget {
  const Contact({super.key});

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);

    if (!await launchUrl(uri, mode: LaunchMode.platformDefault)) {
      debugPrint("Could not launch $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 700;
    final primary = Theme.of(context).colorScheme.primary;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 60,
        vertical: 90,
      ),
      child: Column(
        children: [
          Text(
            "GET IN TOUCH",
            style: TextStyle(
              color: primary,
              fontSize: 13,
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            "Let's Work Together",
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
          ),

          const SizedBox(height: 14),

          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 650),
            child: Text(
              "I'm open to opportunities in Flutter and mobile application "
              "development. Feel free to reach out if you'd like to discuss "
              "an opportunity or connect.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                height: 1.7,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.65),
              ),
            ),
          ),

          const SizedBox(height: 45),

          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 950),
            child: isMobile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: _buildContactCards(context),
                  )
                : Row(
                    children: _buildContactCards(
                      context,
                    ).map((card) => Expanded(child: card)).toList(),
                  ),
          ),

          const SizedBox(height: 45),

          ElevatedButton.icon(
            onPressed: () {
              _openUrl("mailto:${AppLinks.email}?subject=Portfolio%20Contact");
            },
            icon: const Icon(Icons.send_rounded, size: 19),
            label: const Text("Send Me an Email"),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 17),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildContactCards(BuildContext context) {
    return [
      _ContactCard(
        icon: const Icon(Icons.email_outlined),
        title: "Email",
        subtitle: AppLinks.email,
        onTap: () {
          _openUrl("mailto:${AppLinks.email}");
        },
      ),

      _ContactCard(
        icon: FaIcon(FontAwesomeIcons.linkedinIn),
        title: "LinkedIn",
        subtitle: "Connect with me",
        onTap: () {
          _openUrl(AppLinks.linkedin);
        },
      ),

      _ContactCard(
        icon: FaIcon(FontAwesomeIcons.github),
        title: "GitHub",
        subtitle: "View my repositories",
        onTap: () {
          _openUrl(AppLinks.github);
        },
      ),
    ];
  }
}

class _ContactCard extends StatefulWidget {
  final Widget icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ContactCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  State<_ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<_ContactCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
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
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            transform: Matrix4.translationValues(0, _isHovering ? -5 : 0, 0),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: _isHovering
                    ? primary.withValues(alpha: 0.40)
                    : Theme.of(context).dividerColor.withValues(alpha: 0.22),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(
                    alpha: _isHovering ? 0.09 : 0.04,
                  ),
                  blurRadius: _isHovering ? 22 : 12,
                  offset: const Offset(0, 7),
                ),
              ],
            ),
            child: Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 52,
                  height: 52,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: _isHovering
                        ? primary
                        : primary.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: IconTheme(
                    data: IconThemeData(
                      color: _isHovering ? Colors.white : primary,
                      size: 23,
                    ),
                    child: Center(child: widget.icon),
                  ),
                ),

                const SizedBox(height: 16),

                Text(
                  widget.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 7),

                Text(
                  widget.subtitle,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.60),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
