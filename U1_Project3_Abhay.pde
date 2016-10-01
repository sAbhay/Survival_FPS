import damkjer.ocd.*;

PVector crosshair; // aim position
PVector target; // target position
PVector start; // bullet spawn position

float crosshairSize = 20; // size of complete reticule
int cursorSize = 5; // size of aiming point

float range = 5000; // furthest z possible

ArrayList<Bullet> b = new ArrayList<Bullet>();
ArrayList<Enemy> e = new ArrayList<Enemy>();

float health = 100;

float sensitivity = 15;

Camera camera;

void setup()
{
  fullScreen(P3D);
  noCursor();

  start = new PVector(width/2, height/2, 0);

  camera = new Camera(this, 0, 0, 0, -range, -range , 0);

  camera.pan(PI/2);
  camera.tilt(PI/4.5);
}

void draw()
{ 
  if (health < 100)
  {
    health += 0.025;
  }

  float d = dist(start.x, start.y, mouseX, mouseY)/sensitivity;

  crosshair = new PVector(mouseX, mouseY, -1000);
  target = new PVector(crosshair.x, crosshair.y, range);

  camera.feed();

  camera.truck(crosshair.x - pmouseX);
  camera.boom(crosshair.y - pmouseY);

  if (e.size() < 10)
  {
    e.add(new Enemy(random(width), random(height), -range, 0, 0, random(10), random(80, 100), random(100, 140)));
  }

  background(0);

  //draws the edges of the space
  pushMatrix();
  translate(width/2, height/2, -range/2);
  noFill();
  stroke(255);
  box(width, height, range);
  popMatrix();

  //draws the crosshair
  noFill();
  pushMatrix();
  translate(0, 0, crosshair.z);
  ellipse(crosshair.x, crosshair.y, 5, 5);
  rect(crosshair.x - cursorSize/2, crosshair.y + cursorSize*2, cursorSize, crosshairSize - cursorSize);
  rect(crosshair.x - cursorSize/2, crosshair.y - crosshairSize - cursorSize, cursorSize, crosshairSize - cursorSize);
  rect(crosshair.x - crosshairSize - cursorSize, crosshair.y - cursorSize/2, crosshairSize - cursorSize, cursorSize);
  rect(crosshair.x + cursorSize*2, crosshair.y - cursorSize/2, crosshairSize - cursorSize, cursorSize);
  popMatrix();

  //draws health bar
  fill(255);
  rect(50, 50, 200, 40);

  fill(0, 255, 0);
  rect(50, 50, health * 2, 40);

  textSize(32);
  fill(0);
  text((int) health + "%", 160, 80);

  for (int i = 0; i < b.size(); i++)
  {
    b.get(i).display();
    b.get(i).move();
    b.get(i).checkIfHit();

    stroke(255, 0, 0);
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
      health -= 20;

      e.remove(i);
    }

    if (i < 9)
    {
      if (e.get(i).killed)
      {
        e.remove(i);
      }
    }
  }

  // closes app when game ends
  if (health < 0)
  {
    //exit();
  }
  
  println(health);
}

void mousePressed()
{
  b.add(new Bullet(crosshair, target)); // add a new bullet starting at the center of the screen which aims towards the point the crosshair determines
}