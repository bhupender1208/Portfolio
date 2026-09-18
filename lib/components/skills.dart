import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Skills extends StatelessWidget {
  const Skills({super.key});

  static const List<_SkillCategory> _skillCategories = [
    _SkillCategory(
      title: "Mobile Development",
      icon: Icons.phone_android_rounded,
      skills: ["Flutter", "Dart", "Responsive UI", "Material UI"],
    ),
    _SkillCategory(
      title: "State Management",
      icon: Icons.account_tree_outlined,
      skills: ["Provider", "GetX", "setState", "BLoC / Cubit"],
    ),
    _SkillCategory(
      title: "Backend & Database",
      icon: Icons.storage_rounded,
      skills: ["Firebase", "Cloud Firestore", "SharedPreferences", "REST APIs"],
    ),
    _SkillCategory(
      title: "Web Technologies",
      icon: Icons.language_rounded,
      skills: ["HTML", "CSS", "JavaScript", "React",],
    ),
    _SkillCategory(
      title: "Development Tools",
      icon: Icons.build_rounded,
      skills: ["Git", "GitHub", "Postman", "Android Studio", "VS Code"],
    ),
    _SkillCategory(
      title: "Development Concepts",
      icon: FontAwesomeIcons.code,
      skills: [
        "OOP",
        "API Integration",
        "Authentication",
        "Responsive Design",
        "Version Control",
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: width < 600 ? 20 : 60,
        vertical: 80,
      ),
      child: Column(
        children: [
          _buildSectionHeading(context),

          const SizedBox(height: 50),

          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1250),
            child: LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount;
                double childAspectRatio;

                if (constraints.maxWidth >= 1050) {
                  crossAxisCount = 3;
                  childAspectRatio = 1.35;
                } else if (constraints.maxWidth >= 650) {
                  crossAxisCount = 2;
                  childAspectRatio = 1.35;
                } else if (constraints.maxWidth >= 400) {
                  crossAxisCount = 1;
                  childAspectRatio = 1.55;
                } else {
                  crossAxisCount = 1;
                  childAspectRatio = 1.00;
                }

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _skillCategories.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: childAspectRatio,
                  ),
                  itemBuilder: (context, index) {
                    return _SkillCard(category: _skillCategories[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeading(BuildContext context) {
    return Column(
      children: [
        Text(
          "MY EXPERTISE",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 13,
            fontWeight: FontWeight.w700,
            letterSpacing: 2,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          "Technical Skills",
          textAlign: TextAlign.center,
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
        ),

        const SizedBox(height: 12),

        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 650),
          child: Text(
            "Technologies and tools I use to build responsive, "
            "functional and maintainable applications.",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              height: 1.6,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.65),
            ),
          ),
        ),
      ],
    );
  }
}

class _SkillCategory {
  final String title;
  final Object icon;
  final List<String> skills;

  const _SkillCategory({
    required this.title,
    required this.icon,
    required this.skills,
  });
}

class _SkillCard extends StatefulWidget {
  final _SkillCategory category;

  const _SkillCard({required this.category});

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> {
  bool _isHovering = false;

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
        transform: Matrix4.translationValues(0, _isHovering ? -6 : 0, 0),
        padding: const EdgeInsets.all(26),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isHovering
                ? primary.withValues(alpha: 0.45)
                : Theme.of(context).dividerColor.withValues(alpha: 0.25),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: _isHovering ? 0.10 : 0.04),
              blurRadius: _isHovering ? 25 : 12,
              offset: Offset(0, _isHovering ? 12 : 6),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: primary.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(12),
              ),
              child: widget.category.icon is IconData
                  ? Icon(
                      widget.category.icon as IconData,
                      color: primary,
                      size: 23,
                    )
                  : FaIcon(
                      widget.category.icon as FaIconData,
                      color: primary,
                      size: 23,
                    ),
            ),

            const SizedBox(height: 18),

            Text(
              widget.category.title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),

            const SizedBox(height: 16),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.category.skills.map((skill) {
                return _SkillBadge(skill: skill);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _SkillBadge extends StatefulWidget {
  final String skill;

  const _SkillBadge({required this.skill});

  @override
  State<_SkillBadge> createState() => _SkillBadgeState();
}

class _SkillBadgeState extends State<_SkillBadge> {
  bool _isHovering = false;

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
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: _isHovering ? primary : primary.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: primary.withValues(alpha: 0.18)),
        ),
        child: Text(
          widget.skill,
          style: TextStyle(
            color: _isHovering ? Colors.white : primary,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
