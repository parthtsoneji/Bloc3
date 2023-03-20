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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [


        BlocListener<HerokuBloc, HerokuState>(
          listener: (context, state) {
            if (state is HerokuLoadingState) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Center(child: CircularProgressIndicator())));
            }
            if(state is HerokuLoadedState){
              HerokuPizza data =  state.heroku;
              ScaffoldMessenger.of(context).showSnackBar( SnackBar(content:  pizzaWidget(data)));
            }
          },
          child:
          Padding(
            padding: const EdgeInsets.only(top: 100,left: 100),
            child: ElevatedButton(
              onPressed: () {
                context.read<HerokuBloc>().add(ClickEvent(HerokuPizza()));

              },
              child: const Text('Click Me..!!!'),
            ),
          )
        )
      ],
    ));
  }

  Widget pizzaWidget(HerokuPizza data) {
    return Column(
      children: [
        Expanded(
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
        ),
      ],
    );
  }
}
