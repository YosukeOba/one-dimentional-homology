//課題7-2は"72.txt"，課題7-3は"73.txt"
String filename = "78.txt";

//頂点の種類を確認するためのArrayList
ArrayList<Integer> V = new ArrayList<Integer>();

//辺のデータを格納するArrayList
ArrayList<PVector> E = new ArrayList<PVector>();

void setup() {
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

  int [][] matrix = new int [V.size()][E.size()];

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

  for (int i = 0; i < V.size(); i++) {
    
    println("i="+i);

    if (i >= E.size()) {
      break;
    }

    int count = 1;
    boolean kakunin = false;
    while (kakunin == false) {
      boolean check = true;

      //ここに行基本変形をやるのを書く
      println(matrix[i][i]);

      if (matrix[i][i] == 1) {
        //print("1");
        for (int j = 0; j < V.size(); j++) {
          if (matrix[j][i] >= 1 && j != i) {
            int temppp = matrix[j][i];
            for (int k = 0; k < E.size(); k++) {
              matrix[j][k] = matrix[j][k] - abs(temppp)*matrix[i][k];
            }
          } else if (matrix[j][i] <= -1 && j != i) {
            int temppp = matrix[j][i];
            for (int k = 0; k < E.size(); k++) {
              matrix[j][k] = matrix[j][k] + abs(temppp)*matrix[i][k];
            }
          }
        }
      } else if (matrix[i][i] == -1) {
        //print("-1");
        for (int k = 0; k < E.size(); k++) {
          matrix[i][k] = -matrix[i][k];
        }
      } else {
        // if (matrix[i][i] == 0)
        //print("0");
        //println(matrix[i][i]);
        //println(i + "," + count);
        println(kakunin);
        if (i+count >= E.size()) {
          kakunin = true;
        }
        if (kakunin == false) {
          for (int l = 0; l < V.size(); l++) {
            int temp = matrix[l][i];
            matrix[l][i] = matrix[l][i+count];
            matrix[l][i+count] = temp;
          }
          count++;
          for (int l = V.size()-1; l > i; l--) {
            if (matrix[l][i] == -1 || matrix[l][i] == 1) {
              for (int k = 0; k < E.size(); k++) {
                matrix[i][k] = matrix[i][k] + matrix[l][k];
              }
              break;
            }
          }
        }
          
      }

      //その列が完了してるかチェック
      if (matrix[i][i] != 1) check = false;
      for (int j = 0; j < V.size(); j++) {
        if (matrix[j][i] == 0) {
        } else {
          if (j == i) {
          } else {
            check = false;
          }
        }
      }

      if (check == true) {
        //行列が正しくできてるか確認用
        println();
        for (int n = 0; n < E.size(); n++) {
          if(n<10) print(" ");
          print(n+":");
          for (int m = 0; m < V.size(); m++) {
            if(matrix[m][n] >= 0) print(" ");
            if (m == V.size()-1) {
              println(matrix[m][n]);
            } else {
              print(matrix[m][n]+",");
            }
          }
        }
        break;
      }
    }
  }

  //行列が正しくできてるか確認用
  println();
  for (int i = 0; i < E.size(); i++) {
    print(i+":");
    for (int j = 0; j < V.size(); j++) {
      if (j == V.size()-1) {
        println(matrix[j][i]);
      } else {
        print(matrix[j][i]);
      }
    }
  }

  //H1から，グラフに輪が何個あるか数える
  int circle = 0;
  
  for (int i = 0; i < E.size(); i++) {
    boolean check = true;
    if (matrix[i][i] != 1) check = false;
    for (int j = 0; j < V.size(); j++) {
      if (matrix[j][i] == 0) {
      } else {
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
  
  println("グラフに含まれる輪の数は" + circle + "個");
  
}
