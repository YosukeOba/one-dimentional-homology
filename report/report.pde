int[] pixel={
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  0, 0, 1, 1, 1, 1, 1, 0, 0, 0,
  0, 0, 1, 0, 1, 0, 1, 0, 0, 0,
  0, 0, 1, 0, 1, 1, 1, 0, 0, 0,
  0, 0, 1, 0, 1, 0, 1, 0, 0, 0,
  0, 0, 1, 1, 1, 1, 1, 0, 0, 0,
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0};


class Edge {
  int s, t;
  Edge(int _s, int _t) {
    s=_s;
    t=_t;
  }
}

ArrayList<Edge> edges;

void setup() {
  int w=10;
  int h=10;
  edges = new ArrayList<Edge>();
  for (int x=0; x<w; x++) {
    for (int y=0; y<h-1; y++) {
      int v1=x+y*w;
      int v2=x+(y+1)*w;
      if (pixel[v1]==1 && pixel[v2]==1) {
        edges.add(new Edge(v1, v2));
      }
    }
  }
  for (int x=0; x<w-1; x++) {
    for (int y=0; y<h; y++) {
      int v1=x+y*w;
      int v2=(x+1)+y*w;
      if (pixel[v1]==1 && pixel[v2]==1) {
        edges.add(new Edge(v1, v2));
      }
    }
  }
  for (Edge e : edges){
    println("("+e.s+","+e.t+")");
  }
}
