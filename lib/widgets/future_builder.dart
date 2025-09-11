import 'package:flutter/material.dart';

Widget futureList(BuildContext context, Future future, Widget returnWidget) {
  return FutureBuilder(
    future: future,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasError) {
          final error = snapshot.error;
          return Center(child: Text('$error'));
        } else {
          return returnWidget;
        }
      } else {
        return const Center(child: Text('future error'));
      }
    },
  );
}