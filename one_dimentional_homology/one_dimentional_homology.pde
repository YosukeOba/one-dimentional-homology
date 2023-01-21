//課題7-2は"72.txt"，課題7-3は"73.txt"
String filename = "73.txt";

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
        if (V.get(j) == int(temp2[1])){
          check = true;
        }
      }
      if(check == false){
        V.add(int(temp2[1]));
      }
      check = false;
      for (int j = 0; j < V.size(); j++) {
        if (V.get(j) == int(temp3[0])){
          check = true;
        }
      }
      if(check == false){
        V.add(int(temp3[0]));
      }
    } else {
      V.add(int(temp2[1]));
      V.add(int(temp3[0]));
    }
  }
  
  int [][] matrix = new int [V.size()][E.size()];
  
  for(int i = 0; i < E.size(); i++){
    for(int j = 0; j < V.size(); j++){
      if(E.get(i).x == V.get(j) || E.get(i).y == V.get(j)){
        if(E.get(i).x == V.get(j)){
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
  for(int i = 0; i < E.size(); i++){
    for(int j = 0; j < V.size(); j++){
      if(j == V.size()-1){
        println(matrix[j][i]);
      } else {
        print(matrix[j][i]);
      }
    }
  }
  
  for(int i = 0; i < V.size()-1; i++){
    while(true){
      boolean check = true;
      
      //ここに行基本変形をやるのを書く
      
      //その列が完了してるかチェック
      for(int j = 0; j < V.size(); j++){
        if(matrix[j][i] == 0 || matrix[i][i] == 1){
        } else {
          check = false;
        }
      }
      if(check == true){
        break;
      }
      
    }
  }
  
}
