import 'package:flutter/material.dart';

class BuildButton extends StatefulWidget {
  const BuildButton(this.text,{Key? key,this.textColor=Colors.black, required this.onClick}) : super(key: key);
  final String text;
  final Color textColor;
  final Function(String) onClick;

  @override
  State<BuildButton> createState() => _BuildButtonState();
}

class _BuildButtonState extends State<BuildButton> with SingleTickerProviderStateMixin {

  late Animation<double> animation;
  late AnimationController animationController;
  late Tween<double> tween;


  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    tween = Tween<double>(begin: 1, end: 1.5);
    animation = tween.animate(CurvedAnimation(parent: animationController, curve: Curves.easeInOut));
    super.initState();
  }

  void animate(){
    animationController.forward().then((value) => animationController.reverse());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child){
          double value = animation.value;
          return Container(
            width: 60 * value,
            height: 60 * value,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(0, 6),
                      blurRadius: 20,
                      spreadRadius: 5,
                      color: Color(0xffe5f3fe))
                ],
                borderRadius: BorderRadius.circular(30 * value)),
            child: Center(
              child: Text(
                widget.text,
                style: TextStyle(color: widget.textColor, fontSize: 32 * value),
              ),
            ),
          );
        },
      ),
      onTap: (){
        widget.onClick(widget.text);
        animate();
      },
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
