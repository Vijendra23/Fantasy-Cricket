import 'package:flutter/material.dart';

import '../../../data/models/player.dart';

class PlayerCard extends StatelessWidget {
  final Player player;
  final bool selected;
  final VoidCallback onTap;
  final bool showAddRemove;

  const PlayerCard(
      {super.key,
      required this.player,
      required this.selected,
      required this.onTap,
      this.showAddRemove = false});

  Color _teamColor(String team) {
    switch (team) {
      case 'IND':
        return Colors.blue;
      case 'AUS':
        return Colors.yellow[800]!;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: selected ? 4 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: selected ? const BorderSide(color: Colors.green, width: 2) : BorderSide.none,
      ),
      color: selected ? Colors.green[50] : Colors.white,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _teamColor(player.team),
          child: Text(player.team, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        title: Text(player.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('${player.role} • ${player.points} pts'),
        trailing: showAddRemove
            ? IconButton(
                icon: Icon(selected ? Icons.remove_circle : Icons.add_circle,
                    color: selected ? Colors.red : Colors.blue),
                onPressed: onTap,
              )
            : (selected ? const Icon(Icons.check_circle, color: Colors.green) : null),
        onTap: showAddRemove ? null : onTap,
      ),
    );
  }
} 