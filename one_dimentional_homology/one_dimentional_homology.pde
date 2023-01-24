//課題7-2は"72.txt"，課題7-3は"73.txt"，授業で取り扱ったベンツのような形は"74.txt"
String filename = "74.txt";

//頂点の種類を確認するためのArrayList
ArrayList<Integer> V = new ArrayList<Integer>();

//辺のデータを格納するArrayList
ArrayList<PVector> E = new ArrayList<PVector>();

int [][] matrix;

void setup() {
  size(600,600);
  frameRate(30);
  String[] lines = loadStrings(filename);
  for (int i = 0; i < lines.length; i++) {
    String [] temp = split(lines[i], ",");
    String [] temp2 = split(temp[0], "(");
    String [] temp3 = split(temp[1], ")");
    PVector temp4 = new PVector(int(temp2[1]), int(temp3[0]));
    E.add(temp4);
    if (V.size() != 0) {
      boolean check = false;
      for (int j = 0; j < V.size(); j++) {
        if (V.get(j) == int(temp2[1])) {
          check = true;
        }
      }
      if (check == false) {
        V.add(int(temp2[1]));
      }
      check = false;
      for (int j = 0; j < V.size(); j++) {
        if (V.get(j) == int(temp3[0])) {
          check = true;
        }
      }
      if (check == false) {
        V.add(int(temp3[0]));
      }
    } else {
      V.add(int(temp2[1]));
      V.add(int(temp3[0]));
    }
  }
  
  matrix = new int [V.size()][E.size()];
  
}
boolean start = false;

int count = 0;

boolean end = false;

void draw(){
  background(255);
  if(!start){
    start = true;
    definition();
  }
  
  if(count < E.size()){
  
  //行列基本変形を書く
  if(matrix[count][count] == 1){
    raw_modify();
  }
  
  
  if(matrix[count][count] == -1){
    reverse();
  }
  
  if(matrix[count][count] == 0){
    if(line_change()){
    } else if(raw_change()){
    } else if(saigo()){
    } else {
      end = true;
    }
  }
  
  
  //その列の処理が完了しているか確認する
  if(raw_check()) count++;
  } else {
    end = true;
  }
  
  drawing();
  
}

boolean saigo(){
  boolean temp = false;
  for(int i = count+1; i < V.size(); i++){
    int count = 0;
    for(int j = 0; j < E.size(); j++){
      if(matrix[i][j] == 0){
      } else {
        count++;
      }
    }
    if(count == 1){
      
      //ここを落ち着いて書き直す
      
      for(int n = 0; n < V.size(); n++){
        if(matrix[n][i] != 0 && i != n){
          int aa = matrix[n][i];
          for(int m = 0; m < E.size(); m++){
            matrix[n][m] = matrix[n][m] - aa*matrix[i][n];
          }
        }
      }
      temp = true;
    }
  }
  return temp;
}

boolean raw_change(){
  boolean temp = false;
  for(int i = count+1; i < E.size(); i++){
    if(matrix[count][i] == -1 || matrix[count][i] == 1){
      temp = true;
      for(int j = 0; j < V.size(); j++){
        int temp2 = matrix[j][count];
        matrix[j][count] = matrix[j][i];
        matrix[j][i] = temp2;
      }
      break;
    }
  }
  return temp;
}

boolean line_change(){
  boolean temp = false;
  for(int i = count+1; i < V.size(); i++){
    if(matrix[i][count] == -1 || matrix[i][count] == 1){
      temp = true;
      for(int j = 0; j < E.size(); j++){
        int temp2 = matrix[count][j];
        matrix[count][j] = matrix[i][j];
        matrix[i][j] = temp2;
      }
      break;
    }
  }
  return temp;
}

void raw_modify(){
  for(int i = 0; i < V.size(); i++){
    if(matrix[i][count] != 0 && i != count){
      int temp = matrix[i][count];
      for(int j = 0; j < E.size(); j++){
        matrix[i][j] = matrix[i][j] - temp*matrix[count][j];
      }
    }
  }
}

void reverse(){
  for(int i = 0; i < E.size(); i++){
    matrix[count][i] = -matrix[count][i];
  }
}

boolean raw_check(){
  boolean check = true;
  if(matrix[count][count] != 1) check = false;
  for(int i = 0; i < V.size(); i++){
    if(matrix[i][count] != 0){
      if(i == count){
      } else {
        check = false;
      }
    }
  }
  return check;
}

void drawing(){
  textAlign(CENTER);
  for (int i = 0; i < E.size(); i++) {
    for (int j = 0; j < V.size(); j++) {
      fill(0);
      text(matrix[j][i], 15*i+20, 15*j+20);
    }
  }
  if(end){
    //H1から，グラフに輪が何個あるか数える
  int circle = 0;
  
  for (int i = 0; i < E.size(); i++) {
    boolean check = true;
    if (matrix[i][i] != 1) check = false;
    for (int j = 0; j < V.size(); j++) {
      if (matrix[j][i] != 0) {
        if (j == i) {
        } else {
          check = false;
        }
      }
    }
    
    if(check == false){
      circle = E.size() - i;
      break;
    }
    
  }
  textAlign(LEFT);
  text("グラフに含まれる輪の数は" + circle + "個", 20, 15*V.size()+20);
  
  println("グラフに含まれる輪の数は" + circle + "個");
  }
}

void definition(){
  
  for (int i = 0; i < E.size(); i++) {
    for (int j = 0; j < V.size(); j++) {
      if (E.get(i).x == V.get(j) || E.get(i).y == V.get(j)) {
        if (E.get(i).x == V.get(j)) {
          matrix[j][i] = -1;
        } else {
          matrix[j][i] = 1;
        }
      } else {
        matrix[j][i] = 0;
      }
    }
  }

  //行列が正しくできてるか確認用
  for (int i = 0; i < E.size(); i++) {
    for (int j = 0; j < V.size(); j++) {
      if (j == V.size()-1) {
        println(matrix[j][i]);
      } else {
        print(matrix[j][i]);
      }
    }
  }
}


  //for (int i = 0; i < V.size(); i++) {
    
  //  println("i="+i);

  //  if (i >= E.size()) {
  //    break;
  //  }

  //  int count = 1;
  //  boolean kakunin = false;
  //  while (kakunin == false) {
  //    boolean check = true;

  //    //ここに行基本変形をやるのを書く
  //    println(matrix[i][i]);

  //    if (matrix[i][i] == 1) {
  //      //print("1");
  //      for (int j = 0; j < V.size(); j++) {
  //        if (matrix[j][i] >= 1 && j != i) {
  //          int temppp = matrix[j][i];
  //          for (int k = 0; k < E.size(); k++) {
  //            matrix[j][k] = matrix[j][k] - abs(temppp)*matrix[i][k];
  //          }
  //        } else if (matrix[j][i] <= -1 && j != i) {
  //          int temppp = matrix[j][i];
  //          for (int k = 0; k < E.size(); k++) {
  //            matrix[j][k] = matrix[j][k] + abs(temppp)*matrix[i][k];
  //          }
  //        }
  //      }
  //    } else if (matrix[i][i] == -1) {
  //      //print("-1");
  //      for (int k = 0; k < E.size(); k++) {
  //        matrix[i][k] = -matrix[i][k];
  //      }
  //    } else {
  //      // if (matrix[i][i] == 0)
  //      //print("0");
  //      //println(matrix[i][i]);
  //      //println(i + "," + count);
  //      println(kakunin);
  //      if (i+count >= E.size()) {
  //        kakunin = true;
  //      }
  //      if (kakunin == false) {
  //        for (int l = 0; l < V.size(); l++) {
  //          int temp = matrix[l][i];
  //          matrix[l][i] = matrix[l][i+count];
  //          matrix[l][i+count] = temp;
  //        }
  //        count++;
  //        for (int l = V.size()-1; l > i; l--) {
  //          if (matrix[l][i] == -1 || matrix[l][i] == 1) {
  //            if(matrix[i][i] == 0){
  //            for (int k = 0; k < E.size(); k++) {
  //              matrix[i][k] = matrix[i][k] + matrix[l][k];
  //            }
  //            } else {
  //              int temprr = matrix[i][i];
  //              int tempaa = matrix[l][i];
  //              int aaaaa = tempaa-temprr;
  //              for (int k = 0; k < E.size(); k++) {
  //              matrix[i][k] = matrix[i][k] + aaaaa*matrix[l][k];
  //            }
  //            }
  //            break;
  //          }
  //        }
  //      }
          
  //    }

  //    //その列が完了してるかチェック
  //    if (matrix[i][i] != 1) check = false;
  //    for (int j = 0; j < V.size(); j++) {
  //      if (matrix[j][i] == 0) {
  //      } else {
  //        if (j == i) {
  //        } else {
  //          check = false;
  //        }
  //      }
  //    }

  //    if (check == true) {
  //      //行列が正しくできてるか確認用
  //      println();
  //      for (int n = 0; n < E.size(); n++) {
  //        if(n<10) print(" ");
  //        print(n+":");
  //        for (int m = 0; m < V.size(); m++) {
  //          if(matrix[m][n] >= 0) print(" ");
  //          if (m == V.size()-1) {
  //            println(matrix[m][n]);
  //          } else {
  //            print(matrix[m][n]+",");
  //          }
  //        }
  //      }
  //      break;
  //    }
  //  }
  //}

  ////行列が正しくできてるか確認用
  //println();
  //for (int i = 0; i < E.size(); i++) {
  //  print(i+":");
  //  for (int j = 0; j < V.size(); j++) {
  //    if (j == V.size()-1) {
  //      println(matrix[j][i]);
  //    } else {
  //      print(matrix[j][i]);
  //    }
  //  }
  //}

  ////H1から，グラフに輪が何個あるか数える
  //int circle = 0;
  
  //for (int i = 0; i < E.size(); i++) {
  //  boolean check = true;
  //  if (matrix[i][i] != 1) check = false;
  //  for (int j = 0; j < V.size(); j++) {
  //    if (matrix[j][i] == 0) {
  //    } else {
  //      if (j == i) {
  //      } else {
  //        check = false;
  //      }
  //    }
  //  }
    
  //  if(check == false){
  //    circle = E.size() - i;
  //    break;
  //  }
    
  //}
  
  //println("グラフに含まれる輪の数は" + circle + "個");
 
