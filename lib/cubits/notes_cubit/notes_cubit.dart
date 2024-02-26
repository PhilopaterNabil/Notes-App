import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/models/note_model.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesInitial());

  List<NoteModel>? notes;
  fetchAllNotes() {
    var notesBox = Hive.box<NoteModel>(kNotesBox);

    notes = notesBox.values.toList();
    emit(NotesSuccess());
  }

  fetchNodeBySearch(String text) {
    List<NoteModel> data = [];
    var notesBox = Hive.box<NoteModel>(kNotesBox);
    notes = notesBox.values.toList();
    for (int i = 0; i < notes!.length; i++) {
      if (notes![i].title.toLowerCase().contains(text.toLowerCase()) ||
          notes![i].subTile.toLowerCase().contains(text.toLowerCase())) {
        data.add(notes![i]);
      }
    }
    notes = data;
    emit(NotesSuccess());
  }
}
