import 'package:flutter/material.dart';
import 'package:portfolio/constants/constants.dart';
import 'package:portfolio/data/data.dart';
import 'package:portfolio/screens/widgets/project_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

    @override
    State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    final ScrollController scrollController = ScrollController();

    final GlobalKey homeKey = GlobalKey();
    final GlobalKey aboutKey = GlobalKey();
    final GlobalKey projectsKey = GlobalKey();
    final GlobalKey contactKey = GlobalKey();

    void scrollToSection(GlobalKey key) {
        final sectionContext = key.currentContext;

        if (sectionContext != null) {
            Scrollable.ensureVisible(
                    sectionContext,
                    duration: const Duration(milliseconds: 700),
            curve: Curves.easeInOut,
      );
        }
    }

    Future<void> openResume() async {
        final Uri url = Uri.parse(resumeLink);

        if (await canLaunchUrl(url)) {
            await launchUrl(url);
        }
    }

    Future<void> openEmail() async {
        final Uri url = Uri(
                scheme: "mailto",
                path: contactEmail,
    );

        if (await canLaunchUrl(url)) {
            await launchUrl(url);
        }
    }

    @override
    void dispose() {
        scrollController.dispose();
        super.dispose();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
                backgroundColor: const Color(0xffF8FAFC),

                // =========================================================
                // MOBILE DRAWER
                // =========================================================

                drawer: _MobileDrawer(
                onHomePressed: () {
            Navigator.pop(context);

            Future.delayed(
            const Duration(milliseconds: 200),
            () => scrollToSection(homeKey),
          );
        },
        onAboutPressed: () {
            Navigator.pop(context);

            Future.delayed(
            const Duration(milliseconds: 200),
            () => scrollToSection(aboutKey),
          );
        },
        onProjectsPressed: () {
            Navigator.pop(context);

            Future.delayed(
            const Duration(milliseconds: 200),
            () => scrollToSection(projectsKey),
          );
        },
        onContactPressed: () {
            Navigator.pop(context);

            Future.delayed(
            const Duration(milliseconds: 200),
            () => scrollToSection(contactKey),
          );
        },
      ),

        // =========================================================
        // TOP NAVIGATION
        // =========================================================

        appBar: PreferredSize(
                preferredSize: const Size.fromHeight(70),
                child: LayoutBuilder(
                builder: (context, constraints) {
            final bool desktop = constraints.maxWidth >= 850;

            return AppBar(
                    toolbarHeight: 70,
                    elevation: 0,
                    backgroundColor: Colors.white,
                    surfaceTintColor: Colors.white,

                    leading: desktop
                    ? null
                    : Builder(
                    builder: (context) {
            return IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                Scaffold.of(context).openDrawer();
            },
                        );
                      },
                    ),

            title: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
            Container(
                    width: 11,
                    height: 11,
                    decoration: const BoxDecoration(
                    color: Color(0xff2563EB),
                    shape: BoxShape.circle,
                    ),
                  ),

                  const SizedBox(width: 10),

            Flexible(
                    child: Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                    color: Color(0xff0F172A),
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                      ),
                    ),
                  ),
                ],
              ),

            actions: desktop
                    ? [
            _NavigationButton(
                    title: "Home",
                    onPressed: () => scrollToSection(homeKey),
                      ),

            _NavigationButton(
                    title: "About",
                    onPressed: () => scrollToSection(aboutKey),
                      ),

            _NavigationButton(
                    title: "Projects",
                    onPressed: () => scrollToSection(projectsKey),
                      ),

            _NavigationButton(
                    title: "Contact",
                    onPressed: () => scrollToSection(contactKey),
                      ),

                      const SizedBox(width: 12),

            Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
            child: ElevatedButton.icon(
                    onPressed: openResume,
                    icon: const Icon(
                    Icons.description_outlined,
                    size: 18,
                          ),
            label: const Text("Resume"),
                        ),
                      ),

                      const SizedBox(width: 24),
                    ]
                  : null,
            );
        },
        ),
      ),

        // =========================================================
        // WEBSITE BODY
        // =========================================================

        body: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                children: [
        // =====================================================
        // HERO
        // =====================================================

        Container(
                key: homeKey,
                width: double.infinity,
                decoration: const BoxDecoration(
                gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
        Color(0xffEFF6FF),
                Colors.white,
                Color(0xffF5F3FF),
                  ],
                ),
              ),
        child: _PageWidth(
                child: LayoutBuilder(
                builder: (context, constraints) {
            final bool row = constraints.maxWidth >= 850;

            return Padding(
                    padding: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth < 600 ? 20 : 40,
                    vertical: constraints.maxWidth < 600 ? 55 : 90,
                      ),
            child: row
                    ? Row(
                    children: [
            Expanded(
                    flex: 6,
                    child: _HeroInformation(
                    openResume: openResume,
                    openEmail: openEmail,
                    openProjects: () {
                scrollToSection(projectsKey);
            },
                                  ),
                                ),

                                const SizedBox(width: 60),

                                const Expanded(
                    flex: 4,
                    child: _ProfileImage(),
                                ),
                              ],
                            )
                          : Column(
                    children: [
                                const _ProfileImage(),

                                const SizedBox(height: 45),

            _HeroInformation(
                    openResume: openResume,
                    openEmail: openEmail,
                    openProjects: () {
                scrollToSection(projectsKey);
            },
                                ),
                              ],
                            ),
                    );
        },
                ),
              ),
            ),

        // =====================================================
        // ABOUT
        // =====================================================

        Container(
                key: aboutKey,
                width: double.infinity,
                color: Colors.white,
                child: _PageWidth(
                child: LayoutBuilder(
                builder: (context, constraints) {
                    /*
                    IMPORTANT:

                    The information card is NOT placed beside the
                    About text until there is enough real width.

                    At 1200px page width:

                    Left side  = about 670px
                    Gap        = 40px
                    Right card = about 410px

                    Therefore the email has enough width.
                    */

            final bool showRow = constraints.maxWidth >= 1150;

            return Padding(
                    padding: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth < 600 ? 20 : 40,
                    vertical: constraints.maxWidth < 600 ? 65 : 90,
                      ),
            child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                          const _SectionHeading(
                    smallTitle: "ABOUT ME",
                    title:
            "Computer Science Graduate & Flutter Developer",
                    description:
            "A quick overview of my background, experience, and professional information.",
                          ),

                          const SizedBox(height: 50),

            if (showRow)
                Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                                const Expanded(
                    flex: 7,
                    child: _AboutInformation(),
                                ),

                                const SizedBox(width: 40),

                                const SizedBox(
                    width: 420,
                    child: _ContactInformationCard(),
                                ),
                              ],
                            )
                          else
                            const Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
            _AboutInformation(),

                    SizedBox(height: 40),

            _ContactInformationCard(),
                              ],
                            ),
                        ],
                      ),
                    );
        },
                ),
              ),
            ),

        // =====================================================
        // SKILLS
        // =====================================================

        Container(
                width: double.infinity,
                color: const Color(0xffF8FAFC),
                child: _PageWidth(
                child: Padding(
                padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 90,
                  ),
        child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                      const _SectionHeading(
                smallTitle: "TECHNICAL SKILLS",
                title: "Technologies I Work With",
                description:
        "Technologies and tools used across my mobile applications, academic work, and software development projects.",
                      ),

                      const SizedBox(height: 50),

                      const _ResponsiveSkills(),
                    ],
                  ),
                ),
              ),
            ),

        // =====================================================
        // PROJECTS
        // =====================================================

        Container(
                key: projectsKey,
                width: double.infinity,
                color: Colors.white,
                child: _PageWidth(
                child: LayoutBuilder(
                builder: (context, constraints) {
            return Padding(
                    padding: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth < 600 ? 20 : 40,
                    vertical: constraints.maxWidth < 600 ? 65 : 90,
                      ),
            child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
            // THIS IS THE PROJECT HEADING.

                          const _SectionHeading(
                    smallTitle: "MY WORK",
                    title: "Featured Projects",
                    description:
            "A selection of projects demonstrating my Flutter development, artificial intelligence, software engineering, and practical problem-solving experience.",
                          ),

                          const SizedBox(height: 50),

            // PROJECTS

                          const _ResponsiveProjects(),
                        ],
                      ),
                    );
        },
                ),
              ),
            ),

        // =====================================================
        // CONTACT
        // =====================================================

        Container(
                key: contactKey,
                width: double.infinity,
                color: const Color(0xffF8FAFC),
                child: _PageWidth(
                maxWidth: 1000,
                child: LayoutBuilder(
                builder: (context, constraints) {
            final bool mobile = constraints.maxWidth < 600;

            return Padding(
                    padding: EdgeInsets.symmetric(
                    horizontal: mobile ? 20 : 40,
                    vertical: mobile ? 65 : 100,
                      ),
            child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(
                    mobile ? 30 : 60,
                    ),
                    decoration: BoxDecoration(
                    color: const Color(0xff0F172A),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
            BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 30,
                    offset: const Offset(0, 15),
                            ),
                          ],
                        ),
            child: Column(
                    children: [
                            const Icon(
                    Icons.waving_hand_outlined,
                    size: 45,
                    color: Color(0xff60A5FA),
                            ),

                            const SizedBox(height: 20),

            Text(
                    "Let's Build Something Great",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                    color: Colors.white,
                    fontSize: mobile ? 27 : 36,
                    fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 16),

                            const Text(
                    "I am open to graduate opportunities, Flutter development roles, internships, and software development collaborations.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                    color: Color(0xffCBD5E1),
                    fontSize: 16,
                    height: 1.7,
                              ),
                            ),

                            const SizedBox(height: 30),

            ElevatedButton.icon(
                    onPressed: openEmail,
                    icon: const Icon(Icons.email_outlined),
                    label: const Text("Contact Me"),
                            ),
                          ],
                        ),
                      ),
                    );
        },
                ),
              ),
            ),

        // =====================================================
        // FOOTER
        // =====================================================

        Container(
                width: double.infinity,
                color: const Color(0xff020617),
                padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 35,
              ),
        child: Column(
                children: [
        Text(
                name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                "Computer Science Graduate • Flutter Developer",
                textAlign: TextAlign.center,
                style: TextStyle(
                color: Color(0xff94A3B8),
                    ),
                  ),

                  const SizedBox(height: 16),

        Text(
                "© ${DateTime.now().year} $name",
                style: const TextStyle(
                color: Color(0xff64748B),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    }
}

// =============================================================
// MAXIMUM PAGE WIDTH
// =============================================================

class _PageWidth extends StatelessWidget {
    final Widget child;
    final double maxWidth;

  const _PageWidth({
        required this.child,
                this.maxWidth = 1280,
    });

    @override
    Widget build(BuildContext context) {
        return Center(
                child: Container(
                width: double.infinity,
                constraints: BoxConstraints(
                maxWidth: maxWidth,
        ),
        child: child,
      ),
    );
    }
}

// =============================================================
// NAVIGATION BUTTON
// =============================================================

class _NavigationButton extends StatefulWidget {
    final String title;
    final VoidCallback onPressed;

  const _NavigationButton({
        required this.title,
                required this.onPressed,
    });

    @override
    State<_NavigationButton> createState() => _NavigationButtonState();
}

class _NavigationButtonState extends State<_NavigationButton> {
    bool hovered = false;

    @override
    Widget build(BuildContext context) {
        return InkWell(
                onTap: widget.onPressed,
                onHover: (value) {
                setState(() {
                hovered = value;
        });
      },
        child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
        ),
        decoration: BoxDecoration(
                color: hovered
                ? const Color(0xffEFF6FF)
              : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
                widget.title,
                style: TextStyle(
                color: hovered
                ? const Color(0xff2563EB)
                : const Color(0xff475569),
                fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
    }
}

// =============================================================
// MOBILE DRAWER
// =============================================================

class _MobileDrawer extends StatelessWidget {
    final VoidCallback onHomePressed;
    final VoidCallback onAboutPressed;
    final VoidCallback onProjectsPressed;
    final VoidCallback onContactPressed;

  const _MobileDrawer({
        required this.onHomePressed,
                required this.onAboutPressed,
                required this.onProjectsPressed,
                required this.onContactPressed,
    });

    @override
    Widget build(BuildContext context) {
        return Drawer(
                child: SafeArea(
                child: Column(
                children: [
            const SizedBox(height: 30),

        CircleAvatar(
                radius: 45,
                backgroundImage: AssetImage(imagePath),
            ),

            const SizedBox(height: 15),

        Text(
                name,
                style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            const Divider(),

                ListTile(
                        leading: const Icon(Icons.home_outlined),
                title: const Text("Home"),
                onTap: onHomePressed,
            ),

        ListTile(
                leading: const Icon(Icons.person_outline),
                title: const Text("About"),
                onTap: onAboutPressed,
            ),

        ListTile(
                leading: const Icon(Icons.work_outline),
                title: const Text("Projects"),
                onTap: onProjectsPressed,
            ),

        ListTile(
                leading: const Icon(Icons.email_outlined),
                title: const Text("Contact"),
                onTap: onContactPressed,
            ),
          ],
        ),
      ),
    );
    }
}

// =============================================================
// HERO
// =============================================================

class _HeroInformation extends StatelessWidget {
    final VoidCallback openResume;
    final VoidCallback openEmail;
    final VoidCallback openProjects;

  const _HeroInformation({
        required this.openResume,
                required this.openEmail,
                required this.openProjects,
    });

    @override
    Widget build(BuildContext context) {
        return LayoutBuilder(
                builder: (context, constraints) {
            final bool centered = constraints.maxWidth < 600;

            return Column(
                    crossAxisAlignment: centered
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                    children: [
            Container(
                    padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
              ),
            decoration: BoxDecoration(
                    color: const Color(0xffDCFCE7),
                    borderRadius: BorderRadius.circular(50),
              ),
            child: const Text(
                    "●  Open to Opportunities",
                    style: TextStyle(
                    color: Color(0xff166534),
                    fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 25),

            Text(
                    "Hi, I'm $name",
                    textAlign: centered ? TextAlign.center : TextAlign.left,
                    style: TextStyle(
                    fontSize: centered ? 38 : 58,
                    height: 1.1,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xff0F172A),
              ),
            ),

            const SizedBox(height: 18),

            Text(
                    "Computer Science Graduate & Flutter Developer",
                    textAlign: centered ? TextAlign.center : TextAlign.left,
                    style: TextStyle(
                    color: const Color(0xff2563EB),
                    fontSize: centered ? 22 : 30,
                    fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 22),

            Text(
                    aboutMeSummary,
                    textAlign: centered ? TextAlign.center : TextAlign.left,
                    style: const TextStyle(
                    color: Color(0xff64748B),
                    fontSize: 17,
                    height: 1.7,
              ),
            ),

            const SizedBox(height: 30),

            Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    alignment:
            centered ? WrapAlignment.center : WrapAlignment.start,
                    children: [
            ElevatedButton.icon(
                    onPressed: openProjects,
                    icon: const Icon(Icons.work_outline),
                    label: const Text("View Projects"),
                ),

            OutlinedButton.icon(
                    onPressed: openResume,
                    icon: const Icon(Icons.description_outlined),
                    label: const Text("View Resume"),
                ),

            OutlinedButton.icon(
                    onPressed: openEmail,
                    icon: const Icon(Icons.email_outlined),
                    label: const Text("Contact"),
                ),
              ],
            ),
          ],
        );
        },
    );
    }
}

// =============================================================
// PROFILE IMAGE
// =============================================================

class _ProfileImage extends StatelessWidget {
  const _ProfileImage();

    @override
    Widget build(BuildContext context) {
        return LayoutBuilder(
                builder: (context, constraints) {
            final double size =
                    constraints.maxWidth < 300 ? constraints.maxWidth : 300;

            return Center(
                    child: Container(
                    width: size,
                    height: size,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                    colors: [
            Color(0xff2563EB),
                    Color(0xff7C3AED),
                ],
              ),
            boxShadow: [
            BoxShadow(
                    color: const Color(0xff2563EB).withOpacity(0.25),
                    blurRadius: 40,
                    offset: const Offset(0, 20),
                ),
              ],
            ),
            child: ClipOval(
                    child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
              ),
            ),
          ),
        );
        },
    );
    }
}

// =============================================================
// SECTION HEADING
// =============================================================

class _SectionHeading extends StatelessWidget {
    final String smallTitle;
    final String title;
    final String description;

  const _SectionHeading({
        required this.smallTitle,
                required this.title,
                required this.description,
    });

    @override
    Widget build(BuildContext context) {
        return LayoutBuilder(
                builder: (context, constraints) {
            return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
            Text(
                    smallTitle,
                    style: const TextStyle(
                    color: Color(0xff2563EB),
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
              ),
            ),

            const SizedBox(height: 10),

            Text(
                    title,
                    style: TextStyle(
                    color: const Color(0xff0F172A),
                    fontSize: constraints.maxWidth < 600 ? 28 : 36,
                    fontWeight: FontWeight.w800,
              ),
            ),

            const SizedBox(height: 14),

            ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 700),
            child: Text(
                    description,
                    style: const TextStyle(
                    color: Color(0xff64748B),
                    fontSize: 16,
                    height: 1.7,
                ),
              ),
            ),
          ],
        );
        },
    );
    }
}

// =============================================================
// ABOUT
// =============================================================

class _AboutInformation extends StatelessWidget {
  const _AboutInformation();

    @override
    Widget build(BuildContext context) {
        return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
        const _InformationTitle(
                icon: Icons.person_outline,
                title: "About Me",
        ),

        const SizedBox(height: 16),

        Text(
                aboutMeSummary,
                style: const TextStyle(
                color: Color(0xff475569),
                fontSize: 16,
                height: 1.8,
          ),
        ),

        const SizedBox(height: 35),

        const _InformationTitle(
                icon: Icons.work_outline,
                title: "Experience",
        ),

        const SizedBox(height: 16),

        Text(
                aboutWorkExperience,
                style: const TextStyle(
                color: Color(0xff475569),
                fontSize: 16,
                height: 1.8,
          ),
        ),
      ],
    );
    }
}

class _InformationTitle extends StatelessWidget {
    final IconData icon;
    final String title;

  const _InformationTitle({
        required this.icon,
                required this.title,
    });

    @override
    Widget build(BuildContext context) {
        return Row(
                children: [
        Icon(
                icon,
                color: const Color(0xff2563EB),
        ),

        const SizedBox(width: 12),

        Expanded(
                child: Text(
                title,
                style: const TextStyle(
                color: Color(0xff0F172A),
                fontSize: 22,
                fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
    }
}

// =============================================================
// PROFESSIONAL INFORMATION CARD
// =============================================================

class _ContactInformationCard extends StatelessWidget {
  const _ContactInformationCard();

    @override
    Widget build(BuildContext context) {
        return Container(
                width: double.infinity,

                padding: const EdgeInsets.all(28),

                decoration: BoxDecoration(
                color: const Color(0xffF8FAFC),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                color: const Color(0xffE2E8F0),
        ),
      ),

        child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
        Text(
                "Professional Information",
                style: TextStyle(
                color: Color(0xff0F172A),
                fontSize: 20,
                fontWeight: FontWeight.bold,
            ),
          ),

        SizedBox(height: 28),

        _ContactItem(
                icon: Icons.location_on_outlined,
                title: "Location",
                value: location,
          ),

        _ContactItem(
                icon: Icons.language_outlined,
                title: "Website",
                value: website,
                showExternalIcon: true,
          ),

        _ContactItem(
                icon: Icons.work_outline,
                title: "Portfolio",
                value: portfolio,
                showExternalIcon: true,
          ),

        _ContactItem(
                icon: Icons.email_outlined,
                title: "Email",
                value: email,
                showExternalIcon: true,
                last: true,
          ),
        ],
      ),
    );
    }
}

// =============================================================
// CONTACT ITEM
//
// IMPORTANT:
//
// There is NO Row around:
//
// email text + external icon
//
// Therefore the email can NEVER create horizontal overflow.
//
// =============================================================

class _ContactItem extends StatelessWidget {
    final IconData icon;
    final String title;
    final String value;
    final bool showExternalIcon;
    final bool last;

  const _ContactItem({
        required this.icon,
                required this.title,
                required this.value,
                this.showExternalIcon = false,
                this.last = false,
    });

    @override
    Widget build(BuildContext context) {
        return Padding(
                padding: EdgeInsets.only(
                bottom: last ? 0 : 24,
      ),

        child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
        Container(
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                color: const Color(0xffEFF6FF),
                borderRadius: BorderRadius.circular(10),
            ),
        child: Icon(
                icon,
                color: const Color(0xff2563EB),
                size: 20,
            ),
          ),

          const SizedBox(width: 12),

        Expanded(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
        Text(
                title,
                style: const TextStyle(
                color: Color(0xff64748B),
                fontSize: 13,
                fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 6),

        Text(
                value,
                softWrap: true,
                overflow: TextOverflow.visible,
                style: const TextStyle(
                color: Color(0xff0F172A),
                fontSize: 15,
                height: 1.5,
                fontWeight: FontWeight.w600,
                  ),
                ),

        if (showExternalIcon) ...[
                  const SizedBox(height: 6),

                  const Icon(
                Icons.open_in_new,
                size: 17,
                color: Color(0xff475569),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
    }
}

// =============================================================
// RESPONSIVE SKILLS
// =============================================================

class _ResponsiveSkills extends StatelessWidget {
  const _ResponsiveSkills();

    @override
    Widget build(BuildContext context) {
    const skills = [
        _SkillData(Icons.flutter_dash, "Flutter"),
                _SkillData(Icons.code, "Dart"),
                _SkillData(Icons.local_fire_department_outlined, "Firebase"),
                _SkillData(Icons.storage_outlined, "SQLite"),
                _SkillData(Icons.api_outlined, "REST APIs"),
                _SkillData(Icons.psychology_outlined, "AI / ML"),
                _SkillData(Icons.phone_android, "Mobile Development"),
                _SkillData(Icons.cloud_outlined, "Cloud Firestore"),
    ];

        return LayoutBuilder(
                builder: (context, constraints) {
            int columns;

            if (constraints.maxWidth >= 1000) {
                columns = 4;
            } else if (constraints.maxWidth >= 650) {
                columns = 3;
            } else if (constraints.maxWidth >= 380) {
                columns = 2;
            } else {
                columns = 1;
            }

        const double gap = 16;

            final double width =
                    (constraints.maxWidth - ((columns - 1) * gap)) / columns;

            return Wrap(
                    spacing: gap,
                    runSpacing: gap,
                    children: skills.map((skill) {
            return SizedBox(
                    width: width,
                    child: _SkillCard(
                    icon: skill.icon,
                    title: skill.title,
              ),
            );
          }).toList(),
        );
        },
    );
    }
}

class _SkillData {
    final IconData icon;
    final String title;

  const _SkillData(this.icon, this.title);
}

class _SkillCard extends StatelessWidget {
    final IconData icon;
    final String title;

  const _SkillCard({
        required this.icon,
                required this.title,
    });

    @override
    Widget build(BuildContext context) {
        return Container(
                padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 26,
      ),
        decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                color: const Color(0xffE2E8F0),
        ),
      ),
        child: Column(
                children: [
        Icon(
                icon,
                color: const Color(0xff2563EB),
                size: 34,
          ),

          const SizedBox(height: 14),

        Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                color: Color(0xff0F172A),
                fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
    }
}

// =============================================================
// RESPONSIVE PROJECTS
//
// IMPORTANT:
//
// Every ProjectWidget receives an explicit height.
//
// The old ProjectWidget used Spacer/Expanded internally.
//
// Without a bounded height, that layout is unreliable.
//
// =============================================================

class _ResponsiveProjects extends StatelessWidget {
  const _ResponsiveProjects();

    @override
    Widget build(BuildContext context) {
        return LayoutBuilder(
                builder: (context, constraints) {
            int columns;

            if (constraints.maxWidth >= 1100) {
                columns = 3;
            } else if (constraints.maxWidth >= 700) {
                columns = 2;
            } else {
                columns = 1;
            }

        const double gap = 20;

            final double cardWidth =
                    (constraints.maxWidth - ((columns - 1) * gap)) / columns;

        /*
        Larger height is intentional.

        Your descriptions have different lengths.

        Giving cards enough height prevents RenderFlex overflow.
        */

            final double cardHeight;

            if (columns == 3) {
                cardHeight = 360;
            } else if (columns == 2) {
                cardHeight = 310;
            } else {
                cardHeight = 330;
            }

            return Wrap(
                    spacing: gap,
                    runSpacing: gap,
                    children: List.generate(
                    projectList.length,
                    (index) {
            return SizedBox(
                    width: cardWidth,
                    height: cardHeight,
                    child: ProjectWidget(
                    projectData: projectList[index],
                ),
              );
            },
          ),
        );
        },
    );
    }
}