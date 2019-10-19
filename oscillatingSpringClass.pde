class oscillatingSpring{
  float k = 5;
  float restLength;
  MBall b1, b2;
  float new_restLength = restLength;
  
  oscillatingSpring(MBall ball1, MBall ball2, float irestLength){
    b1 = ball1;
    b2 = ball2;
    restLength = irestLength;
  }
  void update() {
    if (oSprings.size() > 0) {
    new_restLength = restLength + 0.1 * restLength * cos(t * frequency + phase);
    float dist = (sqrt(sq(b1.x - b2.x) + sq(b1.y - b2.y)));
    float diff = dist - new_restLength;
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
    if (oSprings.size() > 0) {
    stroke(150);
    line(b1.x, b1.y, b2.x, b2.y);
    }
  }
}