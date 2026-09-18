import 'package:flutter/material.dart';
import 'package:portfolio/components/about.dart';
import 'package:portfolio/components/education.dart';
import 'package:portfolio/components/footer.dart';
import 'package:portfolio/components/skills.dart';
import 'package:portfolio/components/projects.dart';
import 'package:portfolio/components/experience.dart';
import 'package:portfolio/components/contact.dart';

class Portfolio extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final bool isDarkMode;

  const Portfolio({
    super.key,
    required this.onToggleTheme,
    required this.isDarkMode,
  });

  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  bool isMobile = false;

  final aboutKey = GlobalKey();
  final skillsKey = GlobalKey();
  final projectsKey = GlobalKey();
  final educationKey = GlobalKey();
  final experienceKey = GlobalKey();
  final contactKey = GlobalKey();

  final ScrollController _scrollController = ScrollController();

  bool _showScrollToTop = false;

  void scrollToSection(GlobalKey key) {
    final sectionContext = key.currentContext;

    if (sectionContext != null) {
      Scrollable.ensureVisible(
        sectionContext,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
        alignment: 0.05,
      );
    }
  }

  Widget navButton({required String title, required GlobalKey sectionKey}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: TextButton(
        onPressed: () {
          scrollToSection(sectionKey);

          if (isMobile && Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
        },
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        child: Text(
          title,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      final shouldShow = _scrollController.offset > 500;

      if (shouldShow != _showScrollToTop) {
        setState(() {
          _showScrollToTop = shouldShow;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    isMobile = MediaQuery.of(context).size.width < 1050;

    final navItems = [
      navButton(title: "About", sectionKey: aboutKey),
      navButton(title: "Skills", sectionKey: skillsKey),
      navButton(title: "Projects", sectionKey: projectsKey),
      navButton(title: "Education", sectionKey: educationKey),
      navButton(title: "Experience", sectionKey: experienceKey),
      navButton(title: "Contact", sectionKey: contactKey),
    ];

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        elevation: 0,
         actions: isMobile
            ? null
            : [
                ...navItems,

                const SizedBox(width: 5),

                Padding(
                  padding: const EdgeInsets.only(right: 18),
                  child: IconButton(
                    tooltip: widget.isDarkMode
                        ? "Switch to Light Mode"
                        : "Switch to Dark Mode",
                    onPressed: widget.onToggleTheme,
                    icon: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      transitionBuilder: (child, animation) {
                        return RotationTransition(
                          turns: animation,
                          child: FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        );
                      },
                      child: Icon(
                        widget.isDarkMode
                            ? Icons.light_mode_rounded
                            : Icons.dark_mode_rounded,
                        key: ValueKey(widget.isDarkMode),
                      ),
                    ),
                  ),
                ),
              ],
      ),

      drawer: isMobile
          ? Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const DrawerHeader(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Bhupender",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Flutter Developer",
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...navItems,

                  const Divider(),

                  ListTile(
                    leading: Icon(
                      widget.isDarkMode
                          ? Icons.light_mode_rounded
                          : Icons.dark_mode_rounded,
                    ),
                    title: Text(widget.isDarkMode ? "Light Mode" : "Dark Mode"),
                    onTap: () {
                      widget.onToggleTheme();

                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            )
          : null,

      body: SingleChildScrollView(
        controller: _scrollController,
        child: Center(
          child: Column(
            children: [
              About(
                key: aboutKey,
                onViewProjects: () {
                  scrollToSection(projectsKey);
                },
              ),

              Skills(key: skillsKey),

              Projects(key: projectsKey),

              Education(key: educationKey),

              Experience(key: experienceKey),

              Contact(key: contactKey),

              const Footer(),
            ],
          ),
        ),
      ),
      floatingActionButton: _showScrollToTop
          ? FloatingActionButton.small(
              tooltip: "Back to top",
              onPressed: () {
                _scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.easeInOutCubic,
                );
              },
              child: const Icon(Icons.keyboard_arrow_up_rounded),
            )
          : null,
    );
  }
}
