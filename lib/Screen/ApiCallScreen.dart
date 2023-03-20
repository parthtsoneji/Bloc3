import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:herokuapp/Bloc/bloc_heroku_bloc.dart';
import '../Services/HerokuModel.dart';

class ApiCallScreen extends StatefulWidget {
  const ApiCallScreen({Key? key}) : super(key: key);

  @override
  State<ApiCallScreen> createState() => _ApiCallScreenState();
}

class _ApiCallScreenState extends State<ApiCallScreen> {
  int index = 0;
  bool _canShowButton = false;

  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (p0, p1) {
          return BlocListener<HerokuBloc, HerokuState>(
              listener: (context, state) {
                if (state is HerokuLoadingState) {
                  setState(() {
                    _canShowButton = true;
                  });
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const Scaffold(
                          body: Center(
                              child: CircularProgressIndicator()))));
                }
                if (state is HerokuLoadedState) {
                  HerokuPizza data = state.heroku;
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => Scaffold(
                            body: Column(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: ListView.builder(
                                      itemCount: data.recipes!.length,
                                      itemBuilder: (_, index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4, horizontal: 8),
                                          child: Card(
                                              child: ListTile(
                                            leading: Image.network(
                                                data.recipes![index].imageUrl
                                                    .toString(),
                                                width: 80),
                                            title: Text(
                                              data.recipes![index].title
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ),
                                          )),
                                        );
                                      }),
                                ),
                              ],
                            ),
                          )));
                }
              },
              child: Column(children: [
                if (!_canShowButton)
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        context
                            .read<HerokuBloc>()
                            .add(ClickEvent(HerokuPizza()));
                        setState(() {
                          _canShowButton = true;
                        });
                      },
                      child: const Text('Click Me..!!!'),
                    ),
                  ),
              ]));
        },
      ),
    );
  }
}
