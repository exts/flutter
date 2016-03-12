// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'basic.dart';
import 'framework.dart';

/// A widget that rebuilds when the given animation changes status.
abstract class StatusTransitionWidget extends StatefulWidget {
  StatusTransitionWidget({
    Key key,
    this.animation
  }) : super(key: key) {
    assert(animation != null);
  }

  /// The animation to which this widget is listening.
  final Animation<double> animation;

  Widget build(BuildContext context);

  _StatusTransitionState createState() => new _StatusTransitionState();
}

class _StatusTransitionState extends State<StatusTransitionWidget> {
  void initState() {
    super.initState();
    config.animation.addStatusListener(_animationStatusChanged);
  }

  void didUpdateConfig(StatusTransitionWidget oldConfig) {
    if (config.animation != oldConfig.animation) {
      oldConfig.animation.removeStatusListener(_animationStatusChanged);
      config.animation.addStatusListener(_animationStatusChanged);
    }
  }

  void dispose() {
    config.animation.removeStatusListener(_animationStatusChanged);
    super.dispose();
  }

  void _animationStatusChanged(AnimationStatus status) {
    setState(() {
      // The animation's state is our build state, and it changed already.
    });
  }

  Widget build(BuildContext context) {
    return config.build(context);
  }
}
