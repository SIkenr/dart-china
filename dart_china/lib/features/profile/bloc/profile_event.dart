part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileOpen extends ProfileEvent {
  final String username;

  ProfileOpen({
    required this.username,
  });
}