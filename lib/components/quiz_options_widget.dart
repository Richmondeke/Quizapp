import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'quiz_options_model.dart';
export 'quiz_options_model.dart';

class QuizOptionsWidget extends StatefulWidget {
  const QuizOptionsWidget({
    Key? key,
    this.questionNum,
    this.questionName,
    this.isTrue,
    this.quizReference,
  }) : super(key: key);

  final String? questionNum;
  final String? questionName;
  final bool? isTrue;
  final DocumentReference? quizReference;

  @override
  _QuizOptionsWidgetState createState() => _QuizOptionsWidgetState();
}

class _QuizOptionsWidgetState extends State<QuizOptionsWidget> {
  late QuizOptionsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => QuizOptionsModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        if (widget.isTrue!) {
          if (_model.isAnswered != null) {
            setState(() {
              _model.isAnswered = null;
            });
            setState(() {
              FFAppState().score = FFAppState().score + -1;
            });
            FFAppState().update(() {
              FFAppState().completedQuestion =
                  FFAppState().completedQuestion + -1;
            });
          } else {
            setState(() {
              _model.isAnswered = true;
            });
            FFAppState().update(() {
              FFAppState().completedQuestion =
                  FFAppState().completedQuestion + 1;
            });
            setState(() {
              FFAppState().score = FFAppState().score + 1;
            });
          }
        } else {
          if (_model.isAnswered != null) {
            setState(() {
              _model.isAnswered = null;
            });
            FFAppState().update(() {
              FFAppState().completedQuestion =
                  FFAppState().completedQuestion + -1;
            });
          } else {
            setState(() {
              _model.isAnswered = false;
            });
            FFAppState().update(() {
              FFAppState().completedQuestion =
                  FFAppState().completedQuestion + 1;
            });
          }
        }
      },
      child: Container(
        width: double.infinity,
        height: 60.0,
        decoration: BoxDecoration(
          color: valueOrDefault<Color>(
            () {
              if (_model.isAnswered == true) {
                return Color(0xFF00FF8E);
              } else if (_model.isAnswered == false) {
                return Color(0x34FF0000);
              } else {
                return FlutterFlowTheme.of(context).alternate;
              }
            }(),
            Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: valueOrDefault<Color>(
              () {
                if (_model.isAnswered == true) {
                  return Color(0xFF00FF8E);
                } else if (_model.isAnswered == false) {
                  return Color(0xFFFF0000);
                } else {
                  return FlutterFlowTheme.of(context).alternate;
                }
              }(),
              FlutterFlowTheme.of(context).alternate,
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 36.0,
                height: 36.0,
                decoration: BoxDecoration(
                  color: valueOrDefault<Color>(
                    () {
                      if (_model.isAnswered == true) {
                        return Color(0xFF00FF8E);
                      } else if (_model.isAnswered == false) {
                        return Color(0xFFFF0000);
                      } else {
                        return Colors.transparent;
                      }
                    }(),
                    Colors.transparent,
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: valueOrDefault<Color>(
                      () {
                        if (_model.isAnswered == true) {
                          return Color(0xFF00FF8E);
                        } else if (_model.isAnswered == false) {
                          return Color(0xFFFF0000);
                        } else {
                          return FlutterFlowTheme.of(context).alternate;
                        }
                      }(),
                      FlutterFlowTheme.of(context).alternate,
                    ),
                  ),
                ),
                child: Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Text(
                    widget.questionNum!,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Manrope',
                          color: FlutterFlowTheme.of(context).secondaryText,
                        ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                  child: Text(
                    widget.questionName!,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Poppins',
                          color: FlutterFlowTheme.of(context).secondaryText,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
