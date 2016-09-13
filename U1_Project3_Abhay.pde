PVector crosshair;
PVector target;
PVector start;

float inaccuracy = 20;
int cursorSize = 5;

float range = 4000;

ArrayList<Bullet> b = new ArrayList<Bullet>();

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

  background(0);

  pushMatrix();
  translate(width/2, height/2, -range/2);
  noFill();
  stroke(255);
  box(width, height, range);
  popMatrix();

  ellipse(crosshair.x, crosshair.y, 5, 5);
  rect(crosshair.x - cursorSize/2, crosshair.y + cursorSize*2, cursorSize, inaccuracy - cursorSize);
  rect(crosshair.x - cursorSize/2, crosshair.y - inaccuracy - cursorSize, cursorSize, inaccuracy - cursorSize);
  rect(crosshair.x - inaccuracy - cursorSize, crosshair.y - cursorSize/2, inaccuracy - cursorSize, cursorSize);
  rect(crosshair.x + cursorSize*2, crosshair.y - cursorSize/2, inaccuracy - cursorSize, cursorSize);

  for (int i = 0; i < b.size(); i++)
  {
    b.get(i).display();
    b.get(i).move();

    if (b.get(i).pos.z < -(range))
    {
      b.get(i).kill = true;

      if (b.get(i).kill)
      {
        b.remove(i);
      }
    }
    
    println(b.size());
  }
}

void mousePressed()
{
  b.add(new Bullet(crosshair, target));
}