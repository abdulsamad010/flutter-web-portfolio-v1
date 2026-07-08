import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/constants/constants.dart';
import 'package:portfolio/data/data.dart';
import 'package:portfolio/screens/widgets/project_widget.dart';
import 'package:url_launcher/url_launcher.dart';

// =============================================================
// WHATSAPP CONTACT INFO
// TODO: Move these into constants.dart alongside contactEmail,
// linkedInUrl, etc. Update the number to your real WhatsApp
// number in full international format (digits only after "+").
// =============================================================
const String whatsappNumber = "+923499437200";
const String whatsappDisplay = "+92 349 9437200";

// =============================================================
// DESIGN TOKENS — MODERN TECH PALETTE
//
// Brand gradient runs indigo -> violet -> cyan. Used for primary
// buttons, icon badges, gradient headline text, glowing shadows,
// and decorative background blobs, so the same signature reads
// consistently across every section instead of flat single tones.
// =============================================================
const Color _cIndigo = Color(0xff4F46E5);
const Color _cViolet = Color(0xff8B5CF6);
const Color _cCyan = Color(0xff22D3EE);
const Color _cWhatsApp = Color(0xff25D366);

const List<Color> _brandGradient = [_cIndigo, _cViolet];

// =============================================================
// GRADIENT ICON BADGE
// Replaces flat light-blue icon containers used throughout
// (About, Contact info, Skills, Certifications) with a glowing
// gradient badge for a more "tech product" feel.
// =============================================================
class _IconBadge extends StatelessWidget {
  final IconData icon;
  final double size;
  final double iconSize;

  const _IconBadge({
    required this.icon,
    this.size = 40,
    this.iconSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: _brandGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(size * 0.28),
        boxShadow: [
          BoxShadow(
            color: _cIndigo.withOpacity(0.30),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Icon(icon, color: Colors.white, size: iconSize),
    );
  }
}

// =============================================================
// GRADIENT BUTTON
// Primary call-to-action button (CV, Contact Me, View Projects)
// with a brand gradient fill and a soft colored glow, replacing
// the flat solid-color ElevatedButton look.
// =============================================================
class _GradientButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String label;
  final bool expand;

  const _GradientButton({
    required this.onPressed,
    required this.icon,
    required this.label,
    this.expand = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: expand ? double.infinity : null,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: _brandGradient,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: _cIndigo.withOpacity(0.35),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
            child: Row(
              mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 18, color: Colors.white),
                const SizedBox(width: 10),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
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

// =============================================================
// WHATSAPP BUTTON
// Brand-green CTA button, styled to match _GradientButton but
// using WhatsApp's signature solid green instead of the site's
// indigo/violet gradient, so it reads as its own recognizable
// action wherever it appears.
// =============================================================
class _WhatsAppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool expand;

  const _WhatsAppButton({
    required this.onPressed,
    this.expand = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: expand ? double.infinity : null,
      decoration: BoxDecoration(
        color: _cWhatsApp,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: _cWhatsApp.withOpacity(0.35),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
            child: Row(
              mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.chat_bubble_outline, size: 18, color: Colors.white),
                SizedBox(width: 10),
                Text(
                  "WhatsApp",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
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

// =============================================================
// GLOW BLOB
// Soft decorative radial-gradient circle used behind Hero,
// Skills, and Contact sections to add atmosphere instead of a
// flat single-color background. Purely decorative: IgnorePointer
// keeps it out of the hit-test tree, and it never affects layout
// size since it's only ever placed as a Positioned Stack child.
// =============================================================
class _GlowBlob extends StatelessWidget {
  final Color color;
  final double size;

  const _GlowBlob({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [color.withOpacity(0.30), color.withOpacity(0.0)],
          ),
        ),
      ),
    );
  }
}

// =============================================================
// STATUS CHIP
// "Open to Opportunities" pill, reused in Hero + Mobile Drawer,
// upgraded from a flat light-green fill to a gradient chip with
// a soft glow so it reads as an active/live status indicator.
// =============================================================
class _StatusChip extends StatelessWidget {
  const _StatusChip();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xff10B981), Color(0xff059669)],
        ),
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff10B981).withOpacity(0.35),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.circle, size: 8, color: Colors.white),
          SizedBox(width: 8),
          Text(
            "Open to Opportunities",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 12.5,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================
// GRADIENT EYEBROW LABEL
// Small pill used above every section title (ABOUT ME,
// CERTIFICATIONS, etc.) with gradient text on a tinted
// background instead of bare flat-colored text.
// =============================================================
class _GradientEyebrow extends StatelessWidget {
  final String text;

  const _GradientEyebrow({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xffEEF2FF),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: const Color(0xffC7D2FE)),
      ),
      child: ShaderMask(
        shaderCallback: (bounds) => const LinearGradient(
          colors: [_cIndigo, _cCyan],
        ).createShader(bounds),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12.5,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController scrollController = ScrollController();

  final GlobalKey homeKey = GlobalKey();
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey certificationsKey = GlobalKey();
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
    final Uri url = Uri.parse(cvLink);

    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
    } catch (_) {
      // Silently ignore - avoids crashing the UI if the link can't open.
    }
  }

  Future<void> openEmail() async {
    final Uri gmailUrl = Uri.https(
      "mail.google.com",
      "/mail/",
      {
        "view": "cm",
        "fs": "1",
        "to": contactEmail,
        "su": "Portfolio Contact",
      },
    );

    try {
      final bool opened = await launchUrl(
        gmailUrl,
        mode: LaunchMode.platformDefault,
        webOnlyWindowName: "_blank",
      );

      if (!opened && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Could not open email. Contact me at $contactEmail",
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Could not open email. Contact me at $contactEmail",
            ),
          ),
        );
      }
    }
  }

  // ===========================================================
  // WHATSAPP
  // Opens wa.me with a prefilled greeting message. wa.me works
  // identically on mobile (deep-links into the WhatsApp app) and
  // on desktop/web (opens WhatsApp Web in a new tab), so there's
  // no need for platform-specific branching here.
  // ===========================================================
  Future<void> openWhatsApp() async {
    final String phone = whatsappNumber.replaceAll(RegExp(r'[^0-9]'), '');
    final Uri whatsappUrl = Uri.parse(
      "https://wa.me/$phone?text=${Uri.encodeComponent("Hi, I saw your portfolio and would like to connect!")}",
    );

    try {
      final bool opened = await launchUrl(
        whatsappUrl,
        mode: LaunchMode.platformDefault,
        webOnlyWindowName: "_blank",
      );

      if (!opened && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Could not open WhatsApp. Contact me at $whatsappDisplay",
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Could not open WhatsApp. Contact me at $whatsappDisplay",
            ),
          ),
        );
      }
    }
  }

  Future<void> openWebUrl(String link) async {
    final Uri? url = Uri.tryParse(link);

    if (url == null) {
      return;
    }

    try {
      final bool opened = await launchUrl(
        url,
        mode: LaunchMode.platformDefault,
        webOnlyWindowName: "_blank",
      );

      if (!opened && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Could not open the link."),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Could not open the link."),
          ),
        );
      }
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

        onCertificationsPressed: () {
          Navigator.pop(context);
          Future.delayed(
            const Duration(milliseconds: 200),
                () => scrollToSection(certificationsKey),
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

        onResumePressed: openResume,
      ),

      // =========================================================
      // TOP NAVIGATION
      //
      // FIX: previously this used a single breakpoint (850px) to
      // decide between "drawer" and "full row of nav buttons +
      // Resume button". Between ~850-1150px that full row did not
      // actually fit (title + 4 buttons + Resume button), causing
      // a RenderFlex/overflow warning on the right edge.
      //
      // Now there are three tiers:
      //   < 900        -> hamburger + drawer
      //   900 - 1180   -> full nav row, tighter padding, Resume as
      //                   icon-only button (no label) to save space
      //   >= 1180      -> full nav row with normal padding + labeled
      //                   Resume button
      // =========================================================
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double width = constraints.maxWidth;
            final bool isMobile = width < 900;
            final bool isCompact = !isMobile && width < 1180;

            return AppBar(
              toolbarHeight: 70,
              elevation: 0,
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              leading: isMobile
                  ? Builder(
                builder: (context) {
                  return IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                },
              )
                  : null,
              titleSpacing: isMobile ? null : 0,
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 11,
                    height: 11,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: _brandGradient,
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: _cIndigo.withOpacity(0.55),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        color: const Color(0xff0F172A),
                        fontWeight: FontWeight.w700,
                        fontSize: 19,
                      ),
                    ),
                  ),
                ],
              ),
              actions: isMobile
                  ? null
                  : [
                _NavigationButton(
                  title: "Home",
                  compact: isCompact,
                  onPressed: () => scrollToSection(homeKey),
                ),
                _NavigationButton(
                  title: "About",
                  compact: isCompact,
                  onPressed: () => scrollToSection(aboutKey),
                ),

                _NavigationButton(
                  title: "Certifications",
                  compact: isCompact,
                  onPressed: () => scrollToSection(certificationsKey),
                ),

                _NavigationButton(
                  title: "Projects",
                  compact: isCompact,
                  onPressed: () => scrollToSection(projectsKey),
                ),
                _NavigationButton(
                  title: "Contact",
                  compact: isCompact,
                  onPressed: () => scrollToSection(contactKey),
                ),
                SizedBox(width: isCompact ? 6 : 12),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: isCompact
                      ? Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: _brandGradient),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: _cIndigo.withOpacity(0.30),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: IconButton(
                      tooltip: "View CV",
                      onPressed: openResume,
                      icon: const Icon(
                        Icons.description_outlined,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  )
                      : _GradientButton(
                    onPressed: openResume,
                    icon: Icons.description_outlined,
                    label: "CV",
                  ),
                ),
                SizedBox(width: isCompact ? 12 : 24),
              ],
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
              clipBehavior: Clip.hardEdge,
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
              child: Stack(
                clipBehavior: Clip.hardEdge,
                children: [
                  const Positioned(
                    top: -70,
                    right: -60,
                    child: _GlowBlob(color: _cCyan, size: 260),
                  ),
                  const Positioned(
                    bottom: -110,
                    left: -90,
                    child: _GlowBlob(color: _cViolet, size: 320),
                  ),
                  _PageWidth(
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
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                ],
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
                            "Computer Science Graduate • Flutter & Ai Developer",
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
                                SizedBox(
                                  width: 420,
                                  child: _ContactInformationCard(
                                    openLinkedIn: () {
                                      openWebUrl(linkedInUrl);
                                    },
                                    openEmail: openEmail,
                                    openWhatsApp: openWhatsApp,
                                  ),
                                ),
                              ],
                            )
                          else
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const _AboutInformation(),
                                const SizedBox(height: 40),
                                _ContactInformationCard(
                                  openLinkedIn: () {
                                    openWebUrl(linkedInUrl);
                                  },
                                  openEmail: openEmail,
                                  openWhatsApp: openWhatsApp,
                                ),
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
              child: Stack(
                clipBehavior: Clip.hardEdge,
                children: [
                  const Positioned(
                    top: -60,
                    right: -80,
                    child: _GlowBlob(color: _cIndigo, size: 280),
                  ),
                  _PageWidth(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 90,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          _SectionHeading(
                            smallTitle: "TECHNICAL SKILLS",
                            title: "Technologies I Work With",
                            description:
                            "Technologies and tools used across my mobile applications, academic work, and software development projects.",
                          ),
                          SizedBox(height: 50),
                          _ResponsiveSkills(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // =====================================================
            // CERTIFICATIONS
            // =====================================================
            Container(
              key: certificationsKey,
              width: double.infinity,
              color: Colors.white,
              child: _PageWidth(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal:
                        constraints.maxWidth < 600 ? 20 : 40,
                        vertical:
                        constraints.maxWidth < 600 ? 65 : 90,
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _SectionHeading(
                            smallTitle: "CERTIFICATIONS",
                            title: "Certifications & Credentials",
                            description:
                            "Selected certifications and credentials demonstrating continuous learning across mobile development, artificial intelligence, machine learning, Python, data science, project management, cloud technologies, cybersecurity, and productivity tools.",
                          ),
                          SizedBox(height: 50),
                          _ResponsiveCertifications(),
                        ],
                      ),
                    );
                  },
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
                        children: const [
                          _SectionHeading(
                            smallTitle: "MY WORK",
                            title: "Featured Projects",
                            description:
                            "A selection of projects demonstrating my Flutter development, artificial intelligence, software engineering, and practical problem-solving experience.",
                          ),
                          SizedBox(height: 50),
                          _ResponsiveProjects(),
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
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xff0F172A), Color(0xff1E1B4B)],
                          ),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: _cIndigo.withOpacity(0.25),
                              blurRadius: 40,
                              offset: const Offset(0, 20),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: -60,
                              left: -60,
                              child: _GlowBlob(color: _cCyan, size: 220),
                            ),
                            Positioned(
                              bottom: -70,
                              right: -50,
                              child: _GlowBlob(color: _cViolet, size: 240),
                            ),
                            Padding(
                              padding: EdgeInsets.all(mobile ? 30 : 60),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(18),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: const LinearGradient(
                                        colors: [_cIndigo, _cCyan],
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: _cCyan.withOpacity(0.35),
                                          blurRadius: 24,
                                          offset: const Offset(0, 8),
                                        ),
                                      ],
                                    ),
                                    child: const Icon(
                                      Icons.waving_hand_outlined,
                                      size: 34,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  Text(
                                    "Let's Build Something Great",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: mobile ? 27 : 36,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    "I am open to graduate opportunities, Ai & Flutter development roles, internships, and software development collaborations.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xffCBD5E1),
                                      fontSize: 16,
                                      height: 1.7,
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  Wrap(
                                    alignment: WrapAlignment.center,
                                    spacing: 12,
                                    runSpacing: 12,
                                    children: [
                                      _GradientButton(
                                        onPressed: openEmail,
                                        icon: Icons.email_outlined,
                                        label: "Contact Me",
                                      ),
                                      _WhatsAppButton(
                                        onPressed: openWhatsApp,
                                      ),
                                      OutlinedButton.icon(
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          side: const BorderSide(
                                            color: Color(0xff475569),
                                          ),
                                        ),
                                        onPressed: openResume,
                                        icon: const Icon(
                                          Icons.description_outlined,
                                        ),
                                        label: const Text("View CV"),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
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
                  Container(
                    width: 48,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: _brandGradient),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Computer Science Graduate • Flutter & Ai Developer",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xff94A3B8)),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "© ${DateTime.now().year} $name",
                    style: const TextStyle(color: Color(0xff64748B)),
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
        constraints: BoxConstraints(maxWidth: maxWidth),
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
  final bool compact;

  const _NavigationButton({
    required this.title,
    required this.onPressed,
    this.compact = false,
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
      borderRadius: BorderRadius.circular(8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: widget.compact ? 9 : 15,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: hovered ? const Color(0xffEEF2FF) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          widget.title,
          style: TextStyle(
            color: hovered ? _cIndigo : const Color(0xff475569),
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
  final VoidCallback onCertificationsPressed;
  final VoidCallback onProjectsPressed;
  final VoidCallback onContactPressed;
  final VoidCallback onResumePressed;

  const _MobileDrawer({
    required this.onHomePressed,
    required this.onAboutPressed,
    required this.onCertificationsPressed,
    required this.onProjectsPressed,
    required this.onContactPressed,
    required this.onResumePressed,
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
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 8),

            const _StatusChip(),

            const SizedBox(height: 25),

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
              leading:
              const Icon(Icons.workspace_premium_outlined),
              title: const Text("Certifications"),
              onTap: onCertificationsPressed,
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

            const Divider(),

            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 16),
              child: _GradientButton(
                onPressed: onResumePressed,
                icon: Icons.description_outlined,
                label: "View CV",
                expand: true,
              ),
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
          crossAxisAlignment:
          centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            const _StatusChip(),
            const SizedBox(height: 25),
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Color(0xff0F172A), _cIndigo, _cViolet],
                stops: [0.0, 0.55, 1.0],
              ).createShader(bounds),
              child: Text(
                "Hi, I'm $name",
                textAlign: centered ? TextAlign.center : TextAlign.left,
                style: GoogleFonts.poppins(
                  fontSize: centered ? 34 : 54,
                  height: 1.15,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              "Computer Science Graduate • Flutter & Ai Developer",
              textAlign: centered ? TextAlign.center : TextAlign.left,
              style: GoogleFonts.montserrat(
                color: _cIndigo,
                fontSize: centered ? 20 : 26,
                fontWeight: FontWeight.w700,
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
            const SizedBox(height: 20),

            // Quick facts strip - gives recruiters a fast summary.
            Wrap(
              alignment:
              centered ? WrapAlignment.center : WrapAlignment.start,
              spacing: 10,
              runSpacing: 10,
              children: [
                _QuickFact(
                  icon: Icons.school_outlined,
                  label: "CS Graduate",
                ),
                _QuickFact(
                  icon: Icons.flutter_dash,
                  label: "Flutter & Ai Developer",
                ),
                _QuickFact(
                  icon: Icons.work_outline,
                  label: "${projectList.length}+ Projects",
                ),
              ],
            ),

            const SizedBox(height: 30),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment:
              centered ? WrapAlignment.center : WrapAlignment.start,
              children: [
                _GradientButton(
                  onPressed: openProjects,
                  icon: Icons.work_outline,
                  label: "View Projects",
                ),
                OutlinedButton.icon(
                  onPressed: openResume,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: _cIndigo,
                    side: const BorderSide(color: _cIndigo, width: 1.4),
                  ),
                  icon: const Icon(Icons.description_outlined),
                  label: const Text("View CV"),
                ),
                OutlinedButton.icon(
                  onPressed: openEmail,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: _cIndigo,
                    side: const BorderSide(color: _cIndigo, width: 1.4),
                  ),
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

class _QuickFact extends StatelessWidget {
  final IconData icon;
  final String label;

  const _QuickFact({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: const Color(0xffC7D2FE)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: _cIndigo),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xff334155),
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
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

            // White circular background behind the image
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: ClipOval(
                child: Image.asset(
                  imagePath,
                  width: double.infinity,
                  height: double.infinity,

                  // Shows the complete image without cropping.
                  fit: BoxFit.fill,

                  alignment: Alignment.center,

                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(
                        Icons.person,
                        size: 100,
                        color: Color(0xff2563EB),
                      ),
                    );
                  },
                ),
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
            _GradientEyebrow(text: smallTitle),
            const SizedBox(height: 14),
            Text(
              title,
              style: GoogleFonts.poppins(
                color: const Color(0xff0F172A),
                fontSize: constraints.maxWidth < 600 ? 26 : 34,
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
        _IconBadge(icon: icon, size: 40, iconSize: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: GoogleFonts.poppins(
              color: const Color(0xff0F172A),
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

// =============================================================
// PROFESSIONAL INFORMATION CARD
// UPDATE: now takes an `openWhatsApp` callback and shows a
// WhatsApp row between LinkedIn and Email.
// =============================================================
class _ContactInformationCard extends StatelessWidget {
  final VoidCallback openLinkedIn;
  final VoidCallback openEmail;
  final VoidCallback openWhatsApp;

  const _ContactInformationCard({
    required this.openLinkedIn,
    required this.openEmail,
    required this.openWhatsApp,
  });

  @override
  Widget build(BuildContext context) {
    // Signature card for this section: a subtle brand-gradient
    // border (built from two nested containers, since Flutter
    // has no native gradient-border property) makes this the one
    // "boldest" card on the page, while every other card keeps a
    // quieter, single-tone border.
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_cIndigo, _cCyan],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(21),
        boxShadow: [
          BoxShadow(
            color: _cIndigo.withOpacity(0.18),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      padding: const EdgeInsets.all(1.5),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: const Color(0xffF8FAFC),
          borderRadius: BorderRadius.circular(19.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Professional Information",
              style: GoogleFonts.poppins(
                color: const Color(0xff0F172A),
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 28),

            _ContactItem(
              icon: Icons.location_on_outlined,
              title: "Location",
              value: location,
            ),

            _ContactItem(
              icon: Icons.link,
              title: "LinkedIn",
              value: linkedInDisplay,
              showExternalIcon: true,
              onTap: openLinkedIn,
            ),

            _ContactItem(
              icon: Icons.chat_bubble_outline,
              title: "WhatsApp",
              value: whatsappDisplay,
              showExternalIcon: true,
              onTap: openWhatsApp,
            ),

            _ContactItem(
              icon: Icons.email_outlined,
              title: "Email",
              value: emailDisplay,
              showExternalIcon: true,
              onTap: openEmail,
              last: true,
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================
// CONTACT ITEM
//
// There is NO Row around "email text + external icon", so the
// email can never create horizontal overflow.
// =============================================================
class _ContactItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final bool showExternalIcon;
  final bool last;
  final VoidCallback? onTap;

  const _ContactItem({
    required this.icon,
    required this.title,
    required this.value,
    this.showExternalIcon = false,
    this.last = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: last ? 0 : 24,
      ),

      child: Material(
        color: Colors.transparent,

        child: InkWell(
          onTap: onTap,

          borderRadius: BorderRadius.circular(12),

          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 6,
              horizontal: 4,
            ),

            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                _IconBadge(icon: icon, size: 38, iconSize: 18),

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

                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              value,

                              softWrap: true,

                              style: TextStyle(
                                color: onTap != null
                                    ? _cIndigo
                                    : const Color(0xff0F172A),

                                fontSize: 15,
                                height: 1.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),

                          if (showExternalIcon) ...[
                            const SizedBox(width: 8),

                            const Icon(
                              Icons.open_in_new,
                              size: 17,
                              color: Color(0xff475569),
                            ),
                          ],
                        ],
                      ),
                    ],
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
              child: _SkillCard(icon: skill.icon, title: skill.title),
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

class _SkillCard extends StatefulWidget {
  final IconData icon;
  final String title;

  const _SkillCard({
    required this.icon,
    required this.title,
  });

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hovered = true),
      onExit: (_) => setState(() => hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 26),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: hovered ? _cIndigo.withOpacity(0.4) : const Color(0xffE2E8F0),
          ),
          boxShadow: hovered
              ? [
            BoxShadow(
              color: _cIndigo.withOpacity(0.18),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ]
              : [],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _IconBadge(icon: widget.icon, size: 56, iconSize: 28),
            const SizedBox(height: 14),
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xff0F172A),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// =============================================================
// RESPONSIVE CERTIFICATIONS
// =============================================================

class _ResponsiveCertifications extends StatelessWidget {
  const _ResponsiveCertifications();

  @override
  Widget build(BuildContext context) {
    const certifications = [
      _CertificationData(
        title: "Google Prompting Essentials Specialization",
        issuer: "Google",
        completedDate: "August 2025",
        link: "https://coursera.org/share/dcdaf428205599c559ebbc5c8a5b6bd6",
        description:
        "Completed a multi-course specialization focused on effective prompting and practical generative AI applications.\n\n"
            "Included Courses:\n"
            "• Start Writing Prompts like a Pro\n"
            "• Design Prompts for Everyday Work Tasks\n"
            "• Speed Up Data Analysis and Presentation Building\n"
            "• Use AI as a Creative or Expert Partner",
        icon: Icons.auto_awesome_outlined,
      ),

      _CertificationData(
        title:
        "Google IT Automation with Python Professional Certificate",
        issuer: "Google",
        completedDate: "June 2025",
        link: "https://coursera.org/share/2a87c3ab9fc13afb59efbd6e4ef1113e",
        description:
        "Completed a multi-course professional certificate focused on Python automation, version control, troubleshooting, configuration management, and cloud technologies.\n\n"
            "Included Courses:\n"
            "• Crash Course on Python\n"
            "• Using Python to Interact with the Operating System\n"
            "• Introduction to Git and GitHub\n"
            "• Troubleshooting and Debugging Techniques\n"
            "• Configuration Management and the Cloud\n"
            "• Automating Real-World Tasks with Python",
        icon: Icons.terminal_outlined,
      ),
      _CertificationData(
        title:
        "Flutter and Dart: Developing iOS, Android, and Mobile Apps",
        issuer: "IBM",
        link: "https://coursera.org/share/4c10ad295ce4d5c45e1bbe9c08aaa1cb",
        completedDate: "July 2026",
        description:
        "Covered Flutter and Dart fundamentals, responsive UI development, application architecture, and cross-platform mobile app development.",
        icon: Icons.flutter_dash,
      ),

      _CertificationData(
        title: "The Nuts and Bolts of Machine Learning",
        issuer: "Google",
        link: "https://coursera.org/share/bb5a86713e4377bba5f356eda6054d7b",
        completedDate: "September 2025",
        description:
        "Developed practical knowledge of machine learning models, model evaluation, feature engineering, and supervised learning techniques.",
        icon: Icons.psychology_outlined,
      ),

      _CertificationData(
        title: "Foundations of Project Management",
        issuer: "Google",
        link: "https://coursera.org/share/d036cf46af5636920aaf8ae402ff253f",
        completedDate: "September 2025",
        description:
        "Covered project management fundamentals, project life cycles, organizational structures, stakeholder management, and effective project planning.",
        icon: Icons.account_tree_outlined,
      ),

      _CertificationData(
        title: "What is Data Science?",
        issuer: "IBM",
        link: "https://coursera.org/share/ebdfca900192401fa5cdb054dd49ffa1",
        completedDate: "August 2025",
        description:
        "Introduced data science concepts, the work of data scientists, common tools, methodologies, and real-world applications of data-driven problem solving.",
        icon: Icons.analytics_outlined,
      ),

      _CertificationData(
        title: "Work Smarter with Microsoft Excel",
        issuer: "Microsoft",
        link: "https://coursera.org/share/4fad63c7301da7e70dc7a8214407e35b",
        completedDate: "May 2025",
        description:
        "Developed practical skills in spreadsheet management, formulas, data organization, analysis, and productivity workflows using Microsoft Excel.",
        icon: Icons.table_chart_outlined,
      ),

      _CertificationData(
        title: "AI For Everyone",
        issuer: "DeepLearning.AI",
        link: "https://coursera.org/share/e07599e48cb67b724dd4aecfc41bf01e",
        completedDate: "April 2025",
        description:
        "Covered artificial intelligence fundamentals, AI project workflows, organizational adoption of AI, and the opportunities and limitations of AI technologies.",
        icon: Icons.psychology_alt_outlined,
      ),

      _CertificationData(
        title: "Python for Beginners",
        issuer: "Atomcamp",
        link: "https://drive.google.com/file/d/128H4GHXsT2gqg5N9P4Gwo9ZrfoIxrPoY/view?pli=1",
        completedDate: "",
        description:
        "Covered Python programming fundamentals, variables, data types, control flow, functions, collections, and introductory problem-solving techniques.",
        icon: Icons.code_outlined,
      ),

      _CertificationData(
        title: "Introduction to Cybersecurity Awareness",
        issuer: "HP LIFE",
        link: "https://www.life-global.org/certificate/77a8c2c7-eab0-4b51-9574-ac3b551cb1eb",
        completedDate: "",
        description:
        "Covered cybersecurity fundamentals, common digital threats, safe online practices, data protection, and security awareness for individuals and organizations.",
        icon: Icons.security_outlined,
      ),

      _CertificationData(
        title: "Artificial Intelligence Fundamentals",
        issuer: "Great Learning",
        link: "https://www.mygreatlearning.com/certificate/LULFUXFH",
        completedDate: "",
        description:
        "Introduced core artificial intelligence concepts, machine learning fundamentals, AI applications, and the role of intelligent systems in solving real-world problems.",
        icon: Icons.memory_outlined,
      ),
    ];


    return LayoutBuilder(
      builder: (context, constraints) {
        int columns;

        if (constraints.maxWidth >= 1000) {
          columns = 3;
        } else if (constraints.maxWidth >= 650) {
          columns = 2;
        } else {
          columns = 1;
        }

        const double gap = 20;

        final double cardWidth =
            (constraints.maxWidth - ((columns - 1) * gap)) /
                columns;

        return Wrap(
          spacing: gap,
          runSpacing: gap,
          alignment: WrapAlignment.start,
          children: certifications.map((certification) {
            return SizedBox(
              width: cardWidth,
              child: _CertificationCard(
                title: certification.title,
                issuer: certification.issuer,
                description: certification.description,
                icon: certification.icon,
                link: certification.link,
              ),
            );
          }).toList(),
        );
      },
    );
  }
}


// =============================================================
// CERTIFICATION DATA
// =============================================================

class _CertificationData {
  final String title;
  final String issuer;
  final String description;
  final String link;
  final IconData icon;

  const _CertificationData({
    required this.title,
    required this.issuer,
    required this.description,
    required this.link,
    required this.icon,
    required completedDate,
  });
}

// =============================================================
// CERTIFICATION CARD
//
// UPDATE: cards are now clickable when a `link` is supplied -
// tapping opens the certificate in the browser. A small
// "View Certificate" row with an external-link icon is shown
// at the bottom of the card so it's clear it's tappable.
// =============================================================

class _CertificationCard extends StatefulWidget {
  final String title;
  final String issuer;
  final String description;
  final IconData icon;
  final String link;

  const _CertificationCard({
    required this.title,
    required this.issuer,
    required this.description,
    required this.icon,
    required this.link,
  });

  @override
  State<_CertificationCard> createState() =>
      _CertificationCardState();
}


class _CertificationCardState
    extends State<_CertificationCard> {
  bool hovered = false;

  Future<void> _openCertificateLink() async {
    if (widget.link.isEmpty) {
      return;
    }

    final Uri? url = Uri.tryParse(widget.link);

    if (url == null) {
      return;
    }

    try {
      final bool opened = await launchUrl(
        url,
        mode: LaunchMode.platformDefault,
        webOnlyWindowName: "_blank",
      );

      if (!opened && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Could not open the certificate link."),
          ),
        );
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Could not open the certificate link."),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool hasLink = widget.link.isNotEmpty;

    return MouseRegion(
      onEnter: (_) {
        setState(() {
          hovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          hovered = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),

        transform: Matrix4.translationValues(
          0,
          hovered ? -6 : 0,
          0,
        ),

        width: double.infinity,

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(16),

          border: Border.all(
            color: hovered
                ? const Color(0xff93C5FD)
                : const Color(0xffE2E8F0),
          ),

          boxShadow: [
            BoxShadow(
              color: hovered
                  ? _cIndigo.withOpacity(0.16)
                  : Colors.black.withOpacity(0.03),
              blurRadius: hovered ? 26 : 8,
              offset: const Offset(0, 8),
            ),
          ],
        ),

        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: hasLink ? _openCertificateLink : null,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _IconBadge(icon: widget.icon, size: 44, iconSize: 22),

                      const SizedBox(width: 14),

                      Expanded(
                        child: Text(
                          widget.title,
                          softWrap: true,
                          style: GoogleFonts.poppins(
                            color: const Color(0xff0F172A),
                            fontSize: 19,
                            height: 1.3,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  Text(
                    widget.issuer,
                    style: const TextStyle(
                      color: _cIndigo,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    widget.description,
                    softWrap: true,
                    style: const TextStyle(
                      color: Color(0xff475569),
                      fontSize: 14.5,
                      height: 1.6,
                    ),
                  ),

                  if (hasLink) ...[
                    const SizedBox(height: 18),
                    Row(
                      children: const [
                        Text(
                          "View Certificate",
                          style: TextStyle(
                            color: _cIndigo,
                            fontSize: 13.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: 6),
                        Icon(
                          Icons.open_in_new,
                          size: 15,
                          color: _cIndigo,
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
// =============================================================
// RESPONSIVE PROJECTS
//
// FIX: previously every card was given a fixed height via
// SizedBox(height: cardHeight). Because descriptions vary in
// length, cards with longer text overflowed that fixed box
// (RenderFlex overflow). Now cards get a fixed WIDTH and only a
// MINIMUM height (a floor, not a ceiling) via ConstrainedBox, so
// the card is always free to grow to fit its own content.
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

        // A floor height only, purely for visual consistency.
        // Cards are always allowed to grow taller than this.
        final double cardMinHeight = columns == 1 ? 260 : 300;

        return Wrap(
          spacing: gap,
          runSpacing: gap,
          alignment: WrapAlignment.start,
          children: List.generate(
            projectList.length,
                (index) {
              return ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: cardWidth,
                  maxWidth: cardWidth,
                  minHeight: cardMinHeight,
                ),
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