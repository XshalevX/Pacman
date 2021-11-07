public class Sprite {
  private Image image;
  private String imagePath[];
  int x,y;
  /*
  final int IMAGE_UP = 0;
  final int IMAGE_DOWN = 0;
  final int IMAGE_RIGHT = 0;
  final int IMAGE_LEFT = 0;
*/
  public Sprite(int Px, int Py, int Pwidth, int Pheight, String imagePath) {
    this.x = Px;
    this.y = Py;
    image = new Image();
    this.image.x = Px*scaleX;
    this.image.y = Py*scaleY;
    this.image.speed = 0;
    this.image.width = Pwidth;
    this.image.height = Pheight;
    
    //imagePath = new String[4]();
    
    this.image.setImage(imagePath);
  }
  /*
    public Sprite(int Px, int Py, int Pwidth, int Pheight, String imageUpPath,String imageLeftPath,String imageRightPath,String imageDownPath) {
    this.x = Px;
    this.y = Py;
    this.image = new Image();
    this.image.x = Px*scaleX;
    this.image.y = Py*scaleY;
    this.image.speed = 0;
    this.image.width = Pwidth;
    this.image.height = Pheight;
    
    this.image.setImage(imagePath);
  }
*/
  public void display() 
  {
    this.image.x = x * scaleX;
    this.image.y = y * scaleY;
    removeFromScreen();
    this.image.drawIt();
  }

  public void removeFromScreen() 
  {
    fill(color(0, 0, 0));
    rect(image.x, image.y, this.image.width, this.image.height);
  }

  int getX()
  {
    return x;
  }
  
  int getY()
  {
    return y;
  }

  public void moveUp() 
  {
    //clean pacman from screen
    removeFromScreen();
    y -= 1;
    display();
  }

  public void moveDown() 
  {
    //clean pacman from screen
    removeFromScreen();
    y += 1;
    display();
  }
  
  public void moveRight() 
  { 
    //clean pacman from screen
    removeFromScreen();
    x += 1;
    display();
  }
  
  public void moveLeft() 
  {
    //clean pacman from screen
    removeFromScreen();
    x -= 1;
    display();
  }
  
  public void jumpTo(int x, int y) 
  {
    removeFromScreen();
    this.x = x;
    this.y = y;
    display();
  }
}
