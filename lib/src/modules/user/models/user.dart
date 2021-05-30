import 'package:equatable/equatable.dart';

class User extends Equatable {
	final String id;
	final String name;
	final String avatar;
	final String ratings;
	final String totalTeammatesPalyed;
	final String totalTeammatesWon;
	final String winningPercentage;

	const User({
		this.id,
		this.name,
		this.avatar,
		this.ratings,
		this.totalTeammatesPalyed,
		this.totalTeammatesWon,
		this.winningPercentage,
	});

	factory User.fromJson(Map<String, dynamic> json) {
		return User(
			id: json['id'] as String,
			name: json['name'] as String,
			avatar: json['avatar'] as String,
			ratings: json['ratings'] as String,
			totalTeammatesPalyed: json['total_teammates_palyed'] as String,
			totalTeammatesWon: json['total_teammates_won'] as String,
			winningPercentage: json['winning_percentage'] as String,
		);
	}

	Map<String, dynamic> toJson() {
		return {
			'id': id,
			'name': name,
			'avatar': avatar,
			'ratings': ratings,
			'total_teammates_palyed': totalTeammatesPalyed,
			'total_teammates_won': totalTeammatesWon,
			'winning_percentage': winningPercentage,
		};
	}	

	User copyWith({
		String id,
		String name,
		String avatar,
		String ratings,
		String totalTeammatesPalyed,
		String totalTeammatesWon,
		String winningPercentage,
	}) {
		return User(
			id: id ?? this.id,
			name: name ?? this.name,
			avatar: avatar ?? this.avatar,
			ratings: ratings ?? this.ratings,
			totalTeammatesPalyed: totalTeammatesPalyed ?? this.totalTeammatesPalyed,
			totalTeammatesWon: totalTeammatesWon ?? this.totalTeammatesWon,
			winningPercentage: winningPercentage ?? this.winningPercentage,
		);
	}

	@override
	bool get stringify => true;

	@override
	List<Object> get props {
		return [
			id,
			name,
			avatar,
			ratings,
			totalTeammatesPalyed,
			totalTeammatesWon,
			winningPercentage,
		];
	}
}
