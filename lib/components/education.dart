import 'package:flutter/material.dart';

class Education extends StatelessWidget {
  const Education({super.key});

  static const List<_EducationData> _educationList = [
    _EducationData(
      degree: 'B.Tech in Computer Science & Engineering',
      institute: 'HMR Institute of Technology & Management, Delhi',
      duration: '2022 - 2025',
      description:
          'Focused on computer science fundamentals, software development, '
          'mobile application development and modern technologies.',
      icon: Icons.computer_rounded,
    ),
    _EducationData(
      degree: 'Diploma in Mechanical Engineering',
      institute: 'Aryabhatt Institute of Technology, Delhi',
      duration: '2019 - 2022',
      description:
          'Completed a Diploma in Mechanical Engineering before transitioning '
          'towards Computer Science and software development.',
      icon: Icons.engineering_rounded,
    ),
    _EducationData(
      degree: 'Senior Secondary Education (12th)',
      institute: 'Govt. Sarvodaya Bal Vidyalaya, Delhi',
      duration: '2019',
      description:
          'Completed Senior Secondary education and built the academic foundation '
          'for further technical studies.',
      icon: Icons.school_rounded,
    ),
    _EducationData(
      degree: 'Secondary Education (10th)',
      institute: 'Govt. Sarvodaya Bal Vidyalaya, Delhi',
      duration: '2017',
      description:
          'Completed secondary education and built the academic foundation '
          'for further technical studies.',
      icon: Icons.school_rounded,
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
            constraints: const BoxConstraints(maxWidth: 950),
            child: Column(
              children: List.generate(
                _educationList.length,
                (index) {
                  return _EducationTimelineItem(
                    education: _educationList[index],
                    isFirst: index == 0,
                    isLast: index == _educationList.length - 1,
                    isMobile: isMobile,
                  );
                },
              ),
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
          'MY JOURNEY',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 13,
            fontWeight: FontWeight.w700,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Education',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 650),
          child: Text(
            'My academic journey and the foundation that led me '
            'towards software and mobile application development.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
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

class _EducationData {
  final String degree;
  final String institute;
  final String duration;
  final String description;
  final IconData icon;

  const _EducationData({
    required this.degree,
    required this.institute,
    required this.duration,
    required this.description,
    required this.icon,
  });
}

class _EducationTimelineItem extends StatefulWidget {
  final _EducationData education;
  final bool isFirst;
  final bool isLast;
  final bool isMobile;

  const _EducationTimelineItem({
    required this.education,
    required this.isFirst,
    required this.isLast,
    required this.isMobile,
  });

  @override
  State<_EducationTimelineItem> createState() => _EducationTimelineItemState();
}

class _EducationTimelineItemState extends State<_EducationTimelineItem> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Stack(
      children: [
        Positioned(
          left: widget.isMobile ? 27 : 39,
          top: widget.isFirst ? 25 : 0,
          bottom: widget.isLast ? 28 : 0,
          child: Container(
            width: 2,
            color: primary.withValues(alpha: 0.22),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: widget.isMobile ? 55 : 80,
              child: Padding(
                padding: const EdgeInsets.only(top: 22),
                child: Center(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: _isHovering ? 46 : 42,
                    height: _isHovering ? 46 : 42,
                    decoration: BoxDecoration(
                      color: primary,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: primary.withValues(alpha: 0.25),
                          blurRadius: _isHovering ? 18 : 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Icon(
                      widget.education.icon,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 28),
                child: MouseRegion(
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
                      _isHovering ? 5 : 0,
                      0,
                      0,
                    ),
                    padding: EdgeInsets.all(widget.isMobile ? 20 : 26),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(18),
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
                          blurRadius: _isHovering ? 24 : 12,
                          offset: const Offset(0, 7),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: primary.withValues(alpha: 0.09),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            widget.education.duration,
                            style: TextStyle(
                              color: primary,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          widget.education.degree,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 18,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withValues(alpha: 0.55),
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                widget.education.institute,
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
                        const SizedBox(height: 15),
                        Text(
                          widget.education.description,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                height: 1.7,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withValues(alpha: 0.65),
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
