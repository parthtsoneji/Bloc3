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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            if (!_canShowButton)
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: ElevatedButton(
                  onPressed: () {
                    context.read<HerokuBloc>().add(ClickEvent(HerokuPizza()));
                    setState(() {
                      _canShowButton = true;
                    });
                  },
                  child: Text('Click Me..!!!'),
                ),
              ),
            BlocListener<HerokuBloc, HerokuState>(
              listener: (context, state) {
                if (state is HerokuLoadingState) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Loading")));
                }
              },
              child: BlocBuilder<HerokuBloc, HerokuState>(
                builder: (context, state) {
                  if (state is HerokuLoadingState) {
                    _canShowButton = false;
                    Center(child: CircularProgressIndicator());
                  }
                  if (state is HerokuErrorState) {
                    return const Center(child: Text("Something Wrong in this"));
                  }
                  if (state is HerokuLoadedState) {
                    HerokuPizza data = state.heroku;
                    return pizzaWidget(data);
                  }
                  return Container();
                },
              ),
            )
          ],
        ));
  }

  Widget pizzaWidget(HerokuPizza data) {
    return Expanded(
      flex: 1,
      child: ListView.builder(
          itemCount: data.recipes!.length,
          itemBuilder: (_, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Card(
                  child: ListTile(
                    leading: Image.network(data.recipes![index].imageUrl.toString(),
                        width: 80),
                    title: Text(
                      data.recipes![index].title.toString(),
                      style: const TextStyle(color: Colors.black),
                    ),
                  )),
            );
          }),
    );
  }
}
