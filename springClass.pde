class Spring{
  float k = 5;
  float restLength;
  MBall b1, b2;
  
  Spring(MBall ball1, MBall ball2, float irestLength){
    b1 = ball1;
    b2 = ball2;
    restLength = irestLength;
  }
  void update() {
    if (springs.size() > 0) {
    float dist = (sqrt(sq(b1.x - b2.x) + sq(b1.y - b2.y)));
    float diff = dist - restLength;
    float forceX;
    float forceY;
    float xL = (b2.x - b1.x)/dist;
    float yL = (b2.y - b1.y)/dist;
    forceX = k * diff;
    forceY = k * diff;
    
    // spring damping force
    float fDamping;
    float LdotX = b2.vx - b1.vx;
    float LdotY = b2.vy - b1.vy;
    fDamping = springDamping * (LdotX * xL + LdotY * yL);
    b1.fx += (forceX + fDamping) *  xL;
    b2.fx += -(forceX + fDamping) * xL;
    b1.fy += (forceY + fDamping) * yL;
    b2.fy += -(forceY + fDamping) * yL;
    
    
    
    }
  }
 
  void display() {
    if (springs.size() > 0) {
    stroke(0);
    line(b1.x, b1.y, b2.x, b2.y);
    }
  }
}