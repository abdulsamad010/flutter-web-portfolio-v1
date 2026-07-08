import 'package:flutter/material.dart';
import 'package:portfolio/constants/constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/project_model.dart';

class ProjectWidget extends StatefulWidget {
  final Project projectData;

  const ProjectWidget({
    super.key,
    required this.projectData,
  });

  @override
  State<ProjectWidget> createState() => _ProjectWidgetState();
}

class _ProjectWidgetState extends State<ProjectWidget> {
  // Used to detect mouse hover on desktop/web.
  bool isHovered = false;

  bool get _hasLink => widget.projectData.link.trim().isNotEmpty;

  Future<void> _openLink() async {
    if (!_hasLink) return;

    final Uri? url = Uri.tryParse(widget.projectData.link.trim());

    if (url == null) return;

    try {
      final bool canOpen = await canLaunchUrl(url);
      if (canOpen) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Couldn't open this link.")),
        );
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Couldn't open this link.")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      // Mouse entered the project card.
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },

      // Mouse left the project card.
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },

      child: AnimatedContainer(
        // Smooth hover animation.
        duration: const Duration(milliseconds: 250),

        // Move card slightly upward when hovered.
        transform: Matrix4.translationValues(
          0,
          isHovered ? -6 : 0,
          0,
        ),

        // Use all width given by the parent widget.
        width: double.infinity,

        // IMPORTANT:
        //
        // Do not give a fixed height here. The card grows to fit
        // its own content (mainAxisSize.min below), so long
        // descriptions never overflow.

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color:
            isHovered ? const Color(0xff93C5FD) : const Color(0xffE2E8F0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isHovered ? 0.10 : 0.03),
              blurRadius: isHovered ? 24 : 8,
              offset: const Offset(0, 8),
            ),
          ],
        ),

        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            // Card uses only the height required by its content.
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ==================================================
              // PROJECT NAME
              // ==================================================
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xffEFF6FF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.auto_awesome_outlined,
                      color: Color(0xff2563EB),
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Expanded gives the project name only the
                  // remaining horizontal space. If the project
                  // name is long, it automatically wraps.
                  Expanded(
                    child: Text(
                      widget.projectData.name,
                      softWrap: true,
                      style: kSectionTitleText.copyWith(height: 1.25),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // ==================================================
              // PROJECT DESCRIPTION
              // ==================================================
              Text(
                widget.projectData.description,
                softWrap: true,
                style: const TextStyle(
                  color: Color(0xff475569),
                  height: 1.6,
                  fontSize: 14.5,
                ),
              ),

              const SizedBox(height: 24),

              // ==================================================
              // DIVIDER
              // ==================================================
              const Divider(height: 1),

              const SizedBox(height: 16),

              // ==================================================
              // VIEW PROJECT BUTTON
              //
              // FIX: several projects have an empty link (""),
              // which previously would either crash or silently
              // do nothing when tapped. Now, if there is no link,
              // the button is clearly disabled and honestly
              // labeled instead of pretending to work.
              // ==================================================
              Align(
                alignment: Alignment.centerRight,
                child: _hasLink
                    ? ElevatedButton.icon(
                  onPressed: _openLink,
                  icon: const Icon(Icons.arrow_outward, size: 16),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 15,
                    ),
                  ),
                  label: Text(
                    "View Project",
                    style: kSubTitleText.copyWith(color: Colors.white),
                  ),
                )
                    : OutlinedButton.icon(
                  onPressed: null,
                  icon: const Icon(Icons.lock_outline, size: 16),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 15,
                    ),
                    disabledForegroundColor: const Color(0xff94A3B8),
                    side: const BorderSide(color: Color(0xffE2E8F0)),
                  ),
                  label: Text(
                    "Not Publicly Available",
                    style: kSubTitleText.copyWith(
                      color: const Color(0xff94A3B8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}