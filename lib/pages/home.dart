import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'side_menu.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MUBAS Media"),
        backgroundColor: const Color(0xff0D6EFD),
      ),
      drawer: const SideMenu(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Trending Media 🎥',
                style: GoogleFonts.raleway(
                  textStyle: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              _buildTrendingMedia(),
              const SizedBox(height: 20),
              Text(
                'Categories 📚',
                style: GoogleFonts.raleway(
                  textStyle: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              _buildCategories(),
              const SizedBox(height: 20),
              Text(
                'Recently Watched ⏮️',
                style: GoogleFonts.raleway(
                  textStyle: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              _buildRecentlyWatched(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrendingMedia() {
    return SizedBox(
      height: 200,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            width: 150,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(
                    'assets/media_$index.jpg'), // Replace with actual image assets
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 10),
      ),
    );
  }

  Widget _buildCategories() {
    final categories = [
      'Rap Battles',
      'MUBAS Got Talent',
      'Music',
      'Social Weekend Highlights',
      'Live'
    ];
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: categories.map((category) {
        return Chip(
          label: Text(
            category,
            style: GoogleFonts.raleway(
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          backgroundColor: const Color(0xff0D6EFD),
          labelStyle: const TextStyle(color: Colors.white),
        );
      }).toList(),
    );
  }

  Widget _buildRecentlyWatched() {
    return Column(
      children: List.generate(3, (index) {
        return ListTile(
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(
                    'assets/recent_$index.jpg'), // Replace with actual image assets
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(
            'Media Title $index',
            style: GoogleFonts.raleway(
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          subtitle: const Text('Genre | Duration'),
          trailing: const Icon(Icons.play_arrow, color: Color(0xff0D6EFD)),
          onTap: () {
            // Add navigation to media details
          },
        );
      }),
    );
  }
}
