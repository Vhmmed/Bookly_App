import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../home/manager/for_search_cubit/search_cubit.dart';

class SearchViewBody extends StatefulWidget {
  const SearchViewBody({Key? key}) : super(key: key);

  @override
  State<SearchViewBody> createState() => _SearchViewBodyState();
}

class _SearchViewBodyState extends State<SearchViewBody> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),

          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search for books...',
              suffixIcon: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  final query = _searchController.text.trim();
                  if (query.isNotEmpty) {
                    context.read<SearchCubit>().searchBooks(query);
                  }
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onSubmitted: (query) {
              if (query.isNotEmpty) {
                context.read<SearchCubit>().searchBooks(query);
              }
            },
          ),

          const SizedBox(height: 20),

          Expanded(
            child: BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                return _buildResults(state);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResults(SearchState state) {
    if (state is SearchInitial) {
      return const Center(
        child: Text('Enter a search term to find books'),
      );
    } else if (state is SearchLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is SearchSuccess) {
      if (state.books.isEmpty) {
        return const Center(
          child: Text('No books found'),
        );
      }

      return ListView.builder(
        itemCount: state.books.length,
        itemBuilder: (context, index) {
          final book = state.books[index];
          return ListTile(
            leading: book.volumeInfo.imageLinks?.thumbnail != null
                ? Image.network(
              book.volumeInfo.imageLinks!.thumbnail!,
              width: 50,
              height: 70,
              fit: BoxFit.cover,
            )
                : const SizedBox(
              width: 50,
              height: 70,
              child: Icon(Icons.book),
            ),
            title: Text(
              book.volumeInfo.title ?? 'No Title',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              book.volumeInfo.authors?.join(', ') ?? 'Unknown Author',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          );
        },
      );
    } else if (state is SearchFailure) {
      return Center(
        child: Text('Error: ${state.errorMessage}'),
      );
    } else {
      return const Center(
        child: Text('Unknown state'),
      );
    }
  }
}