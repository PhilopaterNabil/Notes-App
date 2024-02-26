import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/cubits/notes_cubit/notes_cubit.dart';
import 'package:notes_app/views/widgets/custom_app_bar.dart';
import 'package:notes_app/views/widgets/custom_text_field.dart';
import 'package:notes_app/views/widgets/notes_list_view.dart';

class NotesViewBody extends StatefulWidget {
  const NotesViewBody({super.key});

  @override
  State<NotesViewBody> createState() => _NotesViewBodyState();
}

class _NotesViewBodyState extends State<NotesViewBody> {
  @override
  void initState() {
    BlocProvider.of<NotesCubit>(context).fetchAllNotes();
    super.initState();
  }

  bool enterButton = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          CustomAppBar(
              title: 'Notes',
              icon: Icons.search,
              onPressed: () {
                enterButton = !enterButton;
                setState(() {});
              }),
          enterButton
              ? CustomTextField(
                  onSaved: (data) {},
                  onChanged: (data) {
                    BlocProvider.of<NotesCubit>(context)
                        .fetchNodeBySearch(data);
                  },
                  hintText: 'Notes',
                )
              : const SizedBox(),
          const Expanded(
            child: NotesListView(),
          ),
        ],
      ),
    );
  }
}
