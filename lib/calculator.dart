import 'package:calculator/Utils.dart';
import 'package:flutter/material.dart';

import 'BuildButton.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {

  final ScrollController _controller = ScrollController();
  final _operator = ['+','-','×','÷'];
  List<String> _input = [];
  List<String> _expression = [];
  String _currentInput = '';
  String _result = '';

  _scrollToEnd(){
    if(_controller.offset>0){
      _controller.jumpTo(0);
    }
  }


  _handleExpression(){
    List<String> t = List.from(_expression);
    print(t);
    if(_currentInput.isEmpty && t.isEmpty) {
      _result = '';
      return;
    }
    if(isANum(_currentInput)){
      t.add(_currentInput);
    }else{
      if(t.isNotEmpty){
        t.removeLast();
      }else{
        _result = '';
        return;
      }
    }
    _result = calculatePostFix(infixTopostfix(t)).toString();
  }

  void buttonOnClick(String value){
    setState(() {
      _currentInput += value;
      _handleExpression();
    });
    _scrollToEnd();
  }


  void operatorOnClick(String value){
    if(value == 'C'){
      if(_currentInput.isNotEmpty){
        _currentInput = _currentInput.substring(0,_currentInput.length-1);
      }else if (_input.isNotEmpty){
        _input.removeLast();
        _expression.removeLast();
        _currentInput = _input.removeLast();
        _expression.removeLast();
      }
    }else{
      if(_input.isEmpty){
        if(_currentInput.isNotEmpty) {
          _input.add(_currentInput);
          _expression.add(_currentInput);
          _currentInput = '';
          _input.add(value);
          if(value == '×'){
            _expression.add('*');
          }else if(value == '÷'){
            _expression.add('/');
          } else {
            _expression.add(value);
          }
        }else if(value == '-'){
          _currentInput += value;
        }
      }
      else if( _currentInput.isEmpty){
        if(value == '-') {
          _currentInput += value;
        }
      }
      else if(isANum(_currentInput)){
        _input.add(_currentInput);
        _expression.add(_currentInput);
        _currentInput = '';
        _input.add(value);
        if(value == '×'){
          _expression.add('*');
        }else if(value == '÷'){
          _expression.add('/');
        } else {
          _expression.add(value);
        }
      }
    }
    setState(() {
      _handleExpression();
    });
    _scrollToEnd();
  }

  List<TextSpan> _colorText(List<String> text){
    List<String> tmp = List.from(text);
    if(tmp.isEmpty && _currentInput.isEmpty){
      return [
        const TextSpan(
          text: '0'
        )
      ];
    }

    tmp.add('');
    tmp.last += _currentInput;

    return tmp.map((e){
      if(_operator.contains(e)) {
        return TextSpan(
          text: ' $e ',
          style: const TextStyle(
            color: Color(0xff57b3fe)
          )
        );
      }
      return TextSpan(
        text: e
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 15),
                          color: Color(0xffe5f3fe),
                          spreadRadius: -8,
                          blurRadius: 10),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Column(
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            child: SelectableText(
                              _result.isEmpty ? '0' : _result,
                              maxLines: 1,
                              style: const TextStyle(
                                  fontSize: 60
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: SingleChildScrollView(
                            controller: _controller,
                            reverse: true,
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            child: SelectableText.rich(
                              TextSpan(
                                children: _colorText(_input)
                              ),
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 60
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      BuildButton('7', onClick: (value)=>buttonOnClick(value),),
                      BuildButton('8', onClick: (value)=>buttonOnClick(value),),
                      BuildButton('9', onClick: (value)=>buttonOnClick(value),),
                      BuildButton('÷',textColor: const Color(0xff57b3fe), onClick: (value)=>operatorOnClick(value),)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      BuildButton('4', onClick: (value)=>buttonOnClick(value),),
                      BuildButton('5', onClick: (value)=>buttonOnClick(value),),
                      BuildButton('6', onClick: (value)=>buttonOnClick(value),),
                      BuildButton('×', textColor: const Color(0xff57b3fe), onClick: (value)=>operatorOnClick(value))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      BuildButton('3', onClick: (value)=>buttonOnClick(value),),
                      BuildButton('2', onClick: (value)=>buttonOnClick(value),),
                      BuildButton('1', onClick: (value)=>buttonOnClick(value),),
                      BuildButton('-', textColor: const Color(0xff57b3fe), onClick: (value)=>operatorOnClick(value))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      BuildButton('C', textColor: const Color(0xfffbafb0), onClick: (value)=>operatorOnClick(value)),
                      BuildButton('0', onClick: (value)=>buttonOnClick(value),),
                      BuildButton('.', onClick: (value)=>buttonOnClick(value),),
                      BuildButton('+', textColor: const Color(0xff57b3fe), onClick: (value)=>operatorOnClick(value))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(0,6),
                                    blurRadius: 25,
                                    color: const Color(0xff5293cd).withOpacity(0.5)
                                ),
                              ],
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: const Center(
                            child: Text(
                              'AC',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Color(0xfffbafb0)
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 50,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              color: const Color(0xff57b3fe),
                              boxShadow: const [
                                BoxShadow(
                                    offset: Offset(0,6),
                                    blurRadius: 25,
                                    color: Color(0xff5293cd)
                                ),
                              ],
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: const Center(
                            child: Text(
                              '=',
                              style: TextStyle(
                                  fontSize: 35,
                                  color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  
}
