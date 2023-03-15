// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:herokuapp/Bloc/bloc_heroku_bloc.dart';
// import 'package:herokuapp/Services/HerokuModel.dart';
//
// class THirdScreen extends StatefulWidget {
//
//   const THirdScreen({Key? key}) : super(key: key);
//
//   @override
//   State<THirdScreen> createState() => _THirdScreenState();
// }
//
// class _THirdScreenState extends State<THirdScreen> {
//
//   int index = 0;
//   HerokuBloc? _herokuBloc;
//   @override
//   void initState() {
//     super.initState();
//     _herokuBloc = HerokuBloc();
//     _herokuBloc != null ? _herokuBloc!.add(ClickEvent(HerokuPizza())) : null;
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _WidgetPizza(),
//     );
//   }
//
//   _WidgetPizza() {
//     return BlocProvider(create: (context) => _herokuBloc!,
//         child: BlocBuilder<HerokuBloc,HerokuState>(
//           builder: (context, state)
//           {
//             if (state is HerokuLoadingState) {
//               return const Center(child: CircularProgressIndicator());
//             };
//             if (state is HerokuLoadedState) {
//               HerokuPizza list = state.heroku;
//               print(list);
//               return ListView.builder(
//                   itemCount: list.recipes!.length,
//                   itemBuilder: (_, index) {
//                     return Padding(
//                       padding:
//                       const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
//                       child: Card(
//                           child: ListTile(
//                             title: Text(
//                               list.recipes![index].title.toString(),
//                               style: const TextStyle(color: Colors.black),
//                             ),
//                             trailing: Text(
//                                 list.count.toString(),
//                                 style: const TextStyle(color: Colors.black)),
//                             subtitle: Text(
//                               list.recipes![index].recipeId.toString(),
//                               style: const TextStyle(color: Colors.black),
//                             ),
//                             leading: Text(
//                               list.recipes![index].sourceUrl.toString(),
//                               style: const TextStyle(color: Colors.black),
//                             ),
//                           )),
//                     );
//                   });
//             }
//             return const Text("Something wrong");
//           },
//         ));
//   }
//   }
// }
