int[] coll;
final int screenWidth = 900, screenHeight = 750;
final float tileSize = 10;
ArrayList<Shape> shapeBuffer = new ArrayList<Shape>();

void setup(){
  size(screenWidth,screenHeight);
  frameRate(60);
  //colorMode(RGB,255);
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

void tick(){
 for(Shape s : shapeBuffer)
    s.tick();
}

void draw(){
  tick();
  for(Shape s : shapeBuffer)
    s.render();
}

void mouseDragged(){
  Square s = new Square(Math.round(mouseX - (mouseX % tileSize)),Math.round(mouseY - (mouseY % tileSize)),true, new int[]{0,0,0});
  shapeBuffer.add(s);
}
public interface IEntity {
  public void tick();
  public void render();
}
public abstract class Shape implements IEntity{
 public int x,y;
 public boolean hasHitBox;
 public int[] c = {0,0,0};
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
     this.c[i] += (int) Math.floor(Math.random() * 10);
     if(this.c[i] > 255)
       this.c[i] = 0;
     if(this.c[i] < 0)
       this.c[i] = 0;
   }
 }
 public void render(){
  fill(this.c[0],this.c[1],this.c[2]);
  rect(x,y,tileSize,tileSize);
 } 
}
