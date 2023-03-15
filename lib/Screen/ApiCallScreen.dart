import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:herokuapp/Bloc/bloc_heroku_bloc.dart';
import 'package:herokuapp/Screen/ThirdScreen.dart';

import '../Services/HerokuModel.dart';

class ApiCallScreen extends StatefulWidget {
  const ApiCallScreen({Key? key}) : super(key: key);

  @override
  State<ApiCallScreen> createState() => _ApiCallScreenState();
}

class _ApiCallScreenState extends State<ApiCallScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        BlocBuilder<HerokuBloc, HerokuState>(
          builder: (context, state) {
            if (state is HerokuClickState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is HerokuErrorState) {
              return const Center(child: Text("Something Wrong in this"));
            } else if (state is HerokuLoadedState) {
              HerokuPizza data = state.heroku;
              return pizzaWidget(data);
            } else {
              return Container();
            }
          },
        ),
        ElevatedButton(
          onPressed: () {
            if (mounted == true) {
              context.read<HerokuBloc>().add(ClickEvent(HerokuPizza()));
            } else {
              return null;
            }
          },
          child: const Text("Click Me",
              style: TextStyle(fontSize: 20, color: Colors.black)),
        )
      ],
    ));
  }

  Widget pizzaWidget(HerokuPizza data) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 1.2,
          child: ListView.builder(
              itemCount: data.recipes!.length,
              itemBuilder: (_, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: Card(
                      child: ListTile(
                    leading:
                        Image.network(data.recipes![index].imageUrl.toString()),
                    title: Text(
                      data.recipes![index].title.toString(),
                      style: const TextStyle(color: Colors.black),
                    ),
                  )),
                );
              }),
        ),
      ],
    );
  }
}
