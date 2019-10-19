class MBall{
  float x;
  float y;
  float vxi;
  float vyi;
  float vx;
  float vy;
  float size;
  float color1;
  float color2;
  float color3;
  float fx, fy;
  
  MBall(float ix, float iy, float ivxi, float ivyi, float isize, float icolor1, 
  float icolor2, float icolor3){
    x = ix;
    y = iy;
    vxi = ivxi;
    vyi = ivyi;
    vx = vxi;
    vy = vyi;
    size = isize;
    color1 = icolor1;
    color2 = icolor2;
    color3 = icolor3;
  }
  
  void update(){
    if (vxi > 0){
      if (x >= width-1) {
        if (vx > 0){
        vx = -vxi*r;
        vy*=r;
        }
      }
      if (x <=0) {
        if (vx < 0) {
        vx = vxi*r;
        vy *=r;
        }
      }
    }
    else {
      if (x >= width- 1) {
        if (vx > 0){
        vx = vxi*r;
        vy *=r;
        }
      }
      if (x <=0) {
        if (vx < 0){
        vx = -vxi*r;
        vy *=r;
        }
    } 
    }
    if (vyi > 0) { 
      if (y >= height -1) {
        if (vy > 0) {
          vy = -vyi*r;
          vx *=r;
          y = height - 1;
        }
    }
      if (y <=0) {
        if (vy < 0){
        vy = vyi*r;
        vx *=r;
        }
    }
    }
    else {
      if (gravity == true) {
      if (y + g >= height -1) {
        if (vy > 0) {
          vy = vyi*r;
          vx *=r;
          y = height - 1;
        }
    }
      }
      if (gravity == false) {
        if (y >= height -1) {
        if (vy > 0) {
          vy = vyi*r;
          vx *=r;
          y = height - 1;
        }
    }
      }
      if (y <=0) {
        if (vy < 0) {
        vy = -vyi*r;
        vx *=r;
        }
    }
    }
    if (viscousDamping == true) {
    fx -= vDamping * vx;
    fy -= vDamping * vy;
    }
    float mass;
    mass = size * size;
    float ax = fx/mass;
    float ay = fy/mass;
    if (gravity == true) {
    ay += g;
    }
    vx += ax * dt;
    vy += ay * dt;
    vxi = vx;
    vyi = vy;
    x += vx * dt;
    y += vy * dt;
  
  }
  
  void display(){
    stroke(color1, color2, color3);
    fill(color1, color2, color3);
    ellipse(x,y,size,size);
  }
  }