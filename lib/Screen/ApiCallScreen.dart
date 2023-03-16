import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:herokuapp/Bloc/bloc_heroku_bloc.dart';
import 'package:snackbar/snackbar.dart';
import '../Services/HerokuModel.dart';

class ApiCallScreen extends StatefulWidget {
  const ApiCallScreen({Key? key}) : super(key: key);

  @override
  State<ApiCallScreen> createState() => _ApiCallScreenState();
}

class _ApiCallScreenState extends State<ApiCallScreen> {
  int index = 0;
  bool _canShowButton = false;
  bool builer = true;

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
              child: const Text('Click Me..!!!'),
            ),
          ),
        BlocListener<HerokuBloc, HerokuState>(
          listener: (context, state) {
            // if (state is HerokuLoadingState) {
            //   ScaffoldMessenger.of(context)
            //       .showSnackBar(const SnackBar(content: Text("Loading")));
            // }
            if (state is HerokuLoadingState) {
              _canShowButton = false;
              ScaffoldMessenger.of(context)..showSnackBar(const SnackBar(
                    content: Center(child: CircularProgressIndicator())));
            }
            else if(state is HerokuLoadedState){
              HerokuPizza data =  state.heroku;
              Scaffold.of(context).setState(() {
                pizzaWidget(data);
              });
            }
          },
          child: Text("Hello")
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
