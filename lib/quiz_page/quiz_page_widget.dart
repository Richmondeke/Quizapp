import '/backend/backend.dart';
import '/components/quiz_options_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'quiz_page_model.dart';
export 'quiz_page_model.dart';

class QuizPageWidget extends StatefulWidget {
  const QuizPageWidget({
    Key? key,
    this.quizSetRef,
    this.quizDuration,
  }) : super(key: key);

  final DocumentReference? quizSetRef;
  final int? quizDuration;

  @override
  _QuizPageWidgetState createState() => _QuizPageWidgetState();
}

class _QuizPageWidgetState extends State<QuizPageWidget>
    with TickerProviderStateMixin {
  late QuizPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  int get pageViewCurrentIndex => _model.pageViewController != null &&
          _model.pageViewController!.hasClients &&
          _model.pageViewController!.page != null
      ? _model.pageViewController!.page!.round()
      : 0;

  final animationsMap = {
    'containerOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
    'progressBarOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 100.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
    'pageViewOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 300.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
    'rowOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 600.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 600.ms,
          duration: 600.ms,
          begin: Offset(0.0, 24.0),
          end: Offset(0.0, 0.0),
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => QuizPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.timerController.onExecute.add(StopWatchExecute.start);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).tertiary,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20.0, 48.0, 20.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          height: 36.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24.0),
                            border: Border.all(
                              color: Colors.white,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 12.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.access_time_outlined,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      6.0, 0.0, 0.0, 0.0),
                                  child: FlutterFlowTimer(
                                    initialTime: widget.quizDuration!,
                                    getDisplayTime: (value) =>
                                        StopWatchTimer.getDisplayTime(
                                      value,
                                      hours: false,
                                      milliSecond: false,
                                    ),
                                    timer: _model.timerController,
                                    updateStateInterval:
                                        Duration(milliseconds: 1000),
                                    onChanged:
                                        (value, displayTime, shouldUpdate) {
                                      _model.timerMilliseconds = value;
                                      _model.timerValue = displayTime;
                                      if (shouldUpdate) setState(() {});
                                    },
                                    onEnded: () async {
                                      context.pushNamed(
                                        'ScorePage',
                                        queryParams: {
                                          'scoreAquired': serializeParam(
                                            FFAppState().score,
                                            ParamType.int,
                                          ),
                                          'totalQuestions': serializeParam(
                                            10,
                                            ParamType.int,
                                          ),
                                        }.withoutNulls,
                                      );
                                    },
                                    textAlign: TextAlign.start,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Manrope',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Q',
                            style: TextStyle(),
                          ),
                          TextSpan(
                            text: valueOrDefault<String>(
                              (valueOrDefault<int>(
                                        _model.pageNavigate,
                                        0,
                                      ) +
                                      1)
                                  .toString(),
                              '0',
                            ),
                            style: TextStyle(),
                          )
                        ],
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Manrope',
                              color: FlutterFlowTheme.of(context).primaryText,
                            ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            context.pushNamed('CreateQuizSet');
                          },
                          child: Icon(
                            Icons.grid_view,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 24.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 96.0, 0.0, 0.0),
                child: Container(
                  width: double.infinity,
                  height: 100.0,
                  decoration: BoxDecoration(
                    color: Color(0x1AFFFFFF),
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      FutureBuilder<int>(
                        future: queryQuizRecordCount(
                          queryBuilder: (quizRecord) => quizRecord
                              .where('quiz_set', isEqualTo: widget.quizSetRef),
                        ),
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return Center(
                              child: SizedBox(
                                width: 50.0,
                                height: 50.0,
                                child: SpinKitRipple(
                                  color: FlutterFlowTheme.of(context).primary,
                                  size: 50.0,
                                ),
                              ),
                            );
                          }
                          int progressBarCount = snapshot.data!;
                          return LinearPercentIndicator(
                            percent: functions.progressvalue(progressBarCount,
                                FFAppState().completedQuestion),
                            width: MediaQuery.of(context).size.width * 1.0,
                            lineHeight: 9.0,
                            animation: true,
                            progressColor: FlutterFlowTheme.of(context).primary,
                            backgroundColor: Color(0x34F1F4F8),
                            barRadius: Radius.circular(0.0),
                            padding: EdgeInsets.zero,
                          ).animateOnPageLoad(
                              animationsMap['progressBarOnPageLoadAnimation']!);
                        },
                      ),
                      Expanded(
                        child: StreamBuilder<List<QuizRecord>>(
                          stream: queryQuizRecord(
                            queryBuilder: (quizRecord) => quizRecord
                                .where('quiz_set', isEqualTo: widget.quizSetRef)
                                .orderBy('serial'),
                          ),
                          builder: (context, snapshot) {
                            // Customize what your widget looks like when it's loading.
                            if (!snapshot.hasData) {
                              return Center(
                                child: SizedBox(
                                  width: 50.0,
                                  height: 50.0,
                                  child: SpinKitRipple(
                                    color: FlutterFlowTheme.of(context).primary,
                                    size: 50.0,
                                  ),
                                ),
                              );
                            }
                            List<QuizRecord> pageViewQuizRecordList =
                                snapshot.data!;
                            return Container(
                              width: double.infinity,
                              height: 500.0,
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 50.0),
                                child: PageView.builder(
                                  controller: _model.pageViewController ??=
                                      PageController(
                                          initialPage: min(
                                              0,
                                              pageViewQuizRecordList.length -
                                                  1)),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: pageViewQuizRecordList.length,
                                  itemBuilder: (context, pageViewIndex) {
                                    final pageViewQuizRecord =
                                        pageViewQuizRecordList[pageViewIndex];
                                    return Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20.0, 24.0, 20.0, 0.0),
                                          child: Text(
                                            pageViewQuizRecord.question,
                                            textAlign: TextAlign.start,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Manrope',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20.0, 24.0, 20.0, 0.0),
                                          child: ListView(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 0.0, 12.0),
                                                child: StreamBuilder<
                                                    List<QuestionARecord>>(
                                                  stream: queryQuestionARecord(
                                                    parent: pageViewQuizRecord
                                                        .reference,
                                                    singleRecord: true,
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 50.0,
                                                          height: 50.0,
                                                          child: SpinKitRipple(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                            size: 50.0,
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    List<QuestionARecord>
                                                        quizOptionsQuestionARecordList =
                                                        snapshot.data!;
                                                    // Return an empty Container when the item does not exist.
                                                    if (snapshot
                                                        .data!.isEmpty) {
                                                      return Container();
                                                    }
                                                    final quizOptionsQuestionARecord =
                                                        quizOptionsQuestionARecordList
                                                                .isNotEmpty
                                                            ? quizOptionsQuestionARecordList
                                                                .first
                                                            : null;
                                                    return QuizOptionsWidget(
                                                      key: Key(
                                                          'Keyrkj_${pageViewIndex}_of_${pageViewQuizRecordList.length}'),
                                                      questionNum: 'A',
                                                      questionName:
                                                          quizOptionsQuestionARecord!
                                                              .question,
                                                      isTrue:
                                                          quizOptionsQuestionARecord!
                                                              .isTrue,
                                                      quizReference:
                                                          pageViewQuizRecord
                                                              .reference,
                                                    );
                                                  },
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 0.0, 12.0),
                                                child: StreamBuilder<
                                                    List<QuestionBRecord>>(
                                                  stream: queryQuestionBRecord(
                                                    parent: pageViewQuizRecord
                                                        .reference,
                                                    singleRecord: true,
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 50.0,
                                                          height: 50.0,
                                                          child: SpinKitRipple(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                            size: 50.0,
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    List<QuestionBRecord>
                                                        quizOptionsQuestionBRecordList =
                                                        snapshot.data!;
                                                    // Return an empty Container when the item does not exist.
                                                    if (snapshot
                                                        .data!.isEmpty) {
                                                      return Container();
                                                    }
                                                    final quizOptionsQuestionBRecord =
                                                        quizOptionsQuestionBRecordList
                                                                .isNotEmpty
                                                            ? quizOptionsQuestionBRecordList
                                                                .first
                                                            : null;
                                                    return QuizOptionsWidget(
                                                      key: Key(
                                                          'Keyjh8_${pageViewIndex}_of_${pageViewQuizRecordList.length}'),
                                                      questionNum: 'B',
                                                      questionName:
                                                          quizOptionsQuestionBRecord!
                                                              .question,
                                                      isTrue:
                                                          quizOptionsQuestionBRecord!
                                                              .isTrue,
                                                      quizReference:
                                                          pageViewQuizRecord
                                                              .reference,
                                                    );
                                                  },
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 0.0, 12.0),
                                                child: StreamBuilder<
                                                    List<QuestionCRecord>>(
                                                  stream: queryQuestionCRecord(
                                                    parent: pageViewQuizRecord
                                                        .reference,
                                                    singleRecord: true,
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 50.0,
                                                          height: 50.0,
                                                          child: SpinKitRipple(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                            size: 50.0,
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    List<QuestionCRecord>
                                                        quizOptionsQuestionCRecordList =
                                                        snapshot.data!;
                                                    // Return an empty Container when the item does not exist.
                                                    if (snapshot
                                                        .data!.isEmpty) {
                                                      return Container();
                                                    }
                                                    final quizOptionsQuestionCRecord =
                                                        quizOptionsQuestionCRecordList
                                                                .isNotEmpty
                                                            ? quizOptionsQuestionCRecordList
                                                                .first
                                                            : null;
                                                    return QuizOptionsWidget(
                                                      key: Key(
                                                          'Keyo2h_${pageViewIndex}_of_${pageViewQuizRecordList.length}'),
                                                      questionNum: 'C',
                                                      questionName:
                                                          quizOptionsQuestionCRecord!
                                                              .question,
                                                      isTrue:
                                                          quizOptionsQuestionCRecord!
                                                              .isTrue,
                                                      quizReference:
                                                          pageViewQuizRecord
                                                              .reference,
                                                    );
                                                  },
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 0.0, 12.0),
                                                child: StreamBuilder<
                                                    List<QuestionDRecord>>(
                                                  stream: queryQuestionDRecord(
                                                    parent: pageViewQuizRecord
                                                        .reference,
                                                    singleRecord: true,
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 50.0,
                                                          height: 50.0,
                                                          child: SpinKitRipple(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                            size: 50.0,
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    List<QuestionDRecord>
                                                        quizOptionsQuestionDRecordList =
                                                        snapshot.data!;
                                                    // Return an empty Container when the item does not exist.
                                                    if (snapshot
                                                        .data!.isEmpty) {
                                                      return Container();
                                                    }
                                                    final quizOptionsQuestionDRecord =
                                                        quizOptionsQuestionDRecordList
                                                                .isNotEmpty
                                                            ? quizOptionsQuestionDRecordList
                                                                .first
                                                            : null;
                                                    return QuizOptionsWidget(
                                                      key: Key(
                                                          'Keyskv_${pageViewIndex}_of_${pageViewQuizRecordList.length}'),
                                                      questionNum: 'D',
                                                      questionName:
                                                          quizOptionsQuestionDRecord!
                                                              .question,
                                                      isTrue:
                                                          quizOptionsQuestionDRecord!
                                                              .isTrue,
                                                      quizReference:
                                                          pageViewQuizRecord
                                                              .reference,
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ).animateOnPageLoad(
                                animationsMap['pageViewOnPageLoadAnimation']!);
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 0.0, 20.0, 24.0),
                        child: FutureBuilder<int>(
                          future: queryQuizRecordCount(
                            queryBuilder: (quizRecord) => quizRecord.where(
                                'quiz_set',
                                isEqualTo: widget.quizSetRef),
                          ),
                          builder: (context, snapshot) {
                            // Customize what your widget looks like when it's loading.
                            if (!snapshot.hasData) {
                              return Center(
                                child: SizedBox(
                                  width: 50.0,
                                  height: 50.0,
                                  child: SpinKitRipple(
                                    color: FlutterFlowTheme.of(context).primary,
                                    size: 50.0,
                                  ),
                                ),
                              );
                            }
                            int rowCount = snapshot.data!;
                            return Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                if (FFAppState().completedQuestion > 0)
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 16.0, 0.0),
                                    child: FlutterFlowIconButton(
                                      borderColor: Colors.transparent,
                                      borderRadius: 12.0,
                                      borderWidth: 1.0,
                                      buttonSize: 60.0,
                                      fillColor:
                                          FlutterFlowTheme.of(context).primary,
                                      icon: Icon(
                                        Icons.keyboard_arrow_left,
                                        color: Colors.white,
                                        size: 30.0,
                                      ),
                                      onPressed: () async {
                                        await _model.pageViewController
                                            ?.previousPage(
                                          duration: Duration(milliseconds: 300),
                                          curve: Curves.ease,
                                        );
                                        setState(() {
                                          _model.pageNavigate =
                                              _model.pageNavigate + -1;
                                        });
                                      },
                                    ),
                                  ),
                                if ((FFAppState().completedQuestion >= 0) &&
                                    (FFAppState().completedQuestion < rowCount))
                                  Expanded(
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        await _model.pageViewController
                                            ?.nextPage(
                                          duration: Duration(milliseconds: 300),
                                          curve: Curves.ease,
                                        );
                                        if (rowCount !=
                                            valueOrDefault<int>(
                                              _model.pageNavigate,
                                              0,
                                            )) {
                                          setState(() {
                                            _model.pageNavigate =
                                                _model.pageNavigate + 1;
                                          });
                                        }
                                      },
                                      text: 'Next',
                                      options: FFButtonOptions(
                                        width: 130.0,
                                        height: 60.0,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 0.0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily: 'Poppins',
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal,
                                            ),
                                        elevation: 2.0,
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                if (FFAppState().completedQuestion == rowCount)
                                  Expanded(
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        context.goNamed(
                                          'ScorePage',
                                          queryParams: {
                                            'scoreAquired': serializeParam(
                                              FFAppState().score,
                                              ParamType.int,
                                            ),
                                            'totalQuestions': serializeParam(
                                              rowCount,
                                              ParamType.int,
                                            ),
                                          }.withoutNulls,
                                        );

                                        FFAppState().update(() {
                                          FFAppState().completedQuestion = 0;
                                        });
                                      },
                                      text: 'Complete',
                                      options: FFButtonOptions(
                                        width: 130.0,
                                        height: 60.0,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 0.0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily: 'Poppins',
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal,
                                            ),
                                        elevation: 2.0,
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ),
                              ],
                            ).animateOnPageLoad(
                                animationsMap['rowOnPageLoadAnimation']!);
                          },
                        ),
                      ),
                    ],
                  ),
                ).animateOnPageLoad(
                    animationsMap['containerOnPageLoadAnimation']!),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
