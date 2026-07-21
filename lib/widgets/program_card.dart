import 'package:flutter/material.dart';

import '../services/favorites_service.dart';

class ProgramCard extends StatefulWidget {
  final Map<String, dynamic> location;
  final VoidCallback onTap;

  const ProgramCard({
    super.key,
    required this.location,
    required this.onTap,
  });

  @override
  State<ProgramCard> createState() => _ProgramCardState();
}

class _ProgramCardState extends State<ProgramCard> {
  bool favorite = false;

  @override
  void initState() {
    super.initState();
    loadFavorite();
  }

  Future<void> loadFavorite() async {
    favorite = await FavoritesService.isFavorite(widget.location["id"]);
    if (mounted) setState(() {});
  }

  Future<void> toggleFavorite() async {
    if (favorite) {
      await FavoritesService.removeFavorite(widget.location["id"]);
    } else {
      await FavoritesService.addFavorite(widget.location);
    }

    setState(() {
      favorite = !favorite;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 900),
        content: Text(
          favorite
              ? "Added to Favorites ❤️"
              : "Removed from Favorites",
        ),
      ),
    );
  }

  IconData getSportIcon() {
    final sport =
        (widget.location["sport"] ?? "").toString().toLowerCase();

    if (sport.contains("basketball")) {
      return Icons.sports_basketball;
    }

    if (sport.contains("soccer")) {
      return Icons.sports_soccer;
    }

    if (sport.contains("badminton")) {
      return Icons.sports_tennis;
    }

    if (sport.contains("pickleball")) {
      return Icons.sports_tennis;
    }

    if (sport.contains("volleyball")) {
      return Icons.sports_volleyball;
    }

    if (sport.contains("baseball")) {
      return Icons.sports_baseball;
    }

    if (sport.contains("hockey")) {
      return Icons.sports_hockey;
    }

    if (sport.contains("football")) {
      return Icons.sports_football;
    }

    return Icons.sports;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: widget.onTap,
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.only(bottom: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(.15),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      getSportIcon(),
                      color: Colors.orange,
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.location["name"] ?? "",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.location["city"] ?? "",
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),

                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: IconButton(
                      key: ValueKey(favorite),
                      onPressed: toggleFavorite,
                      icon: Icon(
                        favorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: favorite ? Colors.red : Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Text(
                widget.location["programName"] ?? "",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  const Icon(
                    Icons.calendar_today,
                    size: 17,
                    color: Colors.orange,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.location["days"] ?? "",
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              Row(
                children: [
                  const Icon(
                    Icons.attach_money,
                    size: 17,
                    color: Colors.orange,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.location["pricing"] ?? "",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}