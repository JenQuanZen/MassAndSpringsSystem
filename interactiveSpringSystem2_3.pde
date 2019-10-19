float r = 0.95;
float g = 0.05;
float vDamping = 0.8; // viscous damping constant
float springDamping = 15; // spring damping
// < decrease amount of damping > increase
float t = 0;
float dt = 0.5;
float phase = 0;
float frequency = 50;

MBall B1, B2;
ArrayList<MBall> balls = new ArrayList<MBall>();
ArrayList<Spring> springs = new ArrayList<Spring>();
ArrayList<oscillatingSpring> oSprings = new ArrayList<oscillatingSpring>();

boolean simulationFlag = true;
boolean gravity = false;
boolean viscousDamping = true;
boolean creationMode = true;
boolean dragMode = false;
boolean oscillating = false;


void setup() {
  size(2400,1800);
  background(255);
}
void draw(){
  drawAndUpdate();
}

void drawAndUpdate() {
  background(255);
  collide();
  fill(0);
  textSize(36);
  text("simulation flag = " + simulationFlag, 2010, 54);
  text("gravity = " + gravity, 2100, 96); 
  text("viscous damping = " + viscousDamping, 1980, 132);
  text("creation mode = " + creationMode, 2010, 174);
  text("oscillating spring = " + oscillating, 1950, 216);
  
  for (int i = 0; i < balls.size(); i ++) {
    if (balls.size() > 0) {
    balls.get(i).fx = 0;
    balls.get(i).fy = 0;
    }
  }
  if (springs.size() > 0) {
    for (int i = 0; i < springs.size(); i++){
    if (simulationFlag == true) {
      springs.get(i).update(); 
    }
  }
  }
  if (oSprings.size() > 0) {
    for (int i = 0; i < oSprings.size(); i++) {
      if (simulationFlag == true) {
        oSprings.get(i).update();
      }
    }
  }
  
  for (int i = 0; i < balls.size(); i++){
    if (balls.size() > 0){
    if (simulationFlag == true) {
    balls.get(i).update();
    }
    }
  }
  
  
  if (springs.size() > 0) {
    for (int i = 0; i < springs.size(); i++){
    springs.get(i).display();
  }
  }
    if (oSprings.size() > 0) {
    for (int i = 0; i < oSprings.size(); i++) {
        oSprings.get(i).display();
      
    }
  }
  
  for (int i = 0; i < balls.size(); i++){
    if (balls.size() > 0){
    balls.get(i).display();
    }
  }
  
  t += dt;

}

void keyPressed() {
  if (key == ' ') {
    simulationFlag = !simulationFlag;
  }
  else if (key == 's') {
    simulationFlag = true;
    drawAndUpdate();
    simulationFlag = false;
  }
  else if (key == 'g') {
    gravity = !gravity;
  }
  else if (key == 'v') {
    viscousDamping = !viscousDamping;
  }
  else if (key == ',') {
    springDamping -= 0.2;
    println(springDamping);
  }
  else if (key == '.') {
    springDamping += 0.2;
    println(springDamping);
  }
  else if (key == 'm') {
    creationMode = !creationMode;
  }
  else if (key == 'o') {
    oscillating = !oscillating;
  }
}

void mousePressed() {
  B1 = null;
  for (int i = 0; i < balls.size() - 1; i ++) {
    float distance = sqrt(sq(balls.get(i).x - mouseX) + sq(balls.get(i).y - mouseY));
    if (distance <=20)  {
      if (creationMode == true) {
      B1 = balls.get(i);
      }
      else {
        B1 = balls.get(i);
        B1.x = mouseX;
        B1.y = mouseY;
        dragMode = true;
      }
  }
}
}

void mouseDragged() {
  if (creationMode == false && dragMode == true && B1 != null) {
    B1.x = mouseX;
    B1.y = mouseY;
  }
}

void mouseReleased(){
  if (B1 == null) {
    balls.add(new MBall(mouseX, mouseY, 0, 0, random(20,60), random(0,255), random(0,255), random(0,255)));
    return;
  }
  B2 = null;
  for (int i = 0; i < balls.size(); i ++) {
    float distance = sqrt(sq(balls.get(i).x - mouseX) + sq(balls.get(i).y - mouseY));
    if (distance <=20) {
      if (creationMode == true) {
        B2 = balls.get(i);
      }
      else {
        B1.x = mouseX;
        B1.y = mouseY;
      }
    }
  }
  
  if (B1 != null && B2 != null) {
    if (oscillating == false) {
      springs.add(new Spring(B1, B2, sqrt(sq(B1.x - B2.x) + sq(B1.y - B2.y))));
    }
    if (oscillating == true) {
      oSprings.add(new oscillatingSpring(B1, B2, sqrt(sq(B1.x - B2.x) + sq(B1.y - B2.y))));
      phase += Math.PI;
    }
  }
  
}

void collide(){
  if (balls.size() > 1) {
  for (int i = 0; i < balls.size() - 1; i ++) {
    for (int j = i + 1; j < balls.size(); j ++) {
    float dx = balls.get(i).x - balls.get(j).x;
    float dy = balls.get(i).y - balls.get(j).y;
    float distance = abs(sqrt(dx*dx + dy*dy));
    float bump = balls.get(i).size/2 + balls.get(j).size/2;
    if (distance <= bump) {
      float theta = atan2(dy, dx);
      float endX = balls.get(i).x + cos(theta)*bump;
      float endY = balls.get(i).y + sin(theta)*bump;
      balls.get(i).vx = (endX - balls.get(j).x)/(balls.get(i).size * dt);
      balls.get(i).vy = (endY - balls.get(j).y)/(balls.get(i).size * dt);
      balls.get(j).vx = (balls.get(j).x - endX)/(balls.get(j).size * dt);
      balls.get(j).vy = (balls.get(j).y - endY)/(balls.get(j).size * dt);
    }
    }
    
  }
  }
}
