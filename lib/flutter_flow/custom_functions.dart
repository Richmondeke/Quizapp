import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';

double progressvalue(
  int totalQuestions,
  int completedQuestions,
) {
  return completedQuestions / totalQuestions;
}

bool checkusername(
  List<UsersRecord> displayname,
  String displayname2,
) {
  for (var i = 0; i < displayname.length; i++) {
    if (displayname[i].displayName == displayname2) {
      return true;
    }
  }
  return false;
}

String lowercase(String username) {
  return username.toLowerCase();
}
