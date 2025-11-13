import 'package:flutter/material.dart';
import 'dart:math';

class KalkulatorPage extends StatefulWidget {
  const KalkulatorPage({super.key});

  @override
  State<KalkulatorPage> createState() => _KalkulatorPageState();
}

class _KalkulatorPageState extends State<KalkulatorPage>
    with SingleTickerProviderStateMixin {
  String _input = '';
  String _output = '0';

  late AnimationController _controller;
  late Animation<double> _fadeIn;
  late Animation<Offset> _slideUp;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _slideUp =
        Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _controller.forward();
  }

  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'AC') {
        _input = '';
        _output = '0';
      } else if (value == '=') {
        try {
          final result = _calculate(_input);
          if (result.endsWith('.0')) {
            _output = result.replaceAll('.0', '');
          } else {
            _output = result;
          }
        } catch (e) {
          _output = 'Error';
        }
      } else {
        _input += value;
      }
    });
  }

  String _calculate(String expression) {
    expression = expression.replaceAll('×', '*').replaceAll('÷', '/');
    try {
      final res = _evaluateExpression(expression);
      return res.toString();
    } catch (_) {
      return 'Error';
    }
  }

  double _evaluateExpression(String exp) {
    exp = exp.replaceAll(' ', '');
    if (exp.contains('+')) {
      var parts = exp.split('+');
      return _evaluateExpression(parts[0]) + _evaluateExpression(parts[1]);
    } else if (exp.contains('-') && exp.lastIndexOf('-') > 0) {
      var parts = exp.split('-');
      return _evaluateExpression(parts[0]) - _evaluateExpression(parts[1]);
    } else if (exp.contains('*')) {
      var parts = exp.split('*');
      return _evaluateExpression(parts[0]) * _evaluateExpression(parts[1]);
    } else if (exp.contains('/')) {
      var parts = exp.split('/');
      return _evaluateExpression(parts[0]) / _evaluateExpression(parts[1]);
    } else if (exp.contains('√')) {
      return sqrt(_evaluateExpression(exp.replaceAll('√', '')));
    } else if (exp.contains('²')) {
      return pow(_evaluateExpression(exp.replaceAll('²', '')), 2).toDouble();
    }
    return double.tryParse(exp) ?? 0;
  }

  final List<String> buttons = [
    '(', ')', '%', 'AC',
    '7', '8', '9', '÷',
    '4', '5', '6', '×',
    '1', '2', '3', '-',
    '0', '.', '=', '+',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF2FB),
      body: FadeTransition(
        opacity: _fadeIn,
        child: SlideTransition(
          position: _slideUp,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  // 💡 Tampilan hasil
                  Expanded(
                    flex: 2,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.white, Colors.blue.shade50],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueAccent.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(2, 4),
                          ),
                        ],
                        border: Border.all(color: Colors.blue.shade100),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            _input,
                            style: const TextStyle(
                              fontSize: 24,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            _output,
                            style: const TextStyle(
                              fontSize: 44,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),

                  // 🔘 Tombol kalkulator
                  Expanded(
                    flex: 5,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: buttons.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 14,
                        crossAxisSpacing: 14,
                      ),
                      itemBuilder: (context, index) {
                        final button = buttons[index];
                        final isOperator = ['÷', '×', '-', '+', '=', '%'].contains(button);
                        final isAction = ['AC', '(', ')'].contains(button);

                        Color bgColor;
                        Color textColor;

                        if (isOperator) {
                          bgColor = const Color(0xFF3D5AFE);
                          textColor = Colors.white;
                        } else if (isAction) {
                          bgColor = Colors.white;
                          textColor = Colors.indigo;
                        } else {
                          bgColor = Colors.white;
                          textColor = Colors.black87;
                        }

                        return InkWell(
                          borderRadius: BorderRadius.circular(40),
                          onTap: () => _onButtonPressed(button),
                          child: Ink(
                            decoration: BoxDecoration(
                              color: bgColor,
                              borderRadius: BorderRadius.circular(40),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12.withOpacity(0.05),
                                  blurRadius: 5,
                                  offset: const Offset(2, 2),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                button,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  color: textColor,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
