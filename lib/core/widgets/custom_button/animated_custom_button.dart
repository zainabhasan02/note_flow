import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noteflow/core/constants/app_colors.dart';

class AnimatedCustomButton extends StatefulWidget {
  final String title;
  final VoidCallback onPressed;
  final bool isLoading;

  const AnimatedCustomButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  State<AnimatedCustomButton> createState() => _AnimatedCustomButtonState();
}

class _AnimatedCustomButtonState extends State<AnimatedCustomButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      lowerBound: 0.95,
      upperBound: 1.0,
      value: 1.0,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  void onTap() async {
    if (widget.isLoading) return;
    await _animationController.reverse();
    await _animationController.forward();
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.babyBlue,
            shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(20.0),
              side: BorderSide(color: Colors.black12),
            ),
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child:
                widget.isLoading
                    ? const SizedBox(
                      key: ValueKey('loader'),
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(
                        //color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                    : Text(
                      widget.title,
                      key: const ValueKey('text'),
                      style: const TextStyle(
                        //color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
          ),
        ),
      ),
    );
  }
}
