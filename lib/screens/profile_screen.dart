import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // 🎨 MATERIAL COLORS
  static const Color primary = Color(0xFF2563EB);
  static const Color background = Color(0xFFF5F7FB);
  static const Color success = Color(0xFF16A34A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: background,

      // ✅ MATERIAL APP BAR
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,

        title: const Text(
          "Profile",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),

        child: Column(
          children: [

            // ✅ PROFILE CARD
            Material(
              elevation: 1,
              color: Colors.white,

              borderRadius:
                  BorderRadius.circular(30),

              child: Padding(
                padding: const EdgeInsets.all(28),

                child: Column(
                  children: [

                    // AVATAR
                    CircleAvatar(
                      radius: 52,
                      backgroundColor:
                          primary.withOpacity(.12),

                      child: const Text(
                        "EG",
                        style: TextStyle(
                          color: primary,
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // NAME
                    const Text(
                      "FANG VANESSA EGBE",
                      textAlign: TextAlign.center,

                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "Student Matricule: LMUI250800",
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      "Landmark Metropolitan University",
                      textAlign: TextAlign.center,

                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // ACTION BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 50,

                      child: FilledButton.icon(
                        onPressed: () {},

                        icon: const Icon(Icons.edit),

                        label: const Text(
                          "Edit Profile",
                          style: TextStyle(
                            fontWeight:
                                FontWeight.w700,
                          ),
                        ),

                        style: FilledButton.styleFrom(
                          backgroundColor:
                              primary,

                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(
                                    16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ✅ BIO CARD
            profileCard(
              title: "Bio",
              icon: Icons.info_outline_rounded,

              child: Text(
                "I am a Level 400 Software Engineering student at Landmark Metropolitan University. I love building mobile applications and solving real-world problems with code.",

                style: TextStyle(
                  color: Colors.grey.shade700,
                  height: 1.7,
                  fontSize: 15,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ✅ GOALS CARD
            profileCard(
              title: "Top Goals",
              icon: Icons.flag_outlined,

              child: Column(
                children: const [

                  GoalItem(
                    "Master Flutter and Dart",
                  ),

                  GoalItem(
                    "Maintain GPA above 3.8",
                  ),

                  GoalItem(
                    "Pass CA and Exams",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ✅ STATS CARD
            Material(
              elevation: 1,
              color: Colors.white,

              borderRadius:
                  BorderRadius.circular(28),

              child: Padding(
                padding: const EdgeInsets.all(24),

                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceAround,

                  children: [

                    statItem(
                      "12",
                      "Projects",
                    ),

                    statItem(
                      "4",
                      "Apps",
                    ),

                    statItem(
                      "400",
                      "Level",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ PROFILE CARD SECTION
  Widget profileCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {

    return Material(
      elevation: 1,
      color: Colors.white,

      borderRadius:
          BorderRadius.circular(28),

      child: Padding(
        padding: const EdgeInsets.all(22),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Row(
              children: [

                Icon(
                  icon,
                  color: primary,
                ),

                const SizedBox(width: 10),

                Text(
                  title,

                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            child,
          ],
        ),
      ),
    );
  }

  // ✅ STATS ITEM
  Widget statItem(
    String value,
    String label,
  ) {

    return Column(
      children: [

        Text(
          value,

          style: const TextStyle(
            color: primary,
            fontSize: 28,
            fontWeight: FontWeight.w800,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          label,

          style: TextStyle(
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// ✅ GOAL ITEM
class GoalItem extends StatelessWidget {

  final String text;

  const GoalItem(this.text, {super.key});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),

      child: Row(
        children: [

          Container(
            width: 28,
            height: 28,

            decoration: BoxDecoration(
              color: ProfileScreen.success.withOpacity(.12),

              shape: BoxShape.circle,
            ),

            child: const Icon(
              Icons.check_rounded,
              size: 18,
              color: ProfileScreen.success,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Text(
              text,

              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}