import 'package:flutter/material.dart';
import 'package:portfolio/components/project_card.dart';
import 'package:portfolio/models/project_model.dart';
import 'package:portfolio/utils/app_links.dart';

class Projects extends StatelessWidget {
  const Projects({super.key});

  static const List<ProjectModel> projects = [
    ProjectModel(
      title: "FlutIQ",
      description:
          "A Flutter Q&A application for learning Flutter concepts with "
          "search, category filtering, expandable questions and "
          "Cloud Firestore powered content.",
      image: "assets/images/projects/flutiq.png",
      technologies: ["Flutter", "Dart", "Firebase", "Firestore"],
      githubUrl: "https://github.com/bhupender1208/Flutter_QA_App",
      liveUrl: AppLinks.flutiq,
    ),

    ProjectModel(
      title: "Recipe Explorer",
      description:
          "A responsive Flutter recipe application featuring authentication, "
          "recipe search, filtering and detailed recipe information using "
          "REST API integration.",
      image: "assets/images/projects/recipe_explorer.png",
      technologies: ["Flutter", "Dart", "Firebase", "REST API"],
      githubUrl: "https://github.com/bhupender1208/Recipe_Explorer",
      liveUrl: AppLinks.recipeExplorer,
    ),

    ProjectModel(
      title: "Blinkit Clone",
      description:
          "A Flutter-based recreation of the Blinkit shopping interface "
          "focused on reusable widgets, responsive layouts and modern "
          "mobile application UI development.",
      image: "assets/images/projects/blinkit_clone.png",
      technologies: ["Flutter", "Dart", "Responsive UI", "Material UI"],
      githubUrl: "https://github.com/bhupender1208/Blinkit_Clone",
      liveUrl: AppLinks.blinkitClone,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: width < 600 ? 20 : 60,
        vertical: 90,
      ),
      child: Column(
        children: [
          Text(
            "MY WORK",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 13,
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            "Featured Projects",
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
          ),

          const SizedBox(height: 12),

          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: Text(
              "A selection of applications I've built while working "
              "with Flutter, Firebase, APIs and responsive UI development.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                height: 1.6,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.65),
              ),
            ),
          ),

          const SizedBox(height: 50),

          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1250),
            child: LayoutBuilder(
              builder: (context, constraints) {
                int columns;

                if (constraints.maxWidth >= 1050) {
                  columns = 3;
                } else if (constraints.maxWidth >= 650) {
                  columns = 2;
                } else {
                  columns = 1;
                }

                final double cardHeight;

                if (columns == 1) {
                  cardHeight = 560;
                } else if (columns == 2) {
                  cardHeight = 590;
                } else {
                  cardHeight = 570;
                }

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: projects.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: 22,
                    mainAxisSpacing: 22,
                    mainAxisExtent: cardHeight,
                  ),
                  itemBuilder: (context, index) {
                    return ProjectCard(project: projects[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
