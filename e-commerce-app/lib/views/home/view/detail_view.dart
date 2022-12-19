// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:beginer_bloc/views/home/model/home_model.dart';
import 'package:flutter/material.dart';

import 'package:beginer_bloc/core/const/border/border_radi.dart';
import 'package:beginer_bloc/core/const/responsive/responsive.dart';

class DetailView extends StatefulWidget {
  final List<Products> items;
  const DetailView({
    Key? key,
    required this.items,
  }) : super(key: key);
  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  @override
  Widget build(BuildContext context) {
    const String detailText = "Details";
    const String addCardText = "add to card";
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(5, 5, 5, 0),
              decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadi.midCircular),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: (() {
                          Navigator.of(context).pop();
                        }),
                        icon: const Icon(Icons.turn_left),
                      ),
                      Expanded(
                        child: Text(
                          widget.items[0].title.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  ClipRRect(
                      borderRadius: BorderRadi.extremeLowCircular,
                      child: Image.network(
                        widget.items[0].images![0].toString(),
                        fit: BoxFit.fill,
                        height: context.dynamicHeight(0.30),
                        width: context.width,
                      )),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadi.midCircular),
                height: context.dynamicHeight(0.25),
                width: context.width,
                child: Padding(
                  padding: context.midAllPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        detailText,
                        style: Theme.of(context).textTheme.headline5?.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                      Text(widget.items[0].description.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.copyWith(color: Colors.grey)),
                      SizedBox(
                        height: context.height * 0.02,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.orange.shade100,
                            borderRadius: BorderRadi.midCircular),
                        height: context.dynamicHeight(0.1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "${widget.items[0].price.toString()} €",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  ?.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                            ),
                            Text(
                              addCardText,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  ?.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
