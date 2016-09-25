import damkjer.ocd.*;

PImage background;

PVector crosshair;
PVector target;
PVector start;

float inaccuracy = 20;
int cursorSize = 5;

float range = 5000;

ArrayList<Bullet> b = new ArrayList<Bullet>();
ArrayList<Enemy> e = new ArrayList<Enemy>();

float sensitivity = 15;

Camera camera;

void setup()
{
  fullScreen(P3D);
  noCursor();

  start = new PVector(width/2, height/2, 0);

  camera = new Camera(this, start.x, start.y, start.z);
  camera.pan(PI/2);
  camera.tilt(PI/5);

  background = loadImage("background.jpg");
  background.resize((int) 8*width, (int) 8*height);
}

void draw()
{ 
  //camera.feed();

  float d = dist(start.x, start.y, mouseX, mouseY)/sensitivity;

  crosshair = new PVector(mouseX, mouseY, 0);
  target = new PVector(width - crosshair.x, height - crosshair.y, range/d);

  if (e.size() < 10)
  {
    e.add(new Enemy(random(width), random(height), -range, 0, 0, random(10), random(80, 100), random(100, 140)));
  }

  background(0);


  pushMatrix();
  translate(width/2, height/2, -range/2);
  noFill();
  stroke(255);
  box(width, height, range);
  popMatrix();


  pushMatrix();
  translate(0, 0, -range);
  fill(0, 255, 0);
  rect(-3.2*width, -3.2*height, 7.4*width, 7.4*height);
  image(background, -3.2*width, -3.2*height);
  popMatrix();

  pushMatrix();
  translate(0, height -range);
  rotateX(PI/2);
  fill(0, 255, 0, 10);
  rect(0, 0, width, range);
  popMatrix();

  noFill();
  pushMatrix();
  translate(0, 0, crosshair.z);
  ellipse(crosshair.x, crosshair.y, 5, 5);
  rect(crosshair.x - cursorSize/2, crosshair.y + cursorSize*2, cursorSize, inaccuracy - cursorSize);
  rect(crosshair.x - cursorSize/2, crosshair.y - inaccuracy - cursorSize, cursorSize, inaccuracy - cursorSize);
  rect(crosshair.x - inaccuracy - cursorSize, crosshair.y - cursorSize/2, inaccuracy - cursorSize, cursorSize);
  rect(crosshair.x + cursorSize*2, crosshair.y - cursorSize/2, inaccuracy - cursorSize, cursorSize);
  popMatrix();

  for (int i = 0; i < b.size(); i++)
  {
    b.get(i).display();
    b.get(i).move();
    b.get(i).checkIfHit();

    stroke(255, 0, 0);
    line(b.get(i).pos.x, b.get(i).pos.y, b.get(i).pos.z, start.x, start.y, start.z);
    stroke(255);

    if (b.get(i).pos.z < -(range))
    {
      b.get(i).kill = true;
    }

    if (b.get(i).kill)
    {
      b.remove(i);
    }
  }

  for (int i = 0; i < e.size(); i++)
  {
    e.get(i).display();
    e.get(i).move();
    e.get(i).checkIfDead(); 

    if (e.get(i).z > 100)
    {
      e.remove(i);
    }

    if (e.get(i).killed)
    {
      e.remove(i);
    }
  }
}

void mousePressed()
{
  b.add(new Bullet(start, target));
}