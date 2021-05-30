import 'package:equatable/equatable.dart';

class Tournament extends Equatable {
	final String name;
	final String gameName;
	final String coverUrl;

	const Tournament({
		this.name,
		this.gameName,
		this.coverUrl,
	});

	factory Tournament.fromJson(Map<String, dynamic> json) {
		return Tournament(
			name: json['name'] as String,
			gameName: json['game_name'] as String,
			coverUrl: json['cover_url'] as String,
		);
	}

	Map<String, dynamic> toJson() {
		return {
			'name': name,
			'game_name': gameName,
			'cover_url': coverUrl,
		};
	}	

	Tournament copyWith({
		String name,
		String gameName,
		String coverUrl,
	}) {
		return Tournament(
			name: name ?? this.name,
			gameName: gameName ?? this.gameName,
			coverUrl: coverUrl ?? this.coverUrl,
		);
	}

	@override
	bool get stringify => true;

	@override
	List<Object> get props => [name, gameName, coverUrl];
}
