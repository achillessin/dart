#import('dart:html');
#source('vector.dart');

void main() {
  vector<num> v3=new vector<num>(4);
  vector<num> v4=new vector<num>(4);
  vector<int> v1 = new vector<int>(4);
  vector<int> v2 = new vector<int>(4);
  
  for(int i=0;i<v1.size;i++)
    v1[i]=i;
  v2.copyFromVector(v1);
  v2=v2*2;
  
  print('v1 vector:');
  print(v1.toString());
  print('v2 vector:');
  print(v2.toString());
  
  v1.normalize();
  print('v1 normalized');
  print(v1.toString());
  
  print('v1 dot v2');
  print(v1.dot(v2));
}

void showMessage(String message) {
  var textElement = query('#text');

  textElement.text = message;
}
