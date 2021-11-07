// //<>// //<>// //<>// //<>//
//
//TODO - add a func for dist between pacman and ghost (ghost from pacman) and use it to check which route is better
//
//
int displayWidth = 540; //<>// //<>//
int displayHeight = 440;

int PlayerSpeed = 1;

Sprite player;
Sprite[] ghosts;

Rect wall;

int ghostUpdateRate = 0;

int wallW = 20;
int wallH = 20;

int scaleX = 20;
int scaleY = 20;

int numOfFood = 0;

Ellipse foods;

int startTime;
int totalTime = 5000;
boolean isGateOpen = false;
boolean isWon = false;
boolean isLost = false;

int dificulty = 8;

Text[] gameText;


void setup() 
{
  background(0, 0, 0);
  size(displayWidth, displayHeight);
  player = new Sprite(13, 8, 20, 20, "pacman.png");
  ghosts = new Sprite[3];
  ghosts[0] = new Sprite(14, 10, 20, 20, "blueghost.png");
  ghosts[1] = new Sprite(13, 10, 20, 20, "pinkghost.png");  
  ghosts[2] = new Sprite(12, 10, 20, 20, "redghost.png");

  wall = new Rect();
  foods = new Ellipse();
  wall.width = wallW;
  wall.height = wallH;
  wall.brush = color(0, 0, 255);
  foods.radiusX = 5;
  foods.radiusY =5;
  foods.brush = color(255);
  initMapAndDraw (map, wall);
  player.display();

  startTime = millis();

  gameText = new Text[2];

  gameText[0] = new Text();
  gameText[1] = new Text();

  loadText();

  gameText[0].text = "you lost";
  gameText[1].text = "you won";
}

void printGhosts()
{
  for (int i=0; i<ghosts.length; i++)
  {
    ghosts[i].display();
  }
}

void draw() 
{
  if (isWon == false)
  {
    int passedTime = millis() - startTime;

    if (passedTime > totalTime) {
      if (isGateOpen == false)
      {
        isGateOpen = true;
        releaseGate();
        ghosts[0].moveUp();
        ghosts[0].moveUp();
        ghosts[1].moveUp();
        ghosts[1].moveUp();
        ghosts[2].moveUp();
        ghosts[2].moveUp();
        map[9][11] = 2;
        map[9][12] = 2;
        map[9][13] = 2;
        map[9][14] = 2;
        map[9][15] = 2;
        changeToBrarir();
      }
    }
    if (isGateOpen == true) 
    {

      if (ghostUpdateRate%dificulty == 0)
      {
        moveGhosts();
        drawBalls();
        printGhosts();

        ghostMovement(ghosts[0], player);
        ghostMovement(ghosts[1], player);
        ghostMovement(ghosts[2], player);
      }
    }
    checkIfEat();
    ghostUpdateRate++;
    checkForWin();
  }
}

void initMapAndDraw(int map [][], Rect rect)
{  
  for (int y=0; y<map.length; y++)
  {
    for (int x=0; x<map[y].length; x++)
    {
      if (map[y][x] == 1 )
      {
        rect.brush = color(0, 0, 255);
        rect.x = x*wallW;
        rect.y = y*wallH;
        rect.draw();
      }
      if (map[y][x] == 2 )
      {
        rect.x = x*wallW;
        rect.y = y*wallH;
        rect.brush = color(255);
        rect.draw();
      }

      if (map[y][x] == 5 )
      {
        numOfFood++;
        foods.x = x*scaleX+scaleX/2;
        foods.y = y*scaleY+scaleY/2; 
        foods.draw();
      }
    }
  }
}

void moveGhosts()
{
  for (int i = 0; i< ghosts.length; i++)
  {
    if (ghosts[i].getX() == player.getX()&&ghosts[i].getY() == player.getY())
    {
      isLost = true;
      background(0, 0, 0);
      gameText[0].draw();
    }
  }
}

void releaseGate()
{
  for (int y=0; y<map.length; y++)
  {
    for (int x=0; x<map[y].length; x++)
    {
      if (map[y][x] == 2 )
      {
        map[y][x] = 0;
        wall.x = x*wallW;
        wall.y = y*wallH;
        wall.brush = color(0);
        wall.draw();
        println(x, y);
      }
    }
  }
}


void keyPressed ()
{ 
  if (isLost == false)
  {
    int x, y;
    x = player.getX();
    y = player.getY();

    if (key == 'w') {
      if (map[(y-PlayerSpeed)][x]!=1)
      {
        player.moveUp();
      }
    }
    if (key == 's') {
      if (map[y + PlayerSpeed][x]!=1 && map[y+PlayerSpeed][x]!=2 )
      {
        player.moveDown();
      }
    }
    if (key == 'd') {
      if (map[y][(x+PlayerSpeed)]!=1 )
      {
        if (map[y][x+PlayerSpeed] == 4)
        {
          player.jumpTo(1, y);
        } else
        {
          player.moveRight();
        }
      }
    }
    if (key == 'a') {
      if (map[y][x-PlayerSpeed]!=1)
      {
        if (map[y][x-PlayerSpeed] == 3)
        {
          player.jumpTo(map[0].length-2, y);
        } else
        {
          player.moveLeft();
        }
      }
    }
  }
}

void checkIfEat()
{
  int x, y;
  x = player.getX();
  y = player.getY();

  // eat 
  if (map[y][x]==5)
  {
    map[y][x]=0;
    numOfFood--;
  }
}

void checkForWin()
{
  if (numOfFood==0)
  {
    isWon = true;
    gameText[1].draw();
  }
}

void drawBalls()
{
  for (int y=0; y<map.length; y++)
  {
    for (int x=0; x<map[y].length; x++)
    {
      if (map[y][x] == 5 )
      {
        foods.x = x*scaleX+scaleX/2;
        foods.y = y*scaleY+scaleY/2; 
        foods.draw();
      }
    }
  }
}
void loadText()
{
  for (int i=0; i<gameText.length; i++)
  {
    gameText[i].x = 200;
    gameText[i].y = 200;
    gameText[i].alpha = 255;
    gameText[i].textSize = 50;
    gameText[i].font = "Arial";
    gameText[i].brush = color(255, 255, 255);
  }
}
void ghostMovement(Sprite ghost, Sprite thePlayer)
{

  int gX = ghost.getX();
  int gY = ghost.getY();
  int pX = thePlayer.getX();
  int pY = thePlayer.getY();
  int move = (int)random(80000);
  if (move%4 == 0) {
    if (gY>pY)
      if (map[(gY-PlayerSpeed)][gX]!=1  && map[gY-PlayerSpeed][gX]!=2)
        ghost.moveUp(); 
    if (gY<pY) 
      //if (move%4 == 1) 
      if (map[gY + PlayerSpeed][gX]!=1 && map[gY+PlayerSpeed][gX]!=2 )
        ghost.moveDown();
  }

  if (move%4 == 2) 
    if (gX<pX) {
      if (map[gY][(gX+PlayerSpeed)]!=1 ) 
        if (map[gY][gX+PlayerSpeed] == 4)
          ghost.jumpTo(1, gY);
        else
          ghost.moveRight();
    }
  if (move%4 == 3) 
    if (gX>pX) {
      if (map[gY][gX-PlayerSpeed]!=1)
        if (map[gY][gX] == 3)
          ghost.jumpTo(map[0].length-2, gY);
        else
          ghost.moveLeft();
    }
}
void changeToBrarir()
{
  for (int y=0; y<map.length; y++)
  {
    for (int x=0; x<map[y].length; x++)
    {
      if (map[y][x] == 2 )
      {
        wall.x = x*wallW;
        wall.y = y*wallH;
        wall.brush = color(255);
        wall.draw();
      }
    }
  }
}
