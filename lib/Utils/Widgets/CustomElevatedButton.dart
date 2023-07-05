import 'package:flutter/material.dart';

class CustomElevatedButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget? child;
  final double? height;
  final double? width;
  final double? radius;
  final Color? color;

  const CustomElevatedButton({
    Key? key,
    this.onPressed,
    this.child,
    this.height,
    this.width,
    this.radius,
    this.color,
  }) : super(key: key);

  @override
  _CustomElevatedButtonState createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
          milliseconds: 20), // Adjust the duration as per your preference
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPressed() {
    if (widget.onPressed != null) {
      _controller.forward(from: 0.0);
      widget.onPressed!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SizedBox(
          height: widget.height,
          width: widget.width,
          child: ElevatedButton(
            onPressed: _onPressed,
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all<Color>(
                Colors.white.withOpacity(0.4),
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(widget.radius ?? 0.0),
                ),
              ),
              backgroundColor: MaterialStateProperty.all<Color>(
                widget.color ??
                    Colors.blue, // Use the provided color or default to blue
              ),
            ),
            child: widget.child,
          ),
        );
      },
    );
  }
}
