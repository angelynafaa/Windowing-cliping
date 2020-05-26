int line_num = 10;
int inside=0, left=2, right=3, bottom=8, top=16;
int x_max=450, y_max=400, x_min=150, y_min=200;

int findkode(double x, double y) {
  int kode = inside;

  if (x < x_min){
    kode = kode|left;}
  else if (x > x_max){
    kode = kode|right;}
    
  if (y < y_min){
    kode = kode|top;}
  else if (y > y_max){
    kode = kode|bottom;}

  return kode;
}

void garis_clipping(double x1, double y1, double x2, double y2) {
  
 
  int kode1 = findkode(x1, y1);
  int kode2 = findkode(x2, y2);

  print(x1 + " " + y1 + " ");
  println(kode1);
  print(x2 + " " + y2 + " ");
  println(kode1);
  
  boolean line = false;

  while (true) {
    if ((kode1==0) && (kode2==0)) {
      line=true;
      break;
    } else if ((kode1 & kode2)!=0) {
      break;
    } else {
      int result;
      double x=0, y=0;

      if (kode1!=0)
        result = kode1;
      else
        result = kode2;

      if ((result & bottom)!=0) {
        x = x1 + (x2 - x1) * (y_max - y1) / (y2 - y1); 
        y = y_max;
      } else if ((result & top)!=0) 
      {  
        x = x1 + (x2 - x1) * (y_min - y1) / (y2 - y1); 
        y = y_min;
      } else if ((result & right)!=0) 
      {  
        y = y1 + (y2 - y1) * (x_max - x1) / (x2 - x1); 
        x = x_max;
      } else if ((result & left)!=0) 
      {  
        y = y1 + (y2 - y1) * (x_min - x1) / (x2 - x1); 
        x = x_min;
      }

      if (result==kode1) {
        x1 = x;
        y1 = y;
        kode1 = findkode(x1, y1);
      } else {
        x2 = x;
        y2 = y;
        kode2 = findkode(x2, y2);
      }
    }
  }
  
  //criping area
  if(line==true){
    stroke(255, 0, 0);
    strokeWeight(2);
    stroke(255, 0, 0);
    line((float)x1, (float)y1, (float)x2, (float)y2);
  }
}


  void setup() {

    size(600, 600);
  }
  
void draw(){
  
    frameRate(1);
    background(51);
    strokeWeight(2);
    stroke(255);
    rectMode(CENTER);
    noFill();
    rect(width/2, height/2, 300, 200);

    strokeWeight(1.0);
    //pengulangan bua munculin garis
 for (int i=0; i<line_num; i++) {
      int x1 = int(random(0, width));
      int y1 = int(random(0, width));
      int x2 = int(random(0, height));
      int y2 = int(random(0, height));
      

      strokeWeight(0);
      stroke(255);
      line(x1, y1, x2, y2);
      garis_clipping(x1, y1, x2, y2);
    
    }



}
  
