
double calculatePostFix(List<String> postFixList){
  Stack<double> stack = Stack();
  for(int i=0;i<postFixList.length;i++){
    String word = postFixList[i];
    if(!isANum(word)){//if(word.length==1 && (word[0]=='+'||word.charAt(0)=='-'||word.charAt(0)=='*'||word.charAt(0)=='/')){
      double number2 = stack.pop();
      double number1 = stack.pop();
      if(word=='+'){
        double number = number1 + number2;
        stack.push(number);
      }else if(word=='-'){
        double number = number1-number2;
        stack.push(number);
      }else if(word=='*'){
        double number = number1*number2;
        stack.push(number);
      }else{
        double number = number1/number2;
        stack.push(number);
      }
    }else{
      double number = double.parse(word);
      stack.push(number);
    }
  }
  return stack.peek();
}

List<String> infixTopostfix(List<String> s){
  Stack<String> stack = Stack();
  List<String> postFixList = [];
  bool flag = false;
  for(int i=0; i< s.length;i++){
    String word = s[i];
    if(word==' '){
      continue;
    }
    if(word=='('){
      stack.push(word);
      flag = false;
    }else if(word==')'){
      flag = false;
      while(!stack.isEmpty()){
        if(stack.peek()=='('){
          stack.pop();
          break;
        }else{
          postFixList.add(stack.pop());
        }
      }
    }else if(word=='+' || word=='-' || word=='*' || word=='/'){
      flag = false;
      if(stack.isEmpty()){
        stack.push(word);
      }
      else{
        while(!stack.isEmpty() && getPreference(stack.peek())>=getPreference(word)){
          postFixList.add(stack.pop());
        }
        stack.push(word);
      }
    }else{
      if(flag){
        String lastNumber = postFixList.last;
        lastNumber+=word;
        postFixList.last = lastNumber;
        //postFixList.set(postFixList.size()-1, lastNumber);
      }else {
        postFixList.add(word);
      }
      flag = true;
    }
  }
  while(!stack.isEmpty()){
    postFixList.add(stack.pop());
  }
  return postFixList;
}


bool isANum(String x) {
  return double.tryParse(x) != null;
}

int getPreference(String c){
  if(c=='+'|| c=='-') {
    return 1;
  } else if(c=='*' || c=='/') {
    return 2;
  } else {
    return -1;
  }
}

class Stack<T>{

  List<T> s = [];


  bool isEmpty()=> s.isEmpty;

  void push(T element){
    s.add(element);
  }

  T pop (){
    if(isEmpty()) throw Exception('Stack already empty');
    return s.removeLast();
  }

  T peek()=>s.last;

}



