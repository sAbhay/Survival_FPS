class Bullet
{
  PVector pos;
  PVector dir;

  float speed;
  float size;

  boolean kill = false;

  Bullet()
  {
    size = 5;
    
    pos = new PVector(0, 0, 0);
    dir = new PVector(0, 0, 0);
    speed = 10;
  }

  Bullet(PVector _start, PVector _target)
  {
    size = 5; 
    speed = 100;
    
    pos = new PVector(_start.x, _start.y, _start.z);
    dir = new PVector(_target.x, _target.y, _target.z);
    
    dir = PVector.sub(_start, _target); 
    
    dir.normalize();
    dir.mult(speed);
  }
  
  void display()
  {
    pushMatrix();
    
    translate(pos.x, pos.y, pos.z);
    fill(255);
    stroke(255);
    sphere(size);
    
    popMatrix();
  }
  
  void move()
  {
   pos.add(dir); 
  }
  
  void checkIfHit()
  {
   for(int i = 0; i < e.size(); i++)
   {
    if (pos.z == e.get(i).z)
      {
        kill = true;
      } 
   }
  }
}