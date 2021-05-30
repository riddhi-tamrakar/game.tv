import 'package:app/src/modules/home/models/tournament.dart';

class TournamentResponse {
  final List<Tournament> list;
  final String cursor;

  const TournamentResponse({
    this.list,
    this.cursor,
  });
}
