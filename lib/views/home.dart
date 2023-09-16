import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:fenix/components/movie_card.dart';
import 'package:fenix/config/app_config.dart';
import 'package:fenix/models/movie_model.dart';
import 'package:fenix/repositories/movie_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _searchController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  List<MovieModel> moviesList = [];
  bool _listView = true;
  int _currentPage = 1;
  bool _isLoadingNextPage = false;
  bool _hasError = false;
  int _lastPage = 1;

  Timer? _debounce;

  void _onSearchChanged(String v) {
    setState(() {
      moviesList = [];
      _currentPage = 1;
    });
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if(v != "" && v.length >= 2) {
        setState(() {
          _loadMovies();
          /// api istek
        });
      }else {
        setState(() {
          /// Arama yap uyarısı ver
        });
      }
    });
  }

  void _loadMovies() async {
    setState(() {
      _isLoadingNextPage = true;
    });
    var res = await MoviesRepository().getMovies(_searchController.text, _currentPage);
    if(res.page > 0) {
      setState(() {
        moviesList.addAll(res.results);
        _currentPage ++;
        _lastPage = res.totalPages;
        _isLoadingNextPage = false;
      });
    } else {
      setState(() {
        _hasError = true;
      });
    }
  }

  void _scrollListener() {
    if(_scrollController.position.extentAfter == 0) {
      if(!_isLoadingNextPage) {
        if(_currentPage <= _lastPage) {
          _loadMovies();
        }
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, () {
      _loadMovies();
    });
    if(!_isLoadingNextPage){
      _scrollController = ScrollController()..addListener(_scrollListener);
    }
    super.initState();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: CupertinoSearchTextField(
                //padding: EdgeInsets.zero,
                controller: _searchController,
                onChanged: (e) {
                  _onSearchChanged(e);
                },
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  SafeArea(
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: moviesList.length,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: !_listView ? 1 : 2,
                        crossAxisSpacing: !_listView ? 0 : 20,
                        mainAxisSpacing: 20,
                        mainAxisExtent: _listView ? 385 : 224,
                      ),
                      itemBuilder: (context, index) {
                        MovieModel movie = moviesList[index];
                        return AnimatedSwitcher(
                            duration: AppConfig.animationDuration,
                          child: _listView ?
                          MovieCard(
                            movie: movie,
                          ) :
                          MovieCard(
                            movie: movie,
                          ),
                        );
                      },
                    ),
                  ),
                  if(_isLoadingNextPage)
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: CupertinoActivityIndicator()
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
