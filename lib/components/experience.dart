import 'package:flutter/material.dart';

class Experience extends StatelessWidget {
  const Experience({super.key});

  static const List<_ExperienceData> _experiences = [
    _ExperienceData(
      title: "Flutter Developer Training",
      organization: "Chetu India Pvt. Ltd.",
      duration: "4 Months (Jan 2026 - Apr 2026)",
      type: "Training",
      description:
          "Completed practical training in mobile application development "
          "with hands-on experience in building responsive applications, "
          "working with APIs, databases and modern development tools.",
      skills: [
        "Flutter",
        "Dart",
        "Firebase",
        "REST APIs",
        "Git",
      ],
      icon: Icons.phone_android_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 700;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 60,
        vertical: 90,
      ),
      child: Column(
        children: [
          _buildHeading(context),

          const SizedBox(height: 55),

          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 1000,
            ),
            child: Column(
              children: _experiences.map((experience) {
                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: 24,
                  ),
                  child: _ExperienceCard(
                    experience: experience,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeading(BuildContext context) {
    return Column(
      children: [
        Text(
          "PRACTICAL EXPERIENCE",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 13,
            fontWeight: FontWeight.w700,
            letterSpacing: 2,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          "Training & Experience",
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),

        const SizedBox(height: 12),

        ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 680,
          ),
          child: Text(
            "Practical learning and hands-on development experience "
            "that helped me strengthen my mobile application "
            "development skills.",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(
                  height: 1.6,
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.65),
                ),
          ),
        ),
      ],
    );
  }
}

class _ExperienceData {
  final String title;
  final String organization;
  final String duration;
  final String type;
  final String description;
  final List<String> skills;
  final IconData icon;

  const _ExperienceData({
    required this.title,
    required this.organization,
    required this.duration,
    required this.type,
    required this.description,
    required this.skills,
    required this.icon,
  });
}

class _ExperienceCard extends StatefulWidget {
  final _ExperienceData experience;

  const _ExperienceCard({
    required this.experience,
  });

  @override
  State<_ExperienceCard> createState() =>
      _ExperienceCardState();
}

class _ExperienceCardState extends State<_ExperienceCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 700;

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
        transform: Matrix4.translationValues(
          0,
          _isHovering ? -5 : 0,
          0,
        ),
        padding: EdgeInsets.all(
          isMobile ? 22 : 30,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isHovering
                ? primary.withValues(alpha: 0.40)
                : Theme.of(context)
                    .dividerColor
                    .withValues(alpha: 0.22),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(
                alpha: _isHovering ? 0.09 : 0.04,
              ),
              blurRadius: _isHovering ? 25 : 12,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: isMobile
            ? _buildMobileContent(context, primary)
            : _buildDesktopContent(context, primary),
      ),
    );
  }

  Widget _buildDesktopContent(
    BuildContext context,
    Color primary,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildIcon(primary),

        const SizedBox(width: 28),

        Expanded(
          child: _buildInformation(
            context,
            primary,
          ),
        ),
      ],
    );
  }

  Widget _buildMobileContent(
    BuildContext context,
    Color primary,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildIcon(primary),

        const SizedBox(height: 20),

        _buildInformation(
          context,
          primary,
        ),
      ],
    );
  }

  Widget _buildIcon(Color primary) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: primary.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(
        widget.experience.icon,
        color: primary,
        size: 28,
      ),
    );
  }

  Widget _buildInformation(
    BuildContext context,
    Color primary,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 10,
          runSpacing: 10,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: primary.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                widget.experience.type,
                style: TextStyle(
                  color: primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            Text(
              widget.experience.duration,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.55),
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),

        const SizedBox(height: 15),

        Text(
          widget.experience.title,
          style:
              Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
        ),

        const SizedBox(height: 8),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.business_outlined,
              size: 18,
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.55),
            ),

            const SizedBox(width: 7),

            Expanded(
              child: Text(
                widget.experience.organization,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.65),
                    ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 18),

        Text(
          widget.experience.description,
          style:
              Theme.of(context).textTheme.bodyMedium?.copyWith(
                    height: 1.7,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.65),
                  ),
        ),

        const SizedBox(height: 20),

        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: widget.experience.skills.map((skill) {
            return _SkillBadge(
              title: skill,
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _SkillBadge extends StatelessWidget {
  final String title;

  const _SkillBadge({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 11,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: primary.withValues(alpha: 0.15),
        ),
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