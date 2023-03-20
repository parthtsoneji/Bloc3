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
  bool _canShowButton = false;
  HerokuPizza? demo;

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            if (!_canShowButton)
              Center(
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
                if (state is HerokuLoadedState) {
                  setState(() {
                    demo = state.heroku;
                  });
                }
              },
              child: demo == null
                  ? CircularProgressIndicator()
                  : Expanded(
                child: ListView.builder(
                  itemCount: demo!.recipes!.length,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      child: Card(
                        child: ListTile(
                          leading: Image.network(
                            demo!.recipes![index].imageUrl.toString(),
                            width: 80,
                          ),
                          title: Text(
                            demo!.recipes![index].title.toString(),
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}