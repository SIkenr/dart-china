part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<String> slugs;
  final List<SearchResult> data;
  final int page;
  final bool more;
  final bool loading;

  SearchSuccess({
    required this.slugs,
    required this.data,
    required this.page,
    required this.more,
    this.loading = false,
  });

  SearchSuccess copyWith({
    List<String>? slugs,
    List<SearchResult>? data,
    int? page,
    bool? more,
    bool? loading,
  }) {
    return SearchSuccess(
      slugs: slugs ?? this.slugs,
      data: data ?? this.data,
      page: page ?? this.page,
      more: more ?? this.more,
      loading: loading ?? this.loading,
    );
  }

  @override
  List<Object> get props => [slugs, data, page, more, loading];
}