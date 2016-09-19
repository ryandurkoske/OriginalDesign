int[] coll;
final int screenWidth = 900, screenHeight = 750;
final float tileSize = 25;
ArrayList<Shape> shapeBuffer = new ArrayList<Shape>();

void setup(){
  size(screenWidth,screenHeight);
  frameRate(60);
  //colorMode(RGB,255);
}

void tick(){
 for(Shape s : shapeBuffer)
    s.tick();
}

void draw(){
  background(150);
  tick();
  drawGrid();
  for(Shape s : shapeBuffer)
    s.render();
}

void mouseDragged(){
  if(mouseX < screenWidth && mouseY < screenHeight && mouseX >= 0 && mouseY >= 0){
    int x = (int) Math.floor(mouseX - (mouseX % tileSize));
    int y = (int) Math.floor(mouseY - (mouseY % tileSize));
    if(mouseButton == LEFT){
      for(int i = shapeBuffer.size()-1; i >= 0; i--){
        if(shapeBuffer.get(i).x == x && shapeBuffer.get(i).y == y ){
          println("delete");
          shapeBuffer.remove(i);
        }
      }
      Square s = new Square(x,y,true,new int[]{255,255,255});
      shapeBuffer.add(s);
    }
    if(mouseButton == RIGHT){
      for(int i = shapeBuffer.size()-1; i >= 0; i--){
        if(shapeBuffer.get(i).x == x && shapeBuffer.get(i).y == y ){
          println("delete");
          shapeBuffer.remove(i);
        }
      }
    }
  }  
}
void mousePressed(){
  if(mouseX < screenWidth && mouseY < screenHeight && mouseX >= 0 && mouseY >= 0){
    int x = (int) Math.floor(mouseX - (mouseX % tileSize));
    int y = (int) Math.floor(mouseY - (mouseY % tileSize));
    if(mouseButton == LEFT){
      for(int i = shapeBuffer.size()-1; i >= 0; i--){
        if(shapeBuffer.get(i).x == x && shapeBuffer.get(i).y == y ){
          println("delete");
          shapeBuffer.remove(i);
        }
      }
      Square s = new Square(x,y,true,new int[]{255,255,255});
      shapeBuffer.add(s);
    }
    if(mouseButton == RIGHT){
      for(int i = shapeBuffer.size()-1; i >= 0; i--){
        if(shapeBuffer.get(i).x == x && shapeBuffer.get(i).y == y ){
          println("delete");
          shapeBuffer.remove(i);
        }
      }
    }
  }
  for(int i = 0; i < shapeBuffer.size(); i++){
   shapeBuffer.get(i).released = 1;
 } 
}
void keyReleased(){
 for(int i = 0; i < shapeBuffer.size(); i++){
   shapeBuffer.get(i).released = 2;
 } 
}
void drawGrid(){
 for(int i = 0; i <= screenWidth; i++){
    if(i % tileSize == 0){
      line(i,0,i,screenHeight);
    }
  }
  for(int i = 0; i <= screenHeight; i++){
    if(i % tileSize == 0){
      line(0,i,screenWidth,i);
    }
  } 
}

public interface IEntity {
  public void tick();
  public void render();
}

public abstract class Shape implements IEntity{
 public int x,y;
 public boolean hasHitBox;
 public int[] c = {0,0,0};
 public float direction = 0;
 public byte released;
 public int tempX = 0, tempY = 0;
 public Shape(int x , int y, boolean hasHitBox, int[] c){
    this.x = x;
    this.y = y;
    this.hasHitBox = hasHitBox;
    this.c = c;
 }
 
}

public class Square extends Shape{
 
 public Square(int x , int y,boolean hasHitBox,int[] c){
    super(x,y,hasHitBox,c);
 }
 public void tick(){
   for(int i = 0; i < this.c.length; i++){
     this.c[i] += (int) Math.floor(Math.random() * 5);
     if(this.c[i] > 255)
       this.c[i] = 0;
   }
   if(keyPressed){
     float change = 0;
     if(this.direction == 100){
      this.direction = atan2(this.y - mouseY,this.x - mouseX);
     }else{
       float dir = atan2(this.y - mouseY,this.x - mouseX);
       float touchAngle = degrees(dir);
       float angle = degrees(this.direction);
       if(angle < touchAngle) {
          if(abs(angle - touchAngle)<180)
             angle += (dist(mouseX,mouseY,this.x,this.y))/20;
          else angle -= (dist(mouseX,mouseY,this.x,this.y))/20;
        }else {
            if(abs(angle - touchAngle)<180)
               angle -= (dist(mouseX,mouseY,this.x,this.y))/20;
            else angle += (dist(mouseX,mouseY,this.x,this.y))/20;
        }
        this.direction = radians(angle);
     }
     this.x -= cos(this.direction)*10;
     this.y -= sin(this.direction)*10;
   }else if(this.x % tileSize != 0 || this.y % tileSize != 0){
     this.x -= this.x % tileSize;
     this.y -= this.y % tileSize;
   }
   if(this.released == 0){
       println("setting temp");
       this.tempX = this.x;
       this.tempY = this.y;
   }else if(this.released == 2){
     println("setting pos");
     this.x = this.tempX;
     this.y = this.tempY;
     this.direction = 100;
   }
   this.released = 0;
}
 public void render(){
  fill(this.c[0],this.c[1],this.c[2]);
  rect(x,y,tileSize,tileSize);
 } 
}
