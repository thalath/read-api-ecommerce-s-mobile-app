import 'package:assignment_1/state_provder/theme_logic.dart';
import 'package:assignment_1/views/widgets/profile_stat.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    bool isNotifier = false;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: 1200),
              child: Column(
                children: [
                  // HEADER
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Colors.purple.shade300,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      children: [
                        // PROFILE IMAGE
                        Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Theme.of(context).colorScheme.onPrimary,
                              width: 4,
                            ),
                            image: const DecorationImage(
                              image: NetworkImage("https://i.pravatar.cc/300"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // NAME
                        Text(
                          "Sovan",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 6),

                        // EMAIL
                        Text(
                          "sovan@gmail.com",
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).colorScheme.onPrimary.withOpacity(0.9),
                            fontSize: 15,
                          ),
                        ),

                        const SizedBox(height: 20),

                        // STATS
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ProfileStat(value: "12", title: "Orders"),
                            ProfileStat(value: "24", title: "Wishlist"),
                            ProfileStat(value: "8", title: "Favorites"),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ACCOUNT SECTION
                  _sectionTitle("Account"),

                  const SizedBox(height: 14),

                  _profileTile(
                    context,
                    icon: Icons.person_outline,
                    title: "Edit Profile",
                    onTap: () {},
                  ),

                  _profileTile(
                    context,
                    icon: Icons.location_on_outlined,
                    title: "Shipping Address",
                    onTap: () {},
                  ),

                  _profileTile(
                    context,
                    icon: Icons.payment_outlined,
                    title: "Payment Methods",
                    onTap: () {},
                  ),

                  _profileTile(
                    context,
                    icon: Icons.history,
                    title: "Order History",
                    onTap: () {},
                  ),

                  const SizedBox(height: 24),

                  // SETTINGS SECTION
                  _sectionTitle("Settings"),

                  const SizedBox(height: 14),

                  _profileTile(
                    context,
                    icon: Icons.notifications_none,
                    title: "Notifications",
                    trailing: Switch(
                      value: isNotifier,
                      activeThumbColor: Theme.of(context).colorScheme.primary,
                      onChanged: (isNotifier) {
                        setState(() {
                          isNotifier = !isNotifier;
                        });
                      },
                    ),
                  ),

                  _profileTile(
                    context,
                    icon: Icons.dark_mode_outlined,
                    title: "Dark Mode",
                    trailing: Switch(
                      value: !context.watch<ThemeLogic>().isLight,
                      activeThumbColor: Theme.of(context).colorScheme.primary,
                      onChanged: (value) {
                        context.read<ThemeLogic>().toggleToSwitchMode();
                      },
                    ),
                  ),

                  _profileTile(
                    context,
                    icon: Icons.language_outlined,
                    title: "Language",
                    subtitle: "English",
                    onTap: () {},
                  ),

                  const SizedBox(height: 24),

                  // LOGOUT BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      onPressed: () {},
                      icon: const Icon(Icons.logout, color: Colors.white),
                      label: const Text(
                        "Logout",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // PROFILE TILE
  Widget _profileTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 48,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon, color: Theme.of(context).colorScheme.primary),
        ),

        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),

        subtitle: subtitle != null ? Text(subtitle) : null,

        trailing: trailing ?? const Icon(Icons.arrow_forward_ios_rounded),

        onTap: onTap,
      ),
    );
  }

  // SECTION TITLE
  Widget _sectionTitle(String title) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
