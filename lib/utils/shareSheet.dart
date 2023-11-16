import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

void showShareBottomSheet(BuildContext context) {
  showModalBottomSheet(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    context: context,
    builder: (BuildContext context) {
      return Expanded(
        child: Container(
          padding: EdgeInsets.all(16),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            ),
            shrinkWrap: true,
            itemCount: shareOptions.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  // Handle the selected share option
                  Navigator.pop(context);
                  // Call the corresponding function based on the selected index
                  shareOptions[index].onTap();
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      shareOptions[index].icon,
                      size: 30,
                      shadows: [
                        Shadow(
                            blurRadius: 5,
                            color: Colors.grey,
                            offset: Offset(0.5, 0.5))
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      shareOptions[index].label,
                      style: GoogleFonts.inter(),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );
    },
  );
}

class ShareOption {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  ShareOption({
    required this.icon,
    required this.label,
    required this.onTap,
  });
}

// Define your share options here
final List<ShareOption> shareOptions = [
  ShareOption(
    icon: Icons.textsms,
    label: 'SMS',
    onTap: () {
      // Handle share via SMS
    },
  ),
  ShareOption(
    icon: Icons.email,
    label: 'Email',
    onTap: () {
      // Handle share via email
    },
  ),
  ShareOption(
    icon: Icons.facebook,
    label: 'Facebook',
    onTap: () {
      // Handle share via other apps
    },
  ),
  ShareOption(
    icon: FontAwesomeIcons.instagram,
    label: 'Instagram',
    onTap: () {
      // Handle share via other apps
    },
  ),
  ShareOption(
    icon: FontAwesomeIcons.snapchat,
    label: 'Snapchat',
    onTap: () {
      // Handle share via other apps
    },
  ),
  ShareOption(
    icon: FontAwesomeIcons.telegram,
    label: 'Telegram',
    onTap: () {
      // Handle share via other apps
    },
  ),
  ShareOption(
    icon: FontAwesomeIcons.twitter,
    label: 'Twitter',
    onTap: () {
      // Handle share via other apps
    },
  ),
  ShareOption(
    icon: FontAwesomeIcons.linkedin,
    label: 'LinkedIn',
    onTap: () {
      // Handle share via other apps
    },
  ),
  ShareOption(
    icon: Icons.download_rounded,
    label: 'Download',
    onTap: () {
      // Handle share via other apps
    },
  ),
  ShareOption(
    icon: FontAwesomeIcons.commentDots,
    label: 'others',
    onTap: () {
      // Handle share via other apps
    },
  ),
];
