Starfield starfield;
Boss boss;
Ship ship;
PFont font;
boolean gameover;

//
void setup() {
  size(480, 640);
  frameRate(30);
  //noCursor();        // clear mouse cursor
  rectMode(CENTER); // center mode
  
  starfield = new Starfield(100);
  ship = new Ship();
  boss = new Boss(width / 2, 60, 40);
  
  font = createFont("FFScala", 24);
  textFont(font);
  
  gameover = false;
}
//
class Ship {
  PImage img;
  int hp;
  int sx, sy;
  ArrayList laser;
  
  Ship() {
    img = loadImage("spaceship.png");
    hp = 255;
    sx = mouseX;
    sy = mouseY;
    laser = new ArrayList(); 
  }
  
  void hit() {
    hp -= 32;
    if (hp <= 0)
      gameover = true;
  }
  //
  void update(int x, int y) {
    sx = x;
    sy = y;
    pushMatrix();
    translate(sx,sy);
    image(img,-img.width/2,-img.height/2);
    popMatrix();
    //stroke(255,255,255);
    //fill(255 - hp, 0, 0);
    //triangle(sx, sy - 7, sx - 10, sy + 7, sx + 10, sy + 7);
  
    if (mousePressed) {
      stroke(0,0,255);
      line(sx, sy - 7, sx, 0);
      if (abs(sx - boss.bx) < (boss.bw / 2))
        boss.hit();
    }
  }
}
//
class Tama {
  PImage img;
  float tx, ty, tr, dx, dy;
  color tc;
  Tama(float x, float y, float r, float ldx, float ldy, color c, String file) {
    img = loadImage(file);
    tx = x;
    ty = y;
    tr = r;
    dx = ldx;
    dy = ldy;
    tc = c;
  }
  
  boolean update() {
    tx += dx;
    ty += dy;
    pushMatrix();
    translate(tx,ty);
    image(img,-img.width/2,-img.height/2);
    popMatrix();
    //noFill();
    stroke(tc);
    //ellipse(tx, ty, tr, tr);

    // area check 
    if (ty > height || ty < 0 || tx > width || tx < 0) {
        return false;
    }
    // hit check
    if (dist(tx, ty, ship.sx, ship.sy) < (tr / 2) ) {
      ship.hit();
      return false;
    }
    
    return true;
  }
}
//
class Boss {
  PImage img;
  int hp, bw;
  float bx, by, bcx;
  ArrayList danmaku;
 
  Boss(float x, float y, int w) {
    img = loadImage("enemy_red.png");
    bx = bcx = x;
    by = y;
    bw = w;
    hp = 256;
    danmaku = new ArrayList(); 
  }
  //
  void hit() {
    hp--;
    if (hp <= 0) 
      gameover = true;
  }
  // get_normalv
  PVector get_normalV(float vx, float vy) {
    PVector v = new PVector(vx, vy);
    v.normalize();

    return v;
  }

  //
  void fire_360(float x, float y) {  
    for (int i = 0; i < 360; i+= 10) { 
      float rad = radians(i);
      danmaku.add(new Tama(x, y, 14, cos(rad) * 1.5, sin(rad) * 1.5, #ffff00, "bullet_enemy.png"));
    }
  }
  //
  void fire_slow(float x, float y) {
    PVector v = get_normalV(ship.sx - x, ship.sy - y);
    danmaku.add(new Tama(x, y, 70, v.x * 4, v.y * 4, #ff00ff, "bullet_enemy.png"));
  }
  // 
  void fire_fast(float x, float y) {
    PVector v = get_normalV(ship.sx - x, ship.sy - y);
    danmaku.add(new Tama(x, y, 10, v.x * 8, v.y * 8, #ff0000, "bullet_enemy.png"));
  }
  
  //
  void update() {
    // boss update
    float dx;
    dx = 75.0 * sin(radians(frameCount * 6));
    bx = bcx + dx;
    
    pushMatrix();
    translate(bx,by);
    image(img,-img.width/2,-img.height/2);
    popMatrix();
    //stroke(0,255,0);
    //fill(256 - hp, 0, 0);
    //rect(bx, by, bw, 20);
   
    // fire
    if (frameCount % 30 == 0)
      fire_360(bx, by);
    if (hp > 192) {
      // 
    } else if (hp > 128) {
      if (frameCount % 20 == 0)
        fire_slow(bx, by);
    } else if (hp > 64) {
      if (frameCount % 10 == 0)
        fire_fast(bx, by);
    } else if (hp > 0) {
      if (frameCount % 20 == 0)
        fire_slow(bx, by);
      if (frameCount % 10 == 0)
        fire_fast(bx, by);
    }
   
    // danmaku update
    for (int i = danmaku.size() -1; i >= 0; i--) {
      Tama t = (Tama)danmaku.get(i);
      if (t.update() == false)
        danmaku.remove(i);
    }
  }
}
// print time
void print_time() {
  float ft = (float)millis() / 1000;
  
  textAlign(RIGHT);
  text(nf(ft, 1, 2), width, 24);
}

//
void draw() {
  if (gameover) {  // game over
    textAlign(CENTER);
    if (ship.hp <= 0) {
      fill(255, 255, 255);  // blue
      text("YOU LOSE", width / 2, height / 2);
    } else {
      fill(255 * sin(frameCount), 255, 255 * cos(frameCount));  // red
      text("YOU WIN!", width / 2, height / 2);
    }
  } else {
    background(0); // clear
    starfield.draw();
    ship.update(mouseX, mouseY - 120);
    boss.update();
    
    fill(255, 255, 255); 
   
    print_time();
  }
}
			
