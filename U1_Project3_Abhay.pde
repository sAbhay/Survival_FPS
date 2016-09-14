PVector crosshair;
PVector target;
PVector start;

float inaccuracy = 20;
int cursorSize = 5;

float range = 4000;

ArrayList<Bullet> b = new ArrayList<Bullet>();
ArrayList<Enemy> e = new ArrayList<Enemy>();

void setup()
{
  fullScreen(P3D);
  noCursor();
}

void draw()
{ 
  crosshair = new PVector(mouseX, mouseY, 0);
  target = new PVector(crosshair.x, crosshair.y, range);
  start = new PVector(width/2, height/2 + height/3, 0);

  if (e.size() < 10)
  {
    e.add(new Enemy(random(width), random(height/1.5), -range, 0, 0, random(20), random(40, 60), random(60, 80)));
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
  rect(0, 0, width, height);
  popMatrix();

  pushMatrix();
  translate(0, height -range);
  rotateX(PI/2);
  fill(0, 255, 0, 10);
  rect(0, 0, width, range);
  popMatrix();

  noFill();
  ellipse(crosshair.x, crosshair.y, 5, 5);
  rect(crosshair.x - cursorSize/2, crosshair.y + cursorSize*2, cursorSize, inaccuracy - cursorSize);
  rect(crosshair.x - cursorSize/2, crosshair.y - inaccuracy - cursorSize, cursorSize, inaccuracy - cursorSize);
  rect(crosshair.x - inaccuracy - cursorSize, crosshair.y - cursorSize/2, inaccuracy - cursorSize, cursorSize);
  rect(crosshair.x + cursorSize*2, crosshair.y - cursorSize/2, inaccuracy - cursorSize, cursorSize);

  for (int i = 0; i < b.size(); i++)
  {
    b.get(i).display();
    b.get(i).move();
    b.get(i).checkIfHit();

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

    if (e.get(i).killed)
    {
      e.remove(i);
    }
  }
}

void mousePressed()
{
  b.add(new Bullet(crosshair, target));
}