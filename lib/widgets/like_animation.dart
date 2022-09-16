import 'package:flutter/material.dart';

class LikeAnimation extends StatefulWidget {
  final Widget child; //for parent widget animation.//for which widget we could set animation
  final bool isAnimating;
  final Duration duration;
  final VoidCallback? onEnd;
  final bool smallLike; //for check user like button click or not
  const LikeAnimation({
    Key? key,
    required this.child,
    required this.isAnimating,
    this.duration = const Duration(milliseconds: 150),
    this.onEnd,
    this.smallLike = false,
  }) : super(key: key);

  @override
  State<LikeAnimation> createState() => _LikeAnimationState();
}

//for twin animation we have to extends SingleTickerProviderStateMixin
class _LikeAnimationState extends State<LikeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scale;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration.inMilliseconds ~/ 2),
    );
    scale = Tween<double>(begin: 1, end: 1.5).animate(controller);
  }

  //call when current widget update by another widget
  @override
  void didUpdateWidget(covariant LikeAnimation oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if(widget.isAnimating != oldWidget.isAnimating){
      startAnimation();
    }
  }
  startAnimation() async{
    if(widget.isAnimating || widget.smallLike){
      await controller.forward();
      await controller.reverse();
      await Future.delayed(const Duration(microseconds: 200));
    }
    if(widget.onEnd != null){
      widget.onEnd!();
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(scale: scale,child: widget.child,);
  }
}
