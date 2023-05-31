// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:convert';

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the button on the right!
Future<void> parseJsonAndSaveToFirebase(String jsonData) async {
  // Parse the JSON data
  final data = json.decode(jsonData);

  // Save the quizSet document to Firestore
  final quizSetRef = FirebaseFirestore.instance.collection('quizSet').doc();
  await quizSetRef.set(data['quiz_set']);

  // Save the quiz questions and options to Firestore
  final quizCollectionRef = FirebaseFirestore.instance.collection('quiz');
  for (final quiz in data['quiz']) {
    final quizDocRef = quizCollectionRef.doc();
    await quizDocRef.set({
      'question': quiz['question'],
      'quiz_set': quizSetRef,
      'correct_option':
          quiz['correct_option'], // new field to indicate correct option
    });

    // Save the options for the question to Firestore
    final questionARef = quizDocRef.collection('question_a').doc();
    await questionARef.set({
      'question': quiz['question_a']['question'],
      'is_true': quiz['correct_option'] ==
          'a', // indicate if this is the correct option
    });

    final questionBRef = quizDocRef.collection('question_b').doc();
    await questionBRef.set({
      'question': quiz['question_b']['question'],
      'is_true': quiz['correct_option'] ==
          'b', // indicate if this is the correct option
    });

    final questionCRef = quizDocRef.collection('question_c').doc();
    await questionCRef.set({
      'question': quiz['question_c']['question'],
      'is_true': quiz['correct_option'] ==
          'c', // indicate if this is the correct option
    });

    final questionDRef = quizDocRef.collection('question_d').doc();
    await questionDRef.set({
      'question': quiz['question_d']['question'],
      'is_true': quiz['correct_option'] ==
          'd', // indicate if this is the correct option
    });
  }
}
