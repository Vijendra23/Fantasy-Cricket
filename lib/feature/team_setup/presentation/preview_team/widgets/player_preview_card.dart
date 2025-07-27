import 'package:flutter/material.dart';

import '../../../data/models/player.dart';

class PlayerPreviewCard extends StatelessWidget {
  final Player player;
  final bool isCaptain;
  final bool isViceCaptain;
  final Color color;
  const PlayerPreviewCard({
    super.key,
    required this.player,
    required this.isCaptain,
    required this.isViceCaptain,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.deepPurple.shade200,
                child: Text(
                  player.name.isNotEmpty ? player.name[0] : '?',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  player.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  maxLines: 2,
                  overflow: TextOverflow.visible,
                ),
              ),
              if (isCaptain)
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Tooltip(
                    message: 'Captain',
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text('C', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              if (isViceCaptain)
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Tooltip(
                    message: 'Vice-Captain',
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text('VC', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            '${player.role}  •  ${player.points} pts',
            style: TextStyle(fontSize: 14, color: Colors.grey[800]),
          ),
        ],
      ),
    );
  }
}